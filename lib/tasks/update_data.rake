namespace :data do
  desc "download master data and update the database"
  task :update => :environment do
    require 'net/http'
    require "nokogiri"

    [Room, Course, Teacher, Timeslot, Booking].each {|e| e.delete_all }

    load_bookings.each do |booking|
      next if booking[:room].empty?
      room = Room.find_by_name(booking[:room]) || Room.create(name: booking[:room], label: booking[:room].upcase.insert(2,'.'), building: booking[:room][0], floor: booking[:room][1])

      booking[:courses].each do |c|
        course_conditions = { name: c[:modul], group: c[:group] }
        course = Course.find(:first, conditions: course_conditions ) || Course.create(course_conditions.merge(label: get_modul_label(c[:modul])))
        c[:teachers].each do |t|
          teacher = Teacher.find_by_name(t) || Teacher.create(name: t, label: get_teacher_name(t) )

          day = Day.find_by_name booking[:day]
          time_conditions = { start_label: booking[:starttime], end_label: booking[:endtime], day_id: day.id }
          time = Timeslot.find(:first, conditions: time_conditions ) || Timeslot.create( time_conditions )

          conditions ={
                        room_id: room.id,
                        timeslot_id: time.id,
                        course_id: course.id,
                        teacher_id: teacher.id
                      }
          unless Booking.find(:first, conditions: conditions)
            Booking.create(conditions)
            p "[create: ]#{conditions}"
          end
        end
      end
    end
  end

  def mark_data_as_orphin
    #TODO
  end

  def delete_orphans
    #[Booking, Room, Timeslot, Course, Teacher].each {|m| m.delete_if{|e| e.orphan} }
  end

  def load_bookings
    xml = ''
    Timeout::timeout(5) do
      net = Net::HTTP.get_response(URI.parse('http://fi.cs.hm.edu/fi/rest/public/timetable/group.xml'))
      raise "HTTP Error: #{net.code}" if %w(404 500).include? net.code
      xml = Nokogiri::XML(net.body)
    end
    xml.xpath('/list/timetable/day/time/booking').map do |e|
      {
        starttime: e.xpath('starttime').text,
        endtime: e.xpath('stoptime').text,
        day: e.xpath('weekday').text,
        room: e.xpath('room').text,
        suffix: e.xpath('suffix').text,
        courses: e.xpath('courses/course').map do |c|
          {
            modul: c.xpath('modul').text,
            group: c.xpath('group').text,
            teachers: c.xpath('teacher').map{|t| t.text }
          }
        end
      }
    end
  rescue => e
    p e.message
    p e.backtrace
  end

  def get_modul_label(modul)
    xml = ''
    Timeout::timeout(5) do
      net = Net::HTTP.get_response(URI.parse("http://fi.cs.hm.edu/fi/rest/public/modul/title/#{modul}.xml"))
      raise "HTTP Error: #{net.code}" if %w(404 500).include? net.code
      xml = Nokogiri::XML(net.body)
    end
    xml.xpath('/modul/name').first.text
  rescue => e
    p e.message
    p e.backtrace
  end

  def get_teacher_name(teacher)
    xml = ''
    Timeout::timeout(5) do
      net = Net::HTTP.get_response(URI.parse("http://fi.cs.hm.edu/fi/rest/public/person/name/#{teacher}.xml"))
      raise "HTTP Error: #{net.code}" if %w(404 500).include? net.code
      xml = Nokogiri::XML(net.body)
    end
    person = xml.xpath('/person').first

    "#{person.xpath('title')} #{person.xpath('firstname')} #{person.xpath('lastname')}"
  rescue => e
    p e.message
    p e.backtrace
  end
end
