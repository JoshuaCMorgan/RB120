
=begin
Add a class method to your MyCar class that calculates the gas mileage of any car.
=end

class MyCar
  attr_accessor :color, :model, :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  def to_s
    <<-MSG
    YOUR CAR:
    YEAR: #{year}
    MODEL: #{model}
    COLOR: #{color}
    MSG
  end

  def self.gas_mileage(miles, gallons)
    miles_per_gallon = miles/ gallons
    puts "You've traveled #{miles_per_gallon} miles per gallon of gas."
  end

  def spray_paint(color)
    self.color = color
    puts "Paint job is done.  Your car color is now #{color}."
  end

  def speed_up(accel)
    @current_speed += accel
    puts "You accelerate #{accel} mph."
  end

  def slow_down(decel)
    @current_speed = decel
    puts "You decelerate #{decel} mph."
  end

  def current_speed
    puts "You are currently going #{@current_speed} mph."
  end

  def shut_off
    @current_speed = 0
    puts "You have shut the car off."
  end
end


=begin
Override the to_s method to create a user friendly print out of your object
=end

mazda = MyCar.new("2007", "3", "black")
MyCar.gas_mileage(120, 3)   # => You've traveled 40 miles per gallon of gas.
puts mazda
# => YOUR CAR:
#    YEAR: 2007
#    MODEL: 3
#    COLOR: black



=begin
When running the following code...
=end

# class Person
#   attr_reader :name
#   def initialize(name)
#     @name = name
#   end
# end
#
# bob = Person.new("Steve")
# bob.name = "Bob"

=begin
We get the following error...

test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

Why do we get this error and how do we fix it?
=end
=begin
We get this error because we used attr_reader instead of attr_writer/accessor.
That is, we used a getter method instead of a setter method.
Here's the fix: use attr_accessor. This gives us both the setter functionality
and the getter functionality, which let us print to see that that the
change was made.
=end

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
puts bob.name
