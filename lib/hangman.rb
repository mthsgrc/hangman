=begin
  - user should be given a word between 5 and 12 characters long
=end
require "pry"


class Hangman
  def initialize#(name)
    # @name = name
    @secret_word = choose_word
    # puts @secret_word
    start_game(@secret_word)
  end

  def start_game(secret_word)

  end




  private

  def choose_word
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