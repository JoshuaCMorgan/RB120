=begin
Using the Card class from the previous exercise, 
create a Deck class that contains all of the standard 52 playing cards. 

The Deck class should provide a #draw method to deal one card. 
The Deck should be shuffled when it is initialized and, 
if it runs out of cards, it should reset itself by generating 
  a new set of 52 shuffled cards.
=end
class Card
  include Comparable
  attr_reader :rank, :suit
 
  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value 
    VALUES.fetch(rank, rank)
  end 

  def <=>(other_card)
      value <=> other_card.value
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

deck = Deck.new
drawn = []
52.times {drawn << deck.draw }
p drawn.count {|card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2


