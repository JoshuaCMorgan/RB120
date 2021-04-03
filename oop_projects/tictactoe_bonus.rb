
module Extras
  def valid_number?(number)
    number == number.to_i.to_s
  end

  def clear
    system('clear') || system('cls')
  end
end

# -----------------------------------------------
# Display messages
module Displayable
  def joiner(available_keys, punctuation = ', ', conjuction = 'or')
    return available_keys[0] if available_keys.size == 1

    return available_keys.join(conjuction.to_s) if available_keys.size == 2

    first = available_keys[0..-2].join(punctuation.to_s)
    second = " #{conjuction} " + available_keys[-1].to_s
    available_keys = first + second

    available_keys
  end

  def welcome_message
    puts '****************************************************'
    puts 'Welcome to Tic Tac Toe!'
    puts "The first player to #{Scoreboard::WIN} points wins the match."
    puts "Let's get you setup to play."
    puts '****************************************************'
    puts ''
  end

  def display_round_winner
    case board.winning_marker
    when human.marker
      puts 'You won this round!'
    when computer.marker
      puts 'Computer won this round!'
    else
      puts "It's a tie!"
    end
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye!'
  end

  def main_board_display
    puts "#{human.name}, you are a #{human.marker}. \
      #{computer.name}, the computer, is a #{computer.marker}."
    scoreboard.display_round
    puts ''
    board.draw
    puts ''
  end

  def establish_first_mover_display
    puts "Let's establish who will make the first move."
    puts <<~MSG
      Choose an option by typing a number:
      1) I will go first
      2) Computer will go first
      3) It doesn't matter
    MSG
  end

  def scoreboard_display
    scoreboard.display_scores(human, computer)
  end

  def display_press_key_to_continue
    puts "Press 'c' key to continue."

    input = nil
    loop do
      input = gets.chomp.downcase
      break if input == 'c'

      puts "Sorry, please press 'c'."
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w[y n].include? answer

      puts 'Sorry, must be y or n'
    end

    answer == 'y'
  end

  def display_match_winner
    case board.winning_marker
    when human.marker
      puts "#{human.name}, you won the match!"
    when computer.marker
      puts "#{computer.name}, the computer, won the match!"
    end
  end

  def match_results_display
    clear
    scoreboard.display_round
    puts
    board.draw
    puts
    display_match_winner
  end

  def play_again_message_display
    puts "Let's play again!"
    puts ''
  end
end

# ----------------------------------------
# State of board
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      curr_squares = @squares.values_at(*line)
      return curr_squares.first.marker if three_identical_markers?(curr_squares)
    end
    nil
  end

  def advantage_for?(player)
    WINNING_LINES.each do |line|
      curr_squares = @squares.values_at(*line)
      return true if two_identical_markers?(curr_squares, player)
    end
    nil
  end

  def get_at_risk_square(player)
    WINNING_LINES.each do |line|
      curr_squares = @squares.values_at(*line)

      next unless two_identical_markers?(curr_squares, player)

      num = @squares.keys.select do |key|
        line.include?(key) && @squares[key].unmarked?
      end
      return num.first
    end
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def two_identical_markers?(curr_squares, player)
    markers = curr_squares.select(&:marked?).collect(&:marker)
    return false if markers.count(player.marker) != 2

    markers.min == markers.max
  end

  def three_identical_markers?(curr_squares)
    markers = curr_squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3

    markers.min == markers.max
  end
end

# ----------------------------------
# Markers
class Square
  INITIAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

# ------------------------------------
# Keep Score of rounds and match
class Scoreboard
  WIN = 3

  def initialize
    @human_score = 0
    @computer_score = 0
    @round = 0
  end

  def human_won
    @human_score += 1
  end

  def computer_won
    @computer_score += 1
  end

  def grand_winner?
    @human_score == WIN || @computer_score == WIN
  end

  def display_scores(hmn, cmpt)
    puts 'Rounds won:'
    puts "#{hmn.name}: #{@human_score}"
    puts "#{cmpt.name}: #{@computer_score}"
  end

  def display_round
    puts "Rounds played: #{@round}"
    puts "#{WIN} wins needed to win the match."
    puts
  end

  def update_round
    @round += 1
  end

  def reset
    @human_score = 0
    @computer_score = 0
    @round = 0
  end
end

# -------------------------------------
# Player template
class Player
  attr_accessor :name, :marker
end

