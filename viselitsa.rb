current_path =  "./" + File.dirname(__FILE__)

require current_path + "/lib/game.rb"
require current_path + "/lib/result_printer.rb"
require current_path + "/lib/word_reader.rb"

VERSION = "Игра Виселица, версия 4."

reader = WordReader.new
letters = reader.read_from_file(current_path + "/data/words.txt")
game = Game.new(letters)
printer = ResultPrinter.new(game)
game.version = VERSION

while game.in_progress? do
  printer.print_status(game)
  game.ask_next_letter
  printer.print_viselitsa(game.errors)
end
printer.print_status(game)
