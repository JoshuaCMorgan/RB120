class Car 
  @@wheels = 4

  def self.wheels?
    @@wheels 
  end 
end 

class  Motorcycle < Car 
  @@wheels = 2

  def self.wheels?
    @@wheels 
  end 

  def what?
    class 
end 

puts Car.wheels?          # 2
puts Motorcycle.wheels?   # 2