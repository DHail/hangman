word = "hello\n"

print word
print word.length
print word.chomp.length


=begin
class Hangman

	def initialize
		@bad_guesses = 0
		@array_word = []
		@array_good_guesses = []
		@array_bad_guesses = []
		@game_status = "ongoing"
	end

	def get_word(letters)

		array_matching_words = [] #To hold all words in dictionary with number of letters seleted by player

		dictionary = File.open("enable.txt", "r")#replace this with url stuff
		dictionary = dictionary.read
		
		dictionary.each_line do |word|
			if word.length == (letters + 1) #must be one more than desired cuz of \n char
				array_matching_words << word
			end
		end

		random_word_number = rand(array_matching_words.length - 1) #Number of word for game chosen
		random_word = array_matching_words[random_word_number]

		@array_word = random_word.split(//)
		@array_word.pop

		(@array_word.length).times do |num|
			@array_good_guesses << nil
		end

		return @array_good_guesses, @array_word
	end

	def check_guess(guess_letter)

		guess_letter = guess_letter.downcase

		@array_word.each_with_index do |word_letter, letter_position|
			
			if guess_letter == word_letter
				@array_good_guesses[letter_position] = word_letter
				unless @array_good_guesses.include?(nil)
					@game_status = "won"
					return @game_status
				end
			end
		end

		unless @array_good_guesses.include?(guess_letter)
			@array_bad_guesses << guess_letter
			
			if @array_bad_guesses.length >= 5
				@game_status = "lost"
				return @game_status
			end

			@bad_guesses += 1
			@game_status = "ongoing"
			return @game_status, @array_good_guesses, @array_good_guesses
		end
	end
end

my_game = Hangman.new

print my_game.get_word(6)
print my_game.check_guess("a")




=begin
require 'open-uri'

		array_word = []
		array_guesses = []

		array_matching_words = [] #To hold all words in dictionary with number of letters seleted by player
		url = "http://s3.amazonaws.com/viking_education/web_development/web_app_eng/enable.txt"
		local_file = "enable.txt"
		dictionary = File.open(local_file, "r")
	
		dictionary.each_line do |word|
			if word.length == (6) #must be one more than desired cuz of \n char
				array_matching_words << word
			end
		end

		random_word_number = rand(array_matching_words.length - 1) #Number of word for game chosen
		random_word = array_matching_words[random_word_number]

		array_word = random_word.split(//)
		array_word.pop

		(array_word.length).times do |num|
			array_guesses << nil
		end

		print array_word
		print array_guesses



	def check_guess(guess_letter)

		guess_letter = guess_letter.downcase

		array_word.each_with_index do |word_letter, letter_position|
			if guess_letter == word_letter
				array_good_guesses[letter_position] = word_letter
				unless array_good_guesses.include?(nil)
					game_status = "won"
					return game_status
				end
				puts array_good_guesses
			end
		end

		unless array_good_guesses.include?(guess_letter)
			array_bad_guesses << guess_letter
			if array_bad_guesses.length >= 5
				game_status = "lost"
				return game_status
			end
			game_status = "ongoing"
			return game_status
		end

	end

	puts check_guess("v")


=begin

url = "http://s3.amazonaws.com/viking_education/web_development/web_app_eng/enable.txt"

array = []

local_fname = "enable.txt"
dictionary = File.open(local_fname, "r")
dictionary.each_line do |line|
	if line.length == 3 #must be one more than desired cuz of \n char
		array << line
	end
end

rand = rand(array.length - 1)

puts array[rand]


contents = dictionary.read
array = []

array = contents.split("\n")

random_word = rand(array.length)

print array[random_word]


new_var = File.open(url, "r")
new_contents = new_var.read
print new_contents

new_array = []

new_array = open(url)


dictionary = File.open("enable.txt", "r")
contents = dictionary.read

array = []

array = contents.split("\n")

random_word = rand(array.length)

print array[random_word]


new_array = ['', '', '', '', '']

puts new_array.length
puts new_array
=end