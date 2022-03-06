# frozen_string_literal: true

require_relative 'display'
require 'yaml'

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
    display_rules
    load_game if gets.chomp.to_i.eql?(1)
    display_game_start
    play_round until @game_end
    display_result
    play_again
  end

  def play_round
    check_guess(player_input)
    @game_end = true if correct_word?(@right_guesses) || @remaining_guesses.zero?
    display_round
  end

  def player_input
    puts 'Input 1 to save your game and exit, input a letter or word to make a guess'
    input = gets.chomp.downcase
    if input.to_i.eql?(1)
      save_game
    elsif valid_input?(input)
      input
    else
      display_invalid_input
      player_input
    end
  end

  def check_guess(guess)
    if guess.length > 1 && correct_word?(guess.split(''))
      @game_end = true
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

  def valid_input?(input)
    valid = true
    input.each_char { |char| valid = false unless char.match?(/[a-z]/) }
    valid
  end

  def play_again
    display_play_again
    Game.new if gets.chomp.to_i.eql?(1)
  end

  def choose_word
    word = load_dictionary[rand(load_dictionary.length)]
    if word.length.between?(5, 12)
      word
    else
      choose_word
    end
  end

  def save_game
    Dir.mkdir('./saved_games') unless Dir.exist?('./saved_games')
    filename = "./saved_games/#{choose_word}_#{choose_word}.yaml"
    File.open(filename, 'w') { |file| YAML.dump([] << self, file) }
    puts 'Game Saved. Goodbye!'
    exit
  end

  def load_game
    puts 'Wich game do you want to load?'
    save_list = []
    Dir.glob('**', base: './saved_games').each { |file| save_list << file.to_s }
    save_list.each_with_index { |file, index| puts "#{index}: #{file}" }
    save_game = YAML.load_file("./saved_games/#{save_list[gets.to_i]}", permitted_classes: [Game])
    load_saved_variables(save_game)
  end

  def load_saved_variables(save_game)
    @word = save_game[0].instance_variable_get('@word')
    @right_guesses = save_game[0].instance_variable_get('@right_guesses')
    @wrong_guesses = save_game[0].instance_variable_get('@wrong_guesses')
    @remaining_guesses = save_game[0].instance_variable_get('@remaining_guesses')
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
