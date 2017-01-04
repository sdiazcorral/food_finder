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
  end
end