require 'sinatra'
require 'sinatra/reloader'
require 'open-uri'

class Hangman

	@@bad_guesses = 0
	@@array_word = []
	@@array_good_guesses = []
	@@array_bad_guesses = []
	@@game_status = "ongoing"
	
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
			if word.length == (letters + 1) #must be one more than desired cuz of new line char
				array_matching_words << word
			end
		end

		random_word_number = rand(array_matching_words.length - 1) #Number of word for game chosen
		random_word = array_matching_words[random_word_number]

		@@array_word = random_word.split(//)
		@@array_word.pop #remove new line char

		(@@array_word.length).times do |num|
			@@array_good_guesses[num] = nil
		end

		return @@game_status, @@array_bad_guesses, @@array_good_guesses, @@array_word
	end

	def self.check_guess(guess_letter)

		guess_letter = guess_letter.downcase

		@@array_word.each_with_index do |word_letter, letter_position|
			
			if guess_letter == word_letter
				@@array_good_guesses[letter_position] = word_letter
				unless @@array_good_guesses.include?(nil)
					@@array_good_guesses = []
					@@array_bad_guesses = []
					@@array_word = []
					@@game_status = "won"
					return @@game_status, @@array_bad_guesses, @@array_good_guesses, @@array_word
				end
			end
		end

		unless @@array_good_guesses.include?(guess_letter)
			
			unless @@array_bad_guesses.include?(guess_letter)
				@@array_bad_guesses << guess_letter
			end
			
			if @@array_bad_guesses.length >= 5
				@@game_status = "lost"
				@@array_bad_guesses = []
				return @@game_status, @@array_bad_guesses, @@array_good_guesses, @@array_word
			end

			@@bad_guesses += 1
			@@game_status = "ongoing"
			return @@game_status, @@array_bad_guesses, @@array_good_guesses, @@array_word
		end
		return @@game_status, @@array_bad_guesses, @@array_good_guesses, @@array_word
	end
end

get '/' do
	
	if params['make'] != nil
		make = params['make'].to_i
		game_status, bad_guesses, good_guesses, word = Hangman.get_word(make)
	elsif params['guess'] != nil
		guess = params['guess'].to_s
		game_status, bad_guesses, good_guesses, word = Hangman.check_guess(guess)
	end
  erb :index, :locals => {:game_status => game_status, :bad_guesses => bad_guesses, :good_guesses => good_guesses, :word => word}
end
