=begin
  - user should be given a word between 5 and 12 characters long
  - draw word secret layout
  - get guess of the player
  - test letter on secret
  - redraw board with guess - all guesses
=end

# |---|
# |   O
# |  /|\
# |  / \

require "pry"


class Hangman
  attr_reader :secret_word
  attr_accessor :guess, :wrong_letters_guessed

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

    # binding.pry

    get_letter_guess
  end

  def get_letter_guess
    letter_guess = ""

    until letter_guess.length == 1 && letter_guess[0].match?(/[a-zç]/) || letter_guess == @secret_word
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

      puts "\n'#{letter}' is not included in Secret Word"
      @wrong_letters_guessed << letter if @secret_word.include?(letter) == false
      @wrong_letters_guessed.uniq!
      # binding.pry
    end

  end

  def fill_letter(letter)
    array_secret = @secret_word.strip.split("")
    array_guess = @guess.gsub(" ", "").split("")

    # binding.pry
    array_secret.each_with_index do |char, idx|
      if char == letter
        array_guess[idx] = letter
      end
    end
    @guess = array_guess.join
    update_game(array_guess)
    check_win
  end


  def update_game(current_guess)
    current_guess.each { |char| print "#{char} " }
    # binding.pry

  end

  def check_win
    if @secret_word == @guess
      puts "\nYou won!"
    else
      puts "\nHaven't found the secret word yet. Try another letter"
      get_letter_guess
    end
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
