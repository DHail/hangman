require 'sinatra'
require 'sinatra/reloader'
require 'open-uri'

class Hangman

	@@array_word = []
	@@array_good_guesses = []
	@@array_bad_guesses = []
	
	def initialize
		
	end

	def self.get_word(letters)

		array_matching_words = [] #To hold all words in dictionary with number of letters seleted by player
		url = "http://s3.amazonaws.com/viking_education/web_development/web_app_eng/enable.txt"
		local_file = "enable.txt"
		dictionary = File.open(local_file, "r")
		##dictionary = File.open("enable.txt", "r")#replace this with url stuff
		#dictionary = dictionary.read
		
		dictionary.each_line do |word|
			if word.chomp.length == (letters)
				array_matching_words << word
			end
		end

		random_word_number = rand(array_matching_words.length - 1) #Position of the word in array
		random_word = array_matching_words[random_word_number].chomp

		@@array_word = random_word.split(//)

		@@array_good_guesses = []

		(@@array_word.length).times do |num|
			@@array_good_guesses[num] = '&nbsp;'
		end

		return @@array_bad_guesses, @@array_good_guesses, @@array_word
	end

	def self.check_guess(guess_letter)

		guess_letter = guess_letter.downcase

		@@array_word.each_with_index do |word_letter, letter_position|
			
			if guess_letter == word_letter
				@@array_good_guesses[letter_position] = word_letter
			end
		end

		unless @@array_good_guesses.include?(guess_letter)
			
			unless @@array_bad_guesses.include?(guess_letter)
				@@array_bad_guesses << guess_letter
			end

			return @@array_bad_guesses, @@array_good_guesses, @@array_word
		end
		return @@array_bad_guesses, @@array_good_guesses, @@array_word
	end

	def self.new_game

		@@array_word = []
		@@array_good_guesses = nil
		@@array_bad_guesses = []
		
		return @@array_bad_guesses, @@array_good_guesses, @@array_word

	end
end

get '/' do
	
	if params['make'] != nil
		if params['make'] == ''
			make = 7
		else
			make = params['make'].to_i
		end
		bad_guesses, good_guesses, word = Hangman.get_word(make)
	elsif params['guess'] != nil
		guess = params['guess'].to_s
		bad_guesses, good_guesses, word = Hangman.check_guess(guess)
	elsif params['game'] != nil
		game = params['game'].to_s
		bad_guesses, good_guesses, word = Hangman.new_game
	end
  erb :index, :locals => {:bad_guesses => bad_guesses, :good_guesses => good_guesses, :word => word}
end
