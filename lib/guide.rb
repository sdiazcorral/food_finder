# Must require class because we are now using it here
# Notice it's not using an absolute path because in the init.rb file
# We already told it were to look for stuff i.e. the "lib" folder
require "restaurant"

class Guide

  class Config
    # Set a class variable
    @@actions = ["list", "find", "add", "quit"]
    # Reader method to let me read the value of the class variable
    def self.actions
      # Return the value of the variable
      @@actions
    end
  end
  # the guide will need the path to the restaurant file
  # we could hard code the path
  # but for flexibility, we'll pass the path as an argument
  # that way we can give it the path we want i.e. we could have a guide for Dallas, or for Seattle
  def initialize(path=nil)
    # locate the restaurant text file at path
    # or create a new file
    # exit if create fails
    Restaurant.filepath = path
    if Restaurant.file_usable?
      puts "Found a restaurant file."
    elsif Restaurant.create_file
      # if the returned boolean is true, it will do this
      puts "Created a new restaurant file."
    else
      puts "Exiting\n\n"
      # No matter where you are, abort script and return to command line
      exit!
    end
  end

  def launch!
    # introduction
    # action loop
    #   what do you want to do? (list, find, add, quit)
    #   do that action
    # repeat until user quits
    # conclusion
    introduction
    result = nil # initialize variable so we can use it
    until result == :quit
      # make sure input is valid by running it through get_action method
      action = get_action
      # do_action needs an argument
      # send user_response value to do_action as an argument
      result = do_action(action)
    end
    conclusion
  end

  def get_action
    action = nil
    # keep asking for user input until we get a valid action
    until Guide::Config.actions.include?(action)
      puts "Actions: " + Guide::Config.actions.join(", ") if action
      print "> "
      # save the input in user_response var
      user_response = gets.chomp
      # we want to downcase it and strip to make sure it works with our list of actions
      action = user_response.downcase.strip
    end
    return action
  end

  # do_action accepts an argument called action
  def do_action(action)
    case action
    when "list"
      puts "Listing..."
    when "find"
      puts "Finding..."
    when "add"
      add
    when "quit"
      # send the symbol :quit
      return :quit
    else
      puts "\n I don't understand that command.\n"
    end
  end

  def add
    puts "\nAdd a restaurant\n\n".upcase
    restaurant = Restaurant.new

    print "Restaurant name: "
    restaurant.name = gets.chomp.strip

    print "Cuisine type: "
    restaurant.cuisine = gets.chomp.strip

    print "Average price: "
    restaurant.price = gets.chomp.strip

    if restaurant.save
      puts "\nRestaurant added\n\n"
    else
      puts "\nSave Error: restaurant not added\n\n"
    end
  end

  def introduction
    puts "\n\n=== Welcome to the Food Finder ===\n\n"
    puts "This is a small Ruby application to help you find the food you crave.\nBuilt by Stanley Diaz.\n\n"
  end

  def conclusion
    puts "\n=== Goodbye, and Enjoy your meal!===\n\n\n"
  end
end