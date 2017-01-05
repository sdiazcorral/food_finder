# Must require class because we are now using it here
# Notice it's not using an absolute path because in the init.rb file
# We already told it were to look for stuff i.e. the "lib" folder
require "restaurant"
require "support/string_extend"

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
      action, args = get_action
      # do_action needs an argument
      # send user_response value to do_action as an argument
      result = do_action(action, args)
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
      args = user_response.downcase.strip.split(" ")
      action = args.shift
    end
    return action, args
  end

  # do_action accepts an argument called action
  def do_action(action, args=[])
    case action
    when "list"
      list
    when "find"
      keyword = args.shift
      find(keyword)
    when "add"
      add
    when "quit"
      # send the symbol :quit
      return :quit
    else
      puts "\n I don't understand that command.\n"
    end
  end

  def list
    output_action_header("Listing restaurants")
    restaurants = Restaurant.saved_restaurants
    output_restaurant_table(restaurants)
  end

  def find(keyword="")
    output_action_header("Find a restaurant")
    if keyword
      restaurants = Restaurant.saved_restaurants
      found = restaurants.select do |rest|
        rest.name.downcase.include?(keyword.downcase) ||
        rest.cuisine.downcase.include?(keyword.downcase) ||
        rest.price.to_i <= keyword.to_i
      end
      output_restaurant_table(found)
    else
      puts "Find using a key phrase to search the restaurant list."
      puts "Examples: 'find tamale', 'find mexican', 'find mex'\n\n"
    end
  end

  def add
    output_action_header("Add a restaurant")
    
    restaurant = Restaurant.build_using_questions

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

  private

  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end

  def output_restaurant_table(restaurants=[])
    print " " + "Name".ljust(30)
    print " " + "Cuisine".ljust(20)
    print " " + "Price".rjust(6) + "\n"
    puts "-" * 60
    restaurants.each do |rest|
      line = " " << rest.name.titleize.ljust(30)
      line << " " + rest.cuisine.titleize.ljust(20)
      line << " " << rest.formatted_price.rjust(6)
      puts line
    end
    puts "No listings found" if restaurants.empty?
    puts "-" * 60
  end
end