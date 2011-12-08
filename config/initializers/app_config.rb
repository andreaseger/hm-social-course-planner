#load yml file
unless File.exists? Rails.root.join('config','app_config.yml')
  require 'fileutils'
  FileUtils.cp Rails.root.join('config','app_config.example'), Rails.root.join('config','app_config.yml')
  puts "[INFO] app_config.yml created"
end

require 'ostruct'
APP_CONFIG = OpenStruct.new(YAML.load_file(Rails.root.join('config','app_config.yml') )[::Rails.env] )
