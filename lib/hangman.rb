=begin
  - user should be given a word between 5 and 12 characters long
  - draw word secret layout
  - get guess of the player
  - test letter on secret
  - redraw board with guess
=end

# |---|
# |   O
# |  /|\
# |  / \

require "pry"


class Hangman
  attr_reader :secret_word
  attr_accessor :guess, :all_letters_guessed

  def initialize#(name)
    # @name = name
    @secret_word = raffle_secret_word.downcase #random word
    @all_letters_guessed = []
    p @secret_word
    # binding.pry
    set_game(@secret_word, @guess)
  end


  private

  def set_game(secret_word, guess)
    puts
    puts "The Secret Word has #{secret_word.length} letters.\n\n"
    count = secret_word.length
    secret_chars = ""
    while count > 0
      secret_chars +=  "_ "
      count -= 1
    end
    @guess = secret_chars.strip
    print secret_chars.strip

    get_letter_guess
  end

  def get_letter_guess
    letter_guess = ""
    until letter_guess.length == 1 && letter_guess[0].match?(/[a-z]/)
      puts "\nChoose a letter between 'a' and 'z':"
      letter_guess = gets.chomp
    end

    @all_letters_guessed << letter_guess

    test_letter(letter_guess)
  end


  def test_letter(letter)
    if @secret_word.include?(letter)
      fill_letter(letter)

      puts "\n#{letter} included in Secret Word"

    else
      puts "\n#{letter} is not included in Secret Word"
    end
  end

  def fill_letter(letter)
    # binding.pry
    array_secret = @secret_word.strip.split("")
    array_guess = @guess.gsub(" ", "").split("")

    array_secret.each_with_index do |char, idx|
      if char == letter
        array_guess[idx] = letter
      end
    end
    update_game(array_guess)
    check_win
  end


  def update_game(current_guess)
    current_guess.each { |char| print "#{char} " }
    # binding.pry

  end

  def check_win
    if @secret_word == @guess
      puts "You won!"
    else
      puts "Try another letter"
    end


  end


  def raffle_secret_word
    word = ""
    while word.length <= 5 || word.length > 12
      word = File.open("5desk.txt", "r").readlines.sample
    end
    word.chomp
  end
end



Hangman.new


# |---|
# |   O
# |  /|\
# |  / \
