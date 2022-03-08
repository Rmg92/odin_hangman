# frozen_string_literal: true

# module with the code for loading and writing files
module Database
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
