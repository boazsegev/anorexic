# encoding: UTF-8

# also set by other files, change to nil to avoid
Encoding.default_internal = 'utf-8'
Encoding.default_external = 'utf-8'

# Don't move this file.
#
# this file sets up the basic framework.
# the file uses it's location to set the Root path object.
# the file then loads all the .rb files from ./config and ./lib
# the file sets the default logger

# Using pathname extentions for setting public folder
require 'pathname'
#set up root object (some config files will use it as well as our app)
Root ||= Pathname.new(File.dirname(__FILE__)).expand_path


# using bundler to load gems (including the anorexic gem)
require 'bundler'
Bundler.require


# load all config files
Dir[File.join "{config}", "**" , "*.rb"].each {|file| load Pathname.new(file).expand_path}

# load all library files
Dir[File.join "{lib}", "**" , "*.rb"].each {|file| load Pathname.new(file).expand_path}

# load all application files
Dir[File.join "{app}", "**" , "*.rb"].each {|file| load Pathname.new(file).expand_path}

# set up Anorexic logs - Heroku logs to STDOUT, this machine logs to log file
Anorexic.create_logger (ENV['DYNO']) ? STDOUT : Root.join('logs','server.log')
