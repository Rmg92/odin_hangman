# frozen_string_literal: true

# module with all the necessary text displayed during the game
module Display
  def display_rules
    puts "
A random english word with 5 to 12 letters will be chosen, on each turn you can guess one letter or the complete word.
To win you must guess all the letters in the word or the complete word before using 8 incorrect guesses!\n
"
  end

  def display_game_start
    puts "The secret word has been chosen, you can start guessing!
Secret Word ->  #{@right_guesses.join(' ')}\n
"
  end

  def display_round
    puts "
Secret Word ->  #{@right_guesses.join(' ')}
Wrong Guesses ->  #{@wrong_guesses.join(' ')}
Remaining Guesses: #{@remaining_guesses}\n
"
  end

  def display_play_again
    puts '
Input 1 to play again or anything else to exit!'
  end

  def display_result
    if @remaining_guesses.zero?
      puts "Too bad, the secret word was #{@word.join}, you lost the game."
    else
      puts "Congratulations! The secret word was #{@word.join}, you won the game!"
    end
  end
end
