class Restaurant
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
  end

  def self.create_file
    # Create the restaurant file
  end

  def self.saved_restaurants
    # Read the restaurant file
    # Return instances of restaurant
  end
end