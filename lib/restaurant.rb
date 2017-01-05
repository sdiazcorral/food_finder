require "support/number_helper"

class Restaurant
  include NumberHelper
  attr_accessor :name, :cuisine, :price

  # Class variable
  @@filepath = nil

  # Setter method to set the filepath in guide.rb, init method
  def self.filepath=(path=nil)
    # The "path" you provide must be relative to the app root
    @@filepath = File.join(APP_ROOT, path)
  end

  # Class methods. As indicated by "self"
  def self.file_exists?
    # Class should know if the restaurant file exists
    # if @@filepath has a value, and it exists
    if @@filepath && File.exists?(@@filepath)
      return true
    else
      return false
    end
  end

  # Boolean test to see if the file is usable
  # If it fails any of the tests, it means not usable
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.create_file
    # Create the restaurant file
    # Open in "w" = write mode, only if it exists
    # If it does exist, it will open and close it
    File.open(@@filepath, "w") unless file_exists?

    # Return boolean to method in guide.rb
    return file_usable?
  end

  def self.saved_restaurants
    # Read the restaurant file
    # Return instances of restaurant
    restaurants = []
    if file_usable?
      file = File.new(@@filepath, "r")
      file.each_line do |line|
        restaurants << Restaurant.new.import_line(line.chomp)
      end
      file.close
    end
    return restaurants
  end

  def self.build_using_questions
    args = {}

    print "Restaurant name: "
    args[:name] = gets.chomp.strip

    print "Cuisine type: "
    args[:cuisine] = gets.chomp.strip

    print "Average price: "
    args[:price] = gets.chomp.strip

    return self.new(args)
  end

  def initialize(args={})
    @name = args[:name] || ""
    @cuisine = args[:cuisine] || ""
    @price = args[:price] || ""
  end

  def import_line(line)
    line_array = line.split("\t")
    @name, @cuisine, @price = line_array
    return self
  end

  def save
    # This is an instance method, which means we need to ask the Restaurant class itself
    # Otherwise, it's going to look for an instance method called file_usable?
    return false unless Restaurant.file_usable?
    File.open(@@filepath, "a") do |file|
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    return true
  end

  def formatted_price
    number_to_currency(@price)
  end
end