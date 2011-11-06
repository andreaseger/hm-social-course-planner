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
    sequence(:start_label) { |n| "10:0#{n}" }
    sequence(:end_label) { |n| "11:3#{n}" }
    sequence(:start_time) { |n| 1000 + n }
    sequence(:end_time) { |n| 1130 + n }
    day
  end
  factory :day do
    name
    label "Lorem Ipsum"
  end

  factory :authentication do
    provider "developer"
    sequence(:uid) { |n| "foo#{n}" }
  end

  factory :profile do
    firstname "Foo"
    lastname "Bar"
    website "http://twitter.com/sch1zo"
    twitter "sch1zo"
    bio "Lorem Ipsum"
  end

  factory :user do
    sequence(:username) { |n| "foo#{n}" }
    email { "#{username}@test.com" }
  end
  factory :user_with_profile, parent: :user do
    association :profile, factory: :profile, method: :build
  end
  factory :user_with_auth, parent: :user_with_profile do |user|
    after_create {|user| Factory(:authentication, user: user) }
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
