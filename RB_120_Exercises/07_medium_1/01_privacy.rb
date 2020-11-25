=begin
Consider the following class:

class Machine
  attr_writer :switch

  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

Modify this class so both flip_switch and the setter method switch= are private methods.
Ruby 2.6
Further Exploration

Add a private getter for @switch to the Machine class, and add a method to Machine 
that shows how to use that getter.
=end


class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end
  
  def switch_status
    status = switch == :on ? "On" : "Off" 
    puts "Current machine status: #{status}"
  end 

  private 

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
machine.start
puts machine.switch_status
