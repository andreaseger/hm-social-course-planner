#Social Course Planner

[![Build Status](https://secure.travis-ci.org/sch1zo/hm-social-course-planner.png)](http://travis-ci.org/sch1zo/hm-social-course-planner)

a web app to manage, share, compare,...  your current course plan with your classmates.
Uses the open data from the [Univerity of Applied Science Faculty 07](http://fi.cs.hm.edu) to get information about courses, booking, teachers and rooms.

##Requirements

- Ruby > 1.9 (app is using the new hash and lambda syntax)
- Bundler

###Auth Keys

- [Github](https://github.com/account/applications/new)
- [Twitter](https://dev.twitter.com/apps)
- [Facebook](https://developers.facebook.com/apps)
- [Google OAuth2](https://code.google.com/apis/console#access)

Make sure for each key that the callback url points to
/auth/:provider/callback for example /auth/googel_oauth2/callback

In Development also make sure you add the correct Port to the urls. Some
services don't work with localhost or 127.0.0.1 as url, use here lvh.me
instead.

##Setup

discard *bundle exec* if you are using [rvm](http://beginrescueend.com/)

```sh
git clone git://github.com/sch1zo/hm-social-course-planner.git
cd hm-social-course-planner
bundle install

bundle exec rake setup

# setup your auth keys -> config/app_config.yml

bundle exec rails s -p4567 thin
```

If you want ro generate some fake userser simply run *bundle exec rake data:generate_fake_user*
now go to **lvh.me:4567** and start using the app

##ToDo

- easy way to mark related courses
- easy way to detect and mark conflicting courses

##Meta

- [@rootbuerger](http://twitter.com/rootbuerger)
- [@sch1zo](http://twitter.com/sch1zo)
