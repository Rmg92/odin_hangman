# frozen_string_literal: true

# Contains the game logic
class Game
  def play
    new_game
    p @word, @right_guesses, @wrong_guesses
  end

  def new_game
    @word = choose_word
    @right_guesses = []
    @wrong_guesses = []
  end

  def choose_word
    word = load_dictionary[rand(load_dictionary.length)]
    if word.length.between?(5, 12)
      word
    else
      choose_word
    end
  end

  def load_dictionary
    if File.exist?('english_words.txt')
      File.read('english_words.txt').split
    else
      puts 'Dictionary file was not found!'
      exit
    end
  end
end
