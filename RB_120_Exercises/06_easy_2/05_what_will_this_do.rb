=begin
What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata
=end

=begin
	on line 19, we are calling on a Class object.  So, the class method will
	be executed.
	on line 20, we are calling on the object, so the instance method will
	be executed.
=end
