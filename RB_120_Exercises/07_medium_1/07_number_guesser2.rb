=begin
In the previous exercise, you wrote a number guessing game that determines 
a secret number between 1 and 100, and gives the user 7 
opportunities to guess the number.

Update your solution to accept a low and high value when you create
 a GuessingGame object, and use those values to compute a secret 
 number for the game. You should also change the number of 
 guesses allowed so the user can always win if she uses a good strategy. 
 You can compute the number of guesses with:

Math.log2(size_of_range).to_i + 1

=end

class GuessingGame
  def initialize(low, high)
    @range = low..high
    @max_guesses = Math.log2(high - low + 1).to_i + 1
    @win_num = nil
  end 

  def set_target_num 
    @win_num = rand(@range)
  end 

  def display_win_message
    "You won!"
  end 

  def setup_game
    set_target_num
  end 

  def get_one_number
    loop do 
      print "Enter a number between 1 and 100:"
      num= gets.chomp.to_i
      return num if valid_num?(num)
      print "Invalid guess.  "
    end 
  end 

  def check(num)
    puts "Your guess is too high" if num > @win_num
    puts "Your guess is too low." if num < @win_num 
    puts "That's the number!" if num == @win_num
  end 

  def display_win_lose_message(guess)
    if guess == @win_num
      puts "You won!" 
    else
      puts "You have no more guesses. You lost!"
    end 
  end 

  def display_message(remaining)
    puts
    if remaining== 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end 

  def play_game
    @max_guesses.downto(1) do |remaining_guesses|
      display_message(remaining_guesses)
      @guess = get_one_number
      check(@guess)
      break if @guess == @win_num
    end 
    display_win_lose_message(@guess)
  end 

  def play
    setup_game
    play_game
  end 
end 

game = GuessingGame.new
game.play
