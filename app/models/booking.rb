require 'ostruct'
class Booking < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :course
  belongs_to :room
  belongs_to :teacher

  WEEKDAYS={
            'mo' => { id: 0, name: 'Mo', label: 'Montag' },
            'di' => { id: 1, name: 'Di', label: 'Dienstag' },
            'mi' => { id: 2, name: 'Mi', label: 'Mittwoch' },
            'do' => { id: 3, name: 'Do', label: 'Donnerstag' },
            'fr' => { id: 4, name: 'Fr', label: 'Freitag' }
           }

  TIMESLOTS={
              '08:15' => { id: 0, label_start: '08:15', label_end: '09:45', starttime: 815,  endtime: 945 },
              '10:00' => { id: 1, label_start: '10:00', label_end: '11:30', starttime: 1000, endtime: 1130 },
              '11:45' => { id: 2, label_start: '11:45', label_end: '13:15', starttime: 1145, endtime: 1315 },
              '13:30' => { id: 3, label_start: '13:30', label_end: '15:00', starttime: 1330, endtime: 1500 },
              '14:00' => { id: 4, label_start: '14:00', label_end: '15:30', starttime: 1400, endtime: 1530 },
              '14:30' => { id: 5, label_start: '14:30', label_end: '16:00', starttime: 1430, endtime: 1600 },
              '15:45' => { id: 2, label_start: '15:45', label_end: '17:15', starttime: 1545, endtime: 1715 },
              '15:15' => { id: 6, label_start: '15:15', label_end: '16:45', starttime: 1515, endtime: 1645 },
              '16:15' => { id: 7, label_start: '16:15', label_end: '17:45', starttime: 1615, endtime: 1745 },
              '17:00' => { id: 8, label_start: '17:00', label_end: '18:30', starttime: 1700, endtime: 1830 },
              '18:45' => { id: 9, label_start: '18:45', label_end: '20:15', starttime: 1845, endtime: 2015 }
            }


  def day=(i)
    self.weekday_id = i
  end

  def day
    OpenStruct.new WEEKDAYS[weekday_id]
  end

  def timeslot=(i)
    self.timeslot_id = i
  end

  def timeslot
    OpenStruct.new TIMESLOTS[timeslot_id]
  end
end
