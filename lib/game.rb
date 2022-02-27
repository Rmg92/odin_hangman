# frozen_string_literal: true

require_relative 'display'

# Contains the game logic
class Game
  include Display

  def initialize
    @word = choose_word.split('')
    @right_guesses = Array.new(@word.length, '_')
    @wrong_guesses = []
    play
  end

  def play
    puts display_rules, display_game_start
    play_round while @wrong_guesses.length < 8
    puts @word.join
  end

  def play_round
    input = player_input
    correct_guess?(input)
    # code to debug, erase when not needed
    p @right_guesses.join(' '), @wrong_guesses.join(' ')
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
      correct_word?(guess.split(''))
    else
      correct_letter?(guess)
    end
  end

  def correct_letter?(guess)
    if @word.include?(guess)
      correct_position(guess)
    else
      @wrong_guesses << guess
    end
  end

  def correct_position(guess)
    @word.each_index do |index|
      @right_guesses[index] = guess if @word[index].eql?(guess)
    end
    correct_word?(@right_guesses)
  end

  def correct_word?(guess)
    return unless @word.eql?(guess)

    puts @word.join
    puts 'You won!'
    exit
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
