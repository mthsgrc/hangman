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
  attr_accessor :guess

  def initialize#(name)
    # @name = name
    @secret_word = raffle_secret_word
    p @secret_word
    set_game(@secret_word)

    @guess = ""
  end


  private

  def set_game(secret_word)
    puts
    puts "The Secret Word has #{secret_word.length} letters.\n\n"

    count = secret_word.length
    while count > 0
      print "_ "
      count -= 1
    end
    print "\n\nGuess a letter to start playing:\n"
    get_guess
  end

  def get_guess
    guess = ""
    until guess.length == 1 && guess[0].match?(/[a-z]/)
      puts "Choose a letter between 'a' and 'z'"
      guess = gets.chomp
    end
  end

  

  def check_win
    puts "You won!" if @secret_word == @guess
  end


  def raffle_secret_word
    word = ""
    while word.length < 5 || word.length > 12
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
