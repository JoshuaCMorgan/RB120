module Displayable
  # MISC
  def prompt(message)
    puts "#{message}"
  end

  def clear_screen
    system 'clear'
  end

  def display_banner
    prompt '======================== Twenty One ========================='
  end

  # DISPLAY CARDS AND TOTALS
  def display_initial_cards
    clear_screen
    display_banner
    prompt "Dealer has: #{dealer.current_hand[0]} and unknown card"
    prompt "#{human.name} has: #{human.current_hand.join(' and ')}"
    prompt ''
    prompt "Your total: #{human.total}"
  end

  def display_final_cards_and_totals
    prompt "Let's compare cards: "
    prompt ''
    prompt "Dealer's hand: #{dealer.current_hand.join(' and ')}"
    prompt "#{human.name} hand: #{human.current_hand.join(' and ')}"
    prompt ''
    prompt "Dealer's total: #{dealer.total}"
    prompt "#{human.name}'s total: #{human.total}"
  end

  def display_total(player)
    prompt "#{player.name}'s total: #{player.total}"
  end

  # DISPLAY MESSAGES
  def welcome_message
    prompt '================ Twenty One =================='
    prompt <<-MSG
  You will play one round.
  The closest to 21 without going over wins.
  Let's get setup...
    MSG
    prompt '=============================================='
    prompt ''
  end

  def display_goodbye_message
    prompt ''
    prompt 'Thanks for playing.  Have a blessed day!'
  end

  def display_dealer_stay_message
    prompt 'Dealer chose to stay...'
    sleep 1.5
  end

  def display_dealer_hit_message
    prompt 'Dealer chose to hit...'
    sleep 1.5
  end

  def display_player_hit_message
    clear_screen
    display_banner
    prompt ''
    prompt "#{human.name} chose to hit..."
    prompt ''
    sleep 1
    prompt 'Dealer dealing...'
    sleep 1.5
  end

  def display_dealer_busted_message
    prompt 'Dealer has busted...'
    sleep 1.5
  end

  def dealing_cards_message
    prompt ''
    prompt 'Dealing cards...'
    sleep 1.5
    clear_screen
  end

  def play_again?
    prompt "Would you like to play again?( 'y' or 'n')"
    choice = nil
    loop do
      choice = gets.chomp.downcase
      break if %w[y n].include?(choice)

      prompt 'Sorry, please make a valid choice.'
    end
    choice == 'y'
  end
end

# Hand ---------------------------------
module Hand
  def busted?
    total > 21
  end

  def total_hand
    values = current_hand.map(&:value)
    sum = values.sum
    values.count(11).times { sum -= 10 if sum > 21 }
    self.total = sum
  end

  def >(other)
    total > other.total
  end

  def winner?
    if human.busted?
      prompt 'You busted'
    elsif dealer.busted?
      prompt 'Dealer busted'
    elsif human > dealer
      prompt 'You win!'
    elsif dealer > human
      prompt 'Dealer wins'
    else
      prompt "It's a tie"
    end
  end
end

# Participant -------------------------------
class Participant
  include Hand

  attr_accessor :current_hand, :name, :total

  def initialize
    @current_hand = []
    @total = 0
  end

  def hit(player, deck)
    player.current_hand << deck.deal_card
  end

  def stay
    prompt "You chose to stay. Dealer's turn now..."
    sleep 2
  end
end

# Player ---------------------------------
class Player < Participant
  include Displayable

  def set_name
    n = ''
    loop do
      print "What's your name? "
      n = gets.chomp
      break unless n.split.empty?

      prompt 'Sorry, must enter a value.'
    end

    self.name = n.capitalize
    prompt "Welcome, #{name}. Let's get started."
    sleep 1
  end

  def hit_or_stay
    players_choice = nil

    loop do
      prompt ''
      prompt "Would you like to hit or stay? ('h' for hit / 's' for stay)"
      players_choice = gets.chomp.downcase
      break if %w[h s].include?(players_choice)

      prompt 'Sorry, please make a valid choice'
    end

    players_choice
  end
end

# Dealer -----------------------------
class Dealer < Participant
  DEALER_MAX = 17

  def initial_deal(other_player, deck)
    2.times do
      other_player.current_hand << deck.deal_card
      current_hand << deck.deal_card
    end
  end

  def hit?(deck)
    unless total >= DEALER_MAX
      hit(self, deck)
      total_hand
      return true
    end
    nil
  end
end

# Deck ---------------------------
class Deck
  attr_accessor :deck

  def initialize
    @deck = Card::RANKS.product(Card::SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end
    shuffle_deck!
  end

  def deal_card
    @deck.pop
  end

  def shuffle_deck!
    @deck.shuffle!
  end
end

# Card -------------------------------
class Card
  RANKS = ((2..10).to_a + %w[Jack Queen King Ace]).freeze
  SUITS = %w[Hearts Clubs Diamonds Spades].freeze
  VALUES = { 'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => 11 }.freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank} of #{@suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end
end

# Game Engine -----------------------------
class Game
  include Displayable
  include Hand

  attr_reader :dealer, :human
  attr_accessor :deck

  def initialize
    @deck = Deck.new
    @human = Player.new
    @dealer = Dealer.new
  end

  def play
    setup
    loop do
      initial_deal
      players_turn
      show_results
      play_again? ? reset : break
    end
    display_goodbye_message
  end

  def setup
    clear_screen
    welcome_message
    human.set_name
    clear_screen
  end

  def initial_deal
    dealing_cards_message
    deal_and_total_cards
    display_initial_cards
  end

  def players_turn
    result = human_turn
    dealer_turn unless result == :busted
  end

  def deal_and_total_cards
    dealer.initial_deal(human, deck)
    total_cards(human)
    total_cards(dealer)
  end

  def human_turn
    loop do
      player_choice = human.hit_or_stay
      break unless player_choice == 'h'

      play_hand
      break if human.busted?
    end

    if human.busted?
      return :busted
    else
      human.stay
    end

    clear_screen
  end

  def play_hand
    display_player_hit_message
    dealer.hit(human, deck)
    total_cards(human)
    display_initial_cards
  end

  def dealer_turn
    display_banner
    display_dealer_hit_message if dealer.hit?(deck)

    if dealer.busted?
      display_dealer_busted_message
    else
      display_dealer_stay_message
    end
  end

  def total_cards(player)
    player.total_hand
  end

  def show_results
    clear_screen
    display_banner
    winner?
    display_final_cards_and_totals
  end

  def reset
    self.deck = Deck.new
    human.current_hand = []
    dealer.current_hand = []
    clear_screen
  end
end

Game.new.play
