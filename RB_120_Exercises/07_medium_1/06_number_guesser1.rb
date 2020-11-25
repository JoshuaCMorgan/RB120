=begin
Create an object-oriented number guessing class for numbers in 
the range 1 to 100, with a limit of 7 guesses per game. 
The game should play like this:

game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!


Note that a game object should start a new game with a new number 
to guess with each call to #play.
=end


class GuessingGame
  MAX_GUESS = 7
  
  def initialize 
    @win_num = nil
  end 

  def set_target_num 
    @win_num = rand(1..100)
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
    MAX_GUESS.downto(1) do |remaining_guesses|
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


