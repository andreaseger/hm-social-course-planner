FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "foo#{n}" }
    label "Lorem Ipsum"
  end
  factory :teacher do
    sequence(:name) { |n| "foo#{n}" }
    label "Lorem Ipsum"
  end
  factory :room do
    sequence(:name) { |n| "foo#{n}" }
    label "Lorem Ipsum"
    building "r"
    floor 2
  end
  factory :group do
    sequence(:name) { |n| "foo#{n}" }
  end
  factory :timeslot do
    sequence(:start_label) { |n| "10:0#{n}" }
    sequence(:end_label) { |n| "11:3#{n}" }
    sequence(:start_time) { |n| 1000 + n }
    sequence(:end_time) { |n| 1130 + n }
    day
  end
  factory :day do
    sequence(:name) { |n| "foo#{n}" }
    label "Lorem Ipsum"
  end
  #factory :booking do
  #  course
  #  room
  #  timeslot
  #  group
  #  lectureship
  #end
  #factory :lectureship do
  #  booking
  #  teacher
  #end

end
