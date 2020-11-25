class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

	def info
		puts "this is my name #{self.name}"
		puts "this is my age #{human_years}"
	end

	private
  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)

sparky.info
