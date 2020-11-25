=begin
Consider the following class definition:

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

There is nothing technically incorrect about this class,
but the definition may lead to problems in the future.
How can this class be fixed to be resistant to future problems?
=end

=begin
We could erase the attr_accessor :database_handle method so that
there is no public setter method to manipulate the database_handle property
from outside the class.
Additionally, if the database_handle property needs to be manipulated
from inside the class, any setter method should be better to be either
private or protected. 
=end
