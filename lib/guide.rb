class Guide
  # the guide will need the path to the restaurant file
  # we could hard code the path
  # but for flexibility, we'll pass the path as an argument
  # that way we can give it the path we want i.e. we could have a guide for Dallas, or for Seattle
  def initialize(path=nil)
    # locate the restaurant text file at path
    # or create a new file
    # exit if create fails
  end

  def launch!
    # introduction
    # action loop
    #   what do you want to do? (list, find, add, quit)
    #   do that action
    # repeat until user quits
    # conclusion
  end

  def introduction
    puts "\n\n=== Welcome to the Food Finder ===\n\n"
    puts "This is a small Ruby application to help you find the food you crave. Built by Stanley Diaz.\n\n"
  end

  def conclusion
    puts "\n=== Goodbye, and Enjoy your meal!===\n\n\n"
  end
end