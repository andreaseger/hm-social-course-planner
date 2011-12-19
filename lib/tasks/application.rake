desc "Setup all for app"
task :setup => ['db:create', 'db:migrate', 'db:seed', 'data:update']
