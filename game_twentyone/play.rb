

 
=begin
The application lets a customer place an order for a meal.
    A meal always has three meal items: a burger, a side, and drink.
    For each meal item, the customer must choose an option.
    The application must compute the total cost of the order.
 
=end
require 'pry'
require 'pry-byebug'
  
class Customer

  def place_order
    @order = Order.new
  end

end

class Order
  def initialize
    @burger = Burger.new
    @side = Side.new
    @drink = Drink.new
  end

  
  def meal
    [@burger, @side, @drink]
  end


  def total
    total_cost = @burger + @side + @drink
    format("$%.2f", total_cost) # #format formats the cost to two decimal places
  end

  def to_s 
    meal.map(&:to_s).join(', ')
  end 

end

class MealItem
  def initialize
    @option = choose_option
  end
  
  def choose_option
    puts "Please choose a #{self.class} option:"
    
  end

  def to_s
    self.class::OPTIONS[@option][:name]
  end

end

class Burger < MealItem
  OPTIONS = {
    '1' => { name: 'LS Burger', cost: 3.00 },
    '2' => { name: 'LS Cheeseburger', cost: 3.50 },
    '3' => { name: 'LS Chicken Burger', cost: 4.50 },
    '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
  }
end

class Side < MealItem
  OPTIONS = {
    '1' => { name: 'Fries', cost: 0.99 },
    '2' => { name: 'Onion Rings', cost: 1.50 }
  }
end

class Drink < MealItem
  OPTIONS = {
    '1' => { name: 'Cola', cost: 1.50 },
    '2' => { name: 'Lemonade', cost: 1.50 },
    '3' => { name: 'Vanilla Shake', cost: 2.00 },
    '4' => { name: 'Chocolate Shake', cost: 2.00 },
    '5' => { name: 'Strawberry Shake', cost: 2.00 }
  }
end

jeff = Customer.new 
jeff.place_order

