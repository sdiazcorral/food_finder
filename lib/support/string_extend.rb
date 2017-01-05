# Add a new method to the core String class
class String
  # Method to capitalize the first letter of each word
  # Split each word at the space, which will make it into an array
  # Capitalize each word, and join each word with a space
  def titleize
    self.split(" ").collect {|word| word.capitalize}.join(" ")
  end
end