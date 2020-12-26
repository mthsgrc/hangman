=begin
  - user should be given a word between 5 and 12 characters long
  - draw word secret layout
  - get guess of the player
  - test letter on secret
  - redraw board with guess - all guesses
  - show wrong letters 
  - show left guesses
  - 
=end

# |---|
# |   O
# |  /|\
# |  / \

require "pry"
require_relative "hangman_figures.rb"

# print draw_hangman_figure(3)

class Hangman
  attr_reader :secret_word
  attr_accessor :guess, :wrong_letters_guessed, :rounds

  def initialize#(name)
    # @name = name
    @secret_word = random_secret_word.downcase
    @wrong_letters_guessed = []
    p @secret_word
    # binding.pry
    set_game(@secret_word, @guess)
  end


  private

  def set_game(secret_word, guess)
    puts
    puts "The Secret Word has #{secret_word.length} letters.\n\n"
    count = secret_word.length
    char_spaces = ""
    while count > 0
      char_spaces +=  "_ "
      count -= 1
    end
    @guess = char_spaces.strip
    print char_spaces.strip
    @rounds = 0

    # binding.pry

    get_letter_guess
  end

  def get_letter_guess
    letter_guess = ""

    until letter_guess.length == 1 && letter_guess[0].match?(/[a-zçãáéíóú]/) || letter_guess == @secret_word
      puts "\nChoose a letter between 'a' and 'z':"
      letter_guess = gets.chomp
    end

    test_letter(letter_guess)
  end


  def test_letter(letter)
    if @secret_word.include?(letter)
      puts "\n'#{letter}' included in Secret Word"

      fill_letter(letter)

    else

      @rounds += 1
      puts "\n'#{letter}' is not included in Secret Word"
      @wrong_letters_guessed << letter #if @secret_word.include?(letter) == false
      @wrong_letters_guessed.uniq!
      puts "Letters wrongly guessed: #{@wrong_letters_guessed.join(", ")}"

      # binding.pry
    end
    check_win
  end

  def fill_letter(letter)

    array_secret = @secret_word.strip.split("")
    array_guess = @guess.gsub(" ", "").split("")

    array_secret.each_with_index do |char, idx|
      array_guess[idx] = letter if char == letter
    end
    @guess = array_guess.join

    # update_game(array_guess)

    # binding.pry
  end


  def update_game(new_guess)
  	guess = new_guess.split("")
    puts "Game so far:"
    # binding.pry
    guess.each { |char| print "#{char} " }
    # binding.pry

  end

  def check_win
    if @secret_word == @guess
      puts "\nYou won! Secret word is #{@secret_word.upcase}."
      exit
    else
      puts "#{@rounds} wrong guesses. Make it 6 and you lose."
      puts "Try another letter"
    end


    update_game(@guess.gsub(" ", ""))
    get_letter_guess

  end


  def random_secret_word
    word = ""
    while word.length <= 5 || word.length > 12
      word = File.open("5desk.txt", "r").readlines.sample
    end
    word.chomp
  end
end



Hangman.new
