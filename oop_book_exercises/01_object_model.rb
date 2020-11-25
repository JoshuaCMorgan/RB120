=begin
1. How do we create an object in Ruby? Give an example of the creation of an object.
=end

class MyClass
end

my_obj = MyClass.new

=begin
1. What is a module?  What is its purpose?   How do we use them with our classes?
Create a module for the class you created in exercise 1 and include it properly.
=end

module YourClass
end

class MyClass
  include YourClass
end

my_obj = MyClass.new
