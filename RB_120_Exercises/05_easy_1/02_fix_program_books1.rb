=begin
Take a look at the following code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

What output does this code print?
Fix this class so that there are no surprises
waiting in store for the unsuspecting developer.
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin
that to_s inside the initialize method?
We need that for the challenge under Further Exploration.
Further Exploration

What would happen in this case?

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

This code "works" because of that mysterious to_s call in Pet#initialize.
However, that doesn't explain why this code produces the result it does.
Can you?
=end
=begin
I suspect you would think that the output of retrieving Fluffy's name would
by 43.  But we don't receive back 43 unil we call the local variable 'name'.
The source for the reason is with #initialize, particularly to 'to_s' method.
`to_s` doesn't mutate the object but return a new string.  Therefore,
`@name` is referencing a different object than what `name` from outside.
And `name` outside the class is reassigned to a new object. 
=end