# ---------------------------------------
# Humman template
class Human < Player
  include Extras

  def pick_name
    print 'What name would you like to be addressed with? '
    name_given = nil

    loop do
      name_given = gets.chomp.capitalize
      break unless  name_given.split.empty?

      puts 'Please enter at least one character.'
    end

    @name = name_given.capitalize
    puts "Welcome, #{name}."
  end

  def pick_marker(markers)
    human_choice = nil
    puts "For this new match, let's establish your marker"
    loop do
      print 'Choose a letter from the alphabet (A-Z) as your marker: '
      human_choice = gets.chomp.upcase
      break if markers.include?(human_choice)

      puts 'Sorry, must be a valid option.'
    end

    self.marker = human_choice
  end

  def choose_first_mover
    choice = nil
    loop do
      print 'Enter your option: '
      choice = gets.chomp

      break if valid_number?(choice) && [1, 2, 3].include?(choice.to_i)

      puts ''
      puts 'Sorry, must be a number 1-3.'
    end

    choice.to_i
  end

  def choose_a_square(brd)
    square = nil
    loop do
      square = gets.chomp
      break if valid_number?(square) && brd.unmarked_keys.include?(square.to_i)

      puts "Sorry, that's not a valid choice."
    end

    square
  end
end

# ------------------------------------
# Computer template
class Computer < Player
  def pick_name
    @name = 'Joe'
  end

  def pick_marker(markers)
    self.marker = markers.sample
  end

  def possible_win?(brd)
    brd.advantage_for?(self)
  end

  def go_for_win(brd)
    square = brd.get_at_risk_square(self)
    brd[square] = marker
  end

  def possible_loss?(brd, other_player)
    brd.advantage_for?(other_player)
  end

  def go_for_protect(brd, other_player)
    square = brd.get_at_risk_square(other_player)
    brd[square] = marker
  end

  def middle_square_available?(brd)
    brd.unmarked_keys.include?(5)
  end

  def pick_middle_square(brd)
    brd[5] = marker
  end

  def pick_random_square(brd)
    brd[brd.unmarked_keys.sample] = marker
  end

  def choose_square(brd, other_player)
    if possible_win?(brd)
      go_for_win(brd)
    elsif possible_loss?(brd, other_player)
      go_for_protect(brd, other_player)
    elsif middle_square_available?(brd)
      pick_middle_square(brd)
    else
      pick_random_square(brd)
    end
  end
end

# -------------------------------------
# Main Game Engine
class TTTGame
  include Extras
  include Displayable

  MARKERS = ('A'..'Z').to_a

  def initialize
    @board = Board.new
    @scoreboard = Scoreboard.new
    @computer = Computer.new
    @human = Human.new
    @first_to_move = ' '
  end

  def play
    clear
    game_set_up
    main_game
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :scoreboard
  attr_accessor :current_marker, :first_to_move

  # Section: game setup
  def game_set_up
    display_welcome_message
    players_pick_names
  end

  def display_welcome_message
    welcome_message
  end

  def players_pick_names
    computer.pick_name
    human.pick_name
  end

  # Section: main game
  def main_game
    loop do
      play_match
      display_match_results
      break unless play_again?

      reset_main_game
      display_play_again_message
    end
  end

  def play_match
    setup_match_play

    loop do
      display_boards
      players_move
      update_scoreboard
      update_round
      break if match_ended?

      display_result
      reset
    end
  end

  def setup_match_play
    set_players_markers
    decide_order_of_play
    clear
  end

  def set_players_markers
    human.pick_marker(MARKERS)
    leftover_markers = MARKERS.reject { |value| value == human.marker }
    computer.pick_marker(leftover_markers)
    puts ''
  end

  def decide_order_of_play
    establish_first_mover_display
    choice = human.choose_first_mover

    @first_to_move = case choice
                     when 1 then human.marker
                     when 2 then computer.marker
                     when 3 then [human.marker, computer.marker].sample
                     end
    @current_marker = @first_to_move
  end

  def players_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_boards if human_turn?
    end
  end

  def human_turn?
    @current_marker == human.marker
  end

  def human_moves
    puts "Choose a square: #{joiner(board.unmarked_keys)}"
    square = human.choose_a_square(board)
    board[square.to_i] = human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer.choose_square(board, human)
      @current_marker = human.marker
    end
  end

  #scoreboards
  def update_scoreboard
    case board.winning_marker
    when human.marker
      scoreboard.human_won
    when computer.marker
      scoreboard.computer_won
    end
  end

  def update_round
    scoreboard.update_round
  end

  def match_ended?
    scoreboard.grand_winner?
  end

  # Displays
  def display_match_results
    clear_screen_and_display_boards
    match_results_display
  end

  def display_result
    clear_screen_and_display_boards
    puts ''
    display_round_winner
    display_press_key_to_continue
  end

  def display_boards
    main_board_display
    scoreboard_display
  end

  def clear_screen_and_display_boards
    clear
    display_boards
  end

  def reset_main_game
    scoreboard.reset
    reset
  end

  def reset
    board.reset
    clear
  end
end

game = TTTGame.new
game.play
