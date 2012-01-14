FactoryGirl.define do
  sequence :name do |n|
    "foo#{n}"
  end
  factory :course do
    name
    label "Lorem Ipsum"
  end
  factory :room do
    name
    label "Lorem Ipsum"
    building "r"
    floor 2
  end
  factory :group do
    name
  end
  factory :timeslot do
    sequence(:start_hour) { |n| n%24 }
    sequence(:end_hour) { |n| (n+1)%14 }
    sequence(:start_minute) { |n| [0,15,30,45][n%3] }
    sequence(:end_minute)   { |n| [0,15,30,45][n%3] }
    start_label { "#{start_hour}:#{start_minute}" }
    end_label { "#{end_hour}:#{end_minute}" }
    day
  end
  factory :day do
    name
    label "Lorem Ipsum"
  end

  factory :teacher do
    name
    label "Lorem Ipsum"
  end

  factory :booking do
    course
    room
    timeslot
    group
  end

  factory :booking_with_teacher, parent: :booking do
    after_build {|booking| booking.teachers << Factory(:teacher) }
  end

  factory :schedule do
    user
  end

  factory :schedule_with_bookings, parent: :schedule do
    after_build {|schedule| schedule.bookings << Factory(:booking_with_teacher) }
  end
end
