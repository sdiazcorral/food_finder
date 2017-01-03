### Food Finder
### A project from Lynda.com "Ruby Essential Training"
#
# Instruction: Launch this Ruby file from the command line to get started

# Set a constant var
# Set the current directory of this file (init.rb). In this case the directory is "food_finder". That is the root of this application
APP_ROOT = File.dirname(__FILE__)

# Absolute path option 1
# require "#{APP_ROOT}/lib/guide"

# Absolute path option 2.
# Better than option 1 because it will join the path with the appropriate back or forward slash for your OS
# require File.join(APP_ROOT, "lib", "guide")
# or
# require File.join(APP_ROOT, "lib", "guide.rb")

# Absolute path option 3.
# $: is shorthand for $LOAD_PATH, which contains an array of paths. More info https://www.sitepoint.com/loading-code-ruby/
# Unshift the path i.e. move the path to the front of the array so it looks for it in that path
# It will look for "guide" inside of "lib"
# require only works with files already in Ruby's load path, which is why we add the new path via .unshift
$:.unshift(File.join(APP_ROOT, "lib"))
require 'guide'