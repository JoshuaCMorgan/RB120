
=begin
1. Create a class called MyCar. When you initialize a new instance or object
of the class, allow the user to define some instance variables
that tell us the year, color, and model of the car.
Create an instance variable that is set to 0 during instantiation
of the object to track the current speed of the car as well.
Create instance methods that allow the car to speed up, brake,
and shut the car off.
=end

class MyCar
  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
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

mazda = MyCar.new("2007", "3", "black")
mazda.speed_up(10)
mazda.current_speed
mazda.speed_up(20)
mazda.current_speed
mazda.slow_down(10)
mazda.current_speed
mazda.shut_off
mazda.current_speed

=begin
Add an accessor method to your MyCar class to change
and view the color of your car.
Then add an accessor method that allows you to view, but not modify,
the year of your car.
=end

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
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

mazda = MyCar.new("2007", "3", "black")

mazda.color = "yellow"
puts mazda.color # => "Yellow"


=begin
3. You want to create a nice interface that allows you to accurately describe
the action you want your program to perform.
Create a method called spray_paint that can be called on an object
and will modify the color of the car.
=end

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
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

mazda = MyCar.new("2007", "3", "black")

mazda.color = "yellow"
puts mazda.color # => "Yellow"
mazda.spray_paint("green")
puts mazda.color
