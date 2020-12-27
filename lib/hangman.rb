=begin
  - user should be given a word between 5 and 12 characters long
  - draw word secret layout
  - get guess of the player
  - test letter on secret
  - redraw board with guess - all guesses
  - show wrong letters 
  - show left guesses

  - implement save/load game
=end

require "yaml"
require_relative "hangman_figures.rb"

class Hangman
  attr_reader :secret_word
  attr_accessor :guess, :wrong_letters_guessed, :count_missed_letters
  TITLE = "====== HANGMAN GAME =======\n\n\n"

  def initialize
    @secret_word = random_secret_word.downcase
    @wrong_letters_guessed = []
    set_game(@secret_word, @guess)
  end


  private

  def set_game(secret_word, guess)
    system("clear") || system("cls")
    print TITLE
    new_or_load_game
  end

  def save_game
    save = YAML.dump({
                       :count_missed_letters => @count_missed_letters,
                       :secret_word => @secret_word,
                       :wrong_letters_guessed => @wrong_letters_guessed,
                       :guess => @guess
    })
    File.open("saved.yaml", "w") do |file|
      file.write save
    end
  end

  def load_game(file)
    state_loaded = YAML.load file

    @count_missed_letters = state_loaded[:count_missed_letters]
    @secret_word = state_loaded[:secret_word]
    @wrong_letters_guessed = state_loaded[:wrong_letters_guessed]
    @guess = state_loaded[:guess]
    update_game(@guess)
    get_letter_guess
  end

  def new_or_load_game
    response = ""
    print "Do you want to start a [N]ew Game or [L]oad a saved game?"
    until response == "N" || response == "L"
      response = gets.chomp.upcase
    end

    if response == "N"
      new_game
    elsif response == "L"
      load_game(save_game_file)
    end

  end

  def save_game_file
    File.open("./saved.yaml", "r")
  end

  def new_game
    system("clear") || system("cls")
    print TITLE
    @count_missed_letters = 0
    print "#{draw_hangman_figure(@count_missed_letters)}\t"
    create_guess_spaces
    print @guess
    puts "\n\nThe Secret Word has #{secret_word.length} letters.\n"
    get_letter_guess
  end

  def create_guess_spaces
    count = @secret_word.length
    char_spaces = ""
    while count > 0
      char_spaces +=  "_ "
      count -= 1
    end
    @guess = char_spaces.strip
  end

  def get_letter_guess
    letter_guess = ""
    # until letter_guess.length == 1 && letter_guess[0].match?(/[a-zçãáêéíóôú]/)
    until letter_guess.length == 1 && letter_guess[0].match?(/[a-z]/) || letter_guess == "/save"
      puts "\nChoose a letter between 'a' and 'z':"
      puts "Write '/save' to save the game."
      letter_guess = gets.chomp.downcase.strip
    end
    letter_guess == "/save" ? save_game : test_letter(letter_guess)
  end

  def test_letter(letter)
    if @secret_word.include?(letter)
      puts "\n'#{letter}' included in Secret Word"
      update_right_guess(letter)
    else
      @count_missed_letters += 1
      puts "\n'#{letter}' is not included in Secret Word"
      @wrong_letters_guessed << letter
      @wrong_letters_guessed.uniq!
    end
    check_win
  end

  def update_right_guess(letter)
    array_secret = @secret_word.strip.split("")
    array_guess = @guess.gsub(" ", "").split("")
    array_secret.each_with_index do |char, idx|
      array_guess[idx] = letter if char == letter
    end
    @guess = array_guess.join
  end


  def update_game(new_guess)
    system("clear") || system("cls")
    print TITLE
    guess = new_guess.split("")
    print "#{draw_hangman_figure(@count_missed_letters)}   "
    guess.each { |char| print "#{char} " }
    puts "\n\nLetters wrongly guessed: #{@wrong_letters_guessed.join(" ").strip}\n\n"
  end


  def check_win
    if @secret_word == @guess
      system("clear") || system("cls")
      print TITLE
      puts "Letters wrongly guessed: #{@wrong_letters_guessed.join(" ").strip}\n\n"
      print draw_hangman_figure(@count_missed_letters)
      puts "\tYou won! Secret word is #{@secret_word.upcase}.\n\n"
      exit
    elsif @count_missed_letters == 7
      update_game(@guess.gsub(" ", ""))
      print draw_hangman_figure(@count_missed_letters-1)
      puts "\tYou've lost! Secret word was #{@secret_word.upcase}.\n\n"
      exit
    else
      update_game(@guess.gsub(" ", ""))
      puts "#{@count_missed_letters} wrong guesses. Make it 6 and you lose."
    end
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
