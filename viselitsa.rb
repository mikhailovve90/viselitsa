current_path =  "./" + File.dirname(__FILE__)

require current_path + "/game.rb"
require current_path + "/result_printer.rb"
require current_path + "/word_reader.rb"

reader = WordReader.new
letters = reader.read_from_file(current_path + "/data/words.txt")
game = Game.new(letters)
printer = ResultPrinter.new

while game.status == 0 do
  printer.print_status(game)
  game.ask_next_letter
  printer.print_viselitsa(game.errors)
end
printer.print_status(game)
