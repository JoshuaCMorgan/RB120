=begin
In the previous two exercises, you developed a Card class and a Deck class. 
You are now going to use those classes to create and evaluate poker hands. 
Create a class, PokerHand, that takes 5 cards from a Deck of Cards and 
evaluates those cards as a Poker hand.

You should build your class using the following code skeleton:

# Include Card and Deck classes from the last two exercises.

class PokerHand
  def initialize(deck)
  end

  def print
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
  end

  def straight_flush?
  end

  def four_of_a_kind?
  end

  def full_house?
  end

  def flush?
  end

  def straight?
  end

  def three_of_a_kind?
  end

  def two_pair?
  end

  def pair?
  end
end

=end
require 'pry'
require 'byebug'

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

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
 
  def initialize
    shuffle_deck
  end 
  
  def draw
    shuffle_deck if @cards.empty?
    @cards.shift 
  end 

  private

  def shuffle_deck
    @cards = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end 
    
    @cards.shuffle!
  end 
end

class PokerHand
  def initialize(deck)
    @hand = []
    5.times { @hand << deck.draw}
  end

  def print
    puts @hand 
  end

  def evaluate
    case 
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def not_in_sequence?
    cards = @hand.map {|card| card.value}.sort!
    cards.chunk_while {|a, b| (b - a) == 1}.to_a.size == 1
  end

  def same_rank?(num)
    rank = @hand.map {|card| card.value}
    rank.count {|element| rank.count(element) == num} == num
  end 

  def same_suit?
    @hand.all? {|card| card.suit == @hand[0].suit} 
  end 

  def straight_sequence?
    return false unless not_in_sequence?
    (@hand.max.value - @hand.min.value) == 4
  end 
  def royal_flush?
    @hand.min.value > 9 && same_suit?
  end

  def straight_flush?
    straight_sequence? && same_suit?
  end

  def four_of_a_kind?
     same_rank?(4)
  end

  def full_house?
    same_rank?(3) && same_rank?(2)  
  end

  def flush?
    same_suit? 
  end

  def straight?
    straight_sequence? 
  end

  def three_of_a_kind?
    same_rank?(3)
  end

  def two_pair?
    @hand.map {|card| card.value}.uniq.size == 3
  end

  def pair?
    same_rank?(2)
  end


end



# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'