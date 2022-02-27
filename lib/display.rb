# frozen_string_literal: true

# module with all the necessary text displayed during the game
module Display
  def display_rules
    "
A random english word with 5 to 12 letters will be chosen, on each turn you can guess one letter or the complete word.
To win you must guess all the letters in the word or the complete word before using 8 incorrect guesses!\n
"
  end

  def display_game_start
    "The secret word as been chosen, you can start guessing!
Secret Word ->  #{@right_guesses.join(' ')}\n
"
  end

  def display_round
    "Secret Word ->  #{@right_guesses.join(' ')}
Wrong Guesses ->  #{@wrong_guesses.join(' ')}\n
"
  end
end
