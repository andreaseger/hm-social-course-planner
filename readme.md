#Social Course Planner

a web app to manage, share, compare,...  your current course plan with your classmates.
Uses the open data from the [Univerity of Applied Science Faculty 07](http://fi.cs.hm.edu) to get information about courses, booking, teachers and rooms.

##Requirements

- Ruby > 1.9 (app is using the new hash and lambda syntax)
- Bundler
- a Github API Key ( [get one here](https://github.com/account/applications/new) )

##Setup

discard *bunde exec* if you are using [rvm](http://beginrescueend.com/)

```sh
git clone git://github.com/sch1zo/hm-social-course-planner.git
cd hm-social-course-planner
bundle install

bundle exec rake setup

# setup your github key
export GITHUB_KEY='GITHUB_CLIENT_ID'
export GITHUB_SECRET='GITHUB_SECRET'

bundle exec rails s -p4567 thin
```

now go to **lvh.me:4567** and start using the app

##ToDo

- authbutton for email/password auth(Identity)
- custom forms for Identity auth
- link between user and schedules
- easy way to mark related courses
- easy way to detect and mark conflicting courses
- methods to create the json for schedules
- classmate relationship between two users
- messaging between two users

##Meta

- [@sch1zo](http://twitter.com/sch1zo)
