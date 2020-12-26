
def draw_hangman_figure(round)
  case round
  when 0  
  r0 = "\t|---|\r
        |    \r
        |      \r
        |      "
  when 1
  r1 = "\t|---|\r
        |   O\r
        |      \r
        |      "
  when 2
  r2 = "\t|---|\r
        |   O\r
        |  /   \r
        |      "
  when 3
  r3 = "\t|---|\r
        |   O\r
        |  / \\\r
        |      "
  when 4
  r4 = "\t|---|\r
        |   O\r
        |  /|\\\r
        |      "
  when 5
  r5 = "\t|---|\r
        |   O\r
        |  /|\\\r
        |  /   "
  when 6
  r6 = "\t|---|\r
        |   O\r
        |  /|\\\r
        |  / \\ "
 end
end
