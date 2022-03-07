# Hangman
This project is part of [The Odin Project](https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/hangman) Full Stack Ruby curriculum.

## Description
For this implementation of the hangman game the computer picks a random english word between 5 and 12 characters.
The player can then try to guess the word by guessing the characters or the complete word.
The player has 8 wrong tries to guess the word

## Rules
* The player has 8 wrong tries to guess the word
* The player can guess a character or the complete word
* The player wins the game if he guesses all the characters or the complete word in less than 8 wrong guesses
* The player loses the game if he makes more than 8 wrong guesses

## Built with
* Ruby

## Play Online
[replit.com](https://replit.com/@Rmg92/odinhangman-2?v=1)

## Play Locally
### Prerequisites
You need to have Ruby installed to play locally.

### Procedure
Clone the repo to a folder of your preference

cd into the folder and:
```sh
ruby lib/main.rb
```
## What I Learned \ Reflections
With this project I was able to pratice reading files using the Objects provided by ruby.
One of the hardest parts was serializing the entire class, but after some research I managed to do it and then I was able to save the game state to a file.
Loading the game also posed some problems because I was checking some old information, but after checking the docs I managed to find the problem and solve it.

## Acknowledgments
* [The Odin Project](https://www.theodinproject.com/)
* [Github](https://github.com/)
* [Replit](https://replit.com/)