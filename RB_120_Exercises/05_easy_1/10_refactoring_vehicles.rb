=begin
Consider the following classes:

class Car
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    4
  end

  def to_s
    "#{make} #{model}"
  end
end

class Motorcycle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    2
  end

  def to_s
    "#{make} #{model}"
  end
end

class Truck
  attr_reader :make, :model, :payload

  def initialize(make, model, payload)
    @make = make
    @model = model
    @payload = payload
  end

  def wheels
    6
  end

  def to_s
    "#{make} #{model}"
  end
end

Refactor these classes so they all use a common superclass,
and inherit behavior as needed.
=end

class Vehicle
	attr_reader :make, :model
	def initialize(make, model)
		@make = make
		@model = model
	end

	def to_s
	  "My #{self.class.to_s.downcase}: #{make}, #{model}"
	end
end

class Car < Vehicle
	def initialize(make, model)
		super(make, model)
	end

	def wheels
		4
	end
end

class Motorcycle < Vehicle
	def initialize(make, model)
		super(make, model)
	end

	def wheels
		2
	end
end

class Truck < Vehicle
	attr_reader :payload
	def initialize(make, model, payload)
		super(make, model)
		@payload = payload
	end

	def wheels
	  6
	end

	def to_s
		super + ", #{payload}"
	end
end

car = Car.new("Mazda", "3")
puts car.wheels
puts car
motorcycle = Motorcycle.new("Honda", "CRV")
puts motorcycle.wheels
truck = Truck.new("Ford", "F150", 3200)
puts truck
