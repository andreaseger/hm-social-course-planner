namespace :data do
  desc "download master data and update the database"
  task :update => :environment do
    require 'net/http'
    require "nokogiri"

    print "[INFO] starting\n"

    print "[INFO] deleting old bookings\n"
    Booking.destroy_all
    [Booking, Teacher, Room, Course, Group, Timeslot, Lectureship].each do |c|
      print "[INFO] #{c.count} #{c.to_s.pluralize}\n"
    end

    print "[INFO] creating new bookings"
    begin
      fetch_timetables.each do |booking|
        tmp = booking.xpath('room').text
        next if tmp.empty?
        room = Room.find_by_name(tmp) || Room.create(name: tmp, label: tmp.upcase.insert(2,'.'), building: tmp[0], floor: tmp[1])

        booking.xpath('courses/course').each do |c|
          tmp = c.xpath('modul').text
          course = Course.find_by_name(tmp) || Course.create(name: tmp, label: get_modul_label(tmp) )

          day = Day.find_by_name(booking.xpath('weekday').text)
          binding.pry if day.nil?
          time_conditions = { start_label: booking.xpath('starttime').text,
                              end_label: booking.xpath('stoptime').text,
                              day_id: day.id }
          time = Timeslot.find(:first, conditions: time_conditions ) || Timeslot.create( time_conditions.merge( start_time: booking.xpath('starttime').text.gsub(':','').to_i,
                                                                                                                end_time: booking.xpath('stoptime').text.gsub(':','').to_i ) )

          group = Group.find_or_create_by_name(c.xpath('group').text)
          conditions ={
                        room_id: room.id,
                        timeslot_id: time.id,
                        course_id: course.id,
                        group_id: group.id,
                        suffix: booking.xpath('suffix').text
                      }
          teachers = c.xpath('teacher').map do |t|
            tmp = t.text
            Teacher.find_by_name(tmp) || Teacher.create(name: tmp, label: get_teacher_name(tmp) )
          end
          b = Booking.find( :first, conditions: conditions )
          if b.nil?
            b = Booking.new( conditions )
            b.teachers << teachers
            if b.save
              print '.'
            else
              binding.pry
              p b.errors
              exit 1
            end
          else
            teachers.each do |teacher|
              b.teachers << teacher unless b.teachers.include?(teacher)
            end
          end
        end
      end
      [Booking, Teacher, Room, Course, Group, Timeslot, Lectureship].each do |c|
        print "\n[INFO] #{c.count} #{c.to_s.pluralize}"
      end
    rescue => e
      print "\n[ERROR] main: #{e.message}"
      p e.backtrace
    end
  end

  def mark_data_as_orphin
    #TODO
  end

  def delete_orphans
    #[Booking, Room, Timeslot, Course, Teacher].each {|m| m.delete_if{|e| e.orphan} }
  end

  def get(url)
    Timeout::timeout(10) do
      net = Net::HTTP.get_response(URI.parse(url))
      raise "HTTP Error: #{net.code}" if %w(404 500).include? net.code
      xml = Nokogiri::XML(net.body)
    end
  end
  def fetch_timetables
    xml = get 'http://fi.cs.hm.edu/fi/rest/public/timetable/group.xml'
    return xml.xpath('/list/timetable/day/time/booking')
  rescue => e
    p "[ERROR] fetch_timetables: #{e.message}"
    p e.backtrace
    exit 1
  end

  def get_modul_label(modul)
    xml = get "http://fi.cs.hm.edu/fi/rest/public/modul/title/#{modul}.xml"
    xml.xpath('/modul/name').first.text
  rescue => e
    p "[ERROR] get_modul_label: #{e.message}"
    p e.backtrace
    exit 1
  end

  def get_teacher_name(teacher)
    xml = get "http://fi.cs.hm.edu/fi/rest/public/person/name/#{teacher}.xml"
    person = xml.xpath('/person').first

    "#{person.xpath('title').text} #{person.xpath('firstname').text} #{person.xpath('lastname').text}"
  rescue => e
    p "[ERROR] get_teacher_name: #{e.message}"
    p e.backtrace
    exit 1
  end
end
