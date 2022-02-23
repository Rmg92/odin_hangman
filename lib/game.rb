# frozen_string_literal: true

# Contains the game logic
class Game
  def play
    new_game
    play_round while @wrong_guesses.length < 8
  end

  def new_game
    @word = choose_word
    # code for debug purposes, erase when not needed
    puts @word
    @right_guesses = []
    @wrong_guesses = []
  end

  def play_round
    input = player_input
    correct_guess?(input)
    # code to debug, erase when not needed
    p @right_guesses, @wrong_guesses
  end

  def player_input
    input = gets.chomp.downcase
    if input.empty?
      puts 'Invalid input!'
      player_input
    else
      input
    end
  end

  def correct_guess?(guess)
    # Add check for wrong inputs
    if guess.length > 1
      correct_word?(guess)
    else
      correct_letter?(guess)
    end
  end

  def correct_letter?(guess)
    if @word.include?(guess)
      @right_guesses << guess
    else
      @wrong_guesses << guess
    end
  end

  def correct_word?(guess)
    if @word.eql?(guess)
      puts 'You won!'
      exit
    else
      @wrong_guesses << guess
    end
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
