# Must require class because we are now using it here
# Notice it's not using an absolute path because in the init.rb file
# We already told it were to look for stuff i.e. the "lib" folder
require "restaurant"

class Guide
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
      print "> "
      # save the input in user_response var
      user_response = gets.chomp

      # do_action needs an argument
      # send user_response value to do_action as an argument
      result = do_action(user_response)
    end
    conclusion
  end

  # do_action accepts an argument called action
  def do_action(action)
    case action
    when "list"
      puts "Listing..."
    when "find"
      puts "Finding..."
    when "add"
      puts "Adding..."
    when "quit"
      # send the symbol :quit
      return :quit
    else
      puts "\n I don't understand that command.\n"
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