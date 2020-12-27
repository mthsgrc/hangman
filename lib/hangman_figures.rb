
def draw_hangman_figure(round)
  case round
  when 0  
  hangman = "\t|---|\r
        |    \r
        |      \r
        |      "
  when 1
  hangman = "\t|---|\r
        |   O\r
        |      \r
        |      "
  when 2
  hangman = "\t|---|\r
        |   O\r
        |  /   \r
        |      "
  when 3
  hangman = "\t|---|\r
        |   O\r
        |  / \\\r
        |      "
  when 4
  hangman = "\t|---|\r
        |   O\r
        |  /|\\\r
        |      "
  when 5
  hangman = "\t|---|\r
        |   O\r
        |  /|\\\r
        |  /   "
  when 6
  hangman = "\t|---|\r
        |   O\r
        |  /|\\\r
        |  / \\\r 
        |      "
 end
 hangman
end

