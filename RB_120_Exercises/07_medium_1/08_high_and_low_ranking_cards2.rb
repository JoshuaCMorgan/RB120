
=begin
Further Exploration

You will need the original exercise solution for the next two exercises. 
If you work on this Further Exploration, keep a copy of your 
original solution so you can reuse it.

Assume you're playing a game in which cards of the same rank are unequal. I
n such a game, each suit also has a ranking. 
Suppose that, in this game, a 4 of Spades outranks a 4 of Hearts 
which outranks a 4 of Clubs which outranks a 4 of Diamonds. 
A 5 of Diamonds, though, outranks a 4 of Spades since we compare ranks first. 
Update the Card class so that #min and #max pick the card of the 
appropriate suit if two or more cards of the same rank are present in the Array.
=end

class Card
  include Comparable
  attr_reader :rank, :suit
 
  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  SUITS = {'Spades' => 4, 'Hearts' => 3, 'Clubs' => 2, 'Diamonds' => 1}
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value 
    VALUES.fetch(rank, rank)
  end 

  def suit_value
    SUITS.fetch(suit)
  end 

  def <=>(other_card)
    if rank == other_card.rank
      suit_value <=>other_card.suit_value
    else
      value <=> other_card.value
    end 
  end 

  def to_s 
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(2, 'Hearts'),
  Card.new(10, 'Diamonds'),
  Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
  Card.new(4, 'Diamonds'),
  Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
  Card.new('Jack', 'Diamonds'),
  Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
  Card.new(8, 'Clubs'),
  Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8