# frozen_string_literal: true

require_relative 'display'

# Contains the game logic
class Game
  include Display

  def initialize
    @word = choose_word.split('')
    @right_guesses = Array.new(@word.length, '_')
    @wrong_guesses = []
    @remaining_guesses = 8
    play
  end

  def play
    puts display_rules, display_game_start
    play_round until @remaining_guesses.zero?
    puts @word.join
  end

  def play_round
    input = player_input
    check_guess(input)
    puts display_round
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

  def check_guess(guess)
    # Add check for wrong inputs
    if guess.length > 1 && correct_word?(guess.split(''))
      puts @word.join
      puts 'You won!'
    elsif guess.length.eql?(1) && correct_letter?(guess)
      correct_position(guess)
    else
      @wrong_guesses << guess if guess.length.eql?(1)
      @remaining_guesses -= 1
    end
  end

  def correct_letter?(guess)
    true if @word.include?(guess)
  end

  def correct_word?(guess)
    true if @word.eql?(guess)
  end

  def correct_position(guess)
    @word.each_index do |index|
      @right_guesses[index] = guess if @word[index].eql?(guess)
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
