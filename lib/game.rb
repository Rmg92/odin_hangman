# frozen_string_literal: true

# Contains the game logic
class Game
  def play
    new_game
    play_round while @round < 9
  end

  def new_game
    @word = choose_word
    puts @word
    @right_guesses = []
    @wrong_guesses = []
    @round = 1
  end

  def play_round
    choose_guess
    # code to debug
    p @right_guesses, @wrong_guesses
    @round += 1
  end

  def choose_guess
    guess = gets.chomp
    # Add check for wrong inputs
    if guess.length > 1
      check_word(guess)
    else
      check_letter(guess)
    end
  end

  def check_letter(guess)
    if @word.include?(guess)
      @right_guesses << guess
    else
      @wrong_guesses << guess
    end
  end

  def check_word(guess)
    if @word.eql?(guess)
      puts 'You won!'
      exit
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
