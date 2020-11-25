
=begin
Create a superclass called Vehicle for your MyCar class to inherit from
and move a behavior that isn't specific to the MyCar class to the superclass.
Create a constant in your MyCar class that stores information about
 the vehicle that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass
that also has a constant defined that separates it from the MyCar class
in some way.
=end

class Vehicle
  def self.gas_mileage(miles, gallons)
    miles_per_gallon = miles/ gallons
    puts "You've traveled #{miles_per_gallon} miles per gallon of gas."
  end
end

class MyTruck < Vehicle
  TIRE_TYPE = "Falken Wildpeak"

 attr_accessor :color, :model, :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
  end

  def to_s
    "My truck is a #{color}, #{year}, #{model}"
  end
end

class MyCar < Vehicle
  TIRE_TYPE = "Continental TrueContact"

  attr_accessor :color, :model, :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
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

  def to_s
    "My car is a #{color}, #{year}, #{model}"
  end
end

car = MyCar.new("2007", "Mazda 3", "Black")
truck = MyTruck.new("2015", "Ford F-150", "White")
puts car
puts truck
