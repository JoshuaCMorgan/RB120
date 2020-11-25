 module Off_roadable
  def can_off_road?(wheel_parts)
    wheel_parts >= 4 ? true : false
  end
end


class Vehicle
  @@number_of_vehicles = 0

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    puts "Number of vehicles created: #{@@number_of_vehicles}."
  end

  def self.gas_mileage(miles, gallons)
    miles_per_gallon = miles/ gallons
    puts "You've traveled #{miles_per_gallon} miles per gallon of gas."
  end
end

class MyTruck < Vehicle
  include Off_roadable

  TIRE_TYPE = "Falken Wildpeak"

  attr_accessor :color, :model, :year

  def to_s
    "My truck is a #{color}, #{year}, #{model}"
  end
end

class MyCar < Vehicle
  TIRE_TYPE = "Continental TrueContact"

  attr_accessor :color, :model, :year

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
puts truck.can_off_road?(4)
=begin
Print to the screen your method lookup for the classes that you have created.
=end
puts MyTruck.ancestors
puts
puts MyCar.ancestors
puts
puts Vehicle.ancestors
