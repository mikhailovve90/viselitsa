class ResultPrinter
  def initialize(game)
    @status_image = []
    current_path = File.dirname(__FILE__)
    counter = 0

    while counter <= game.max_errors do
      file_name = current_path + "/../image/im#{counter}.txt"
      if File.exist?(file_name)
        f = File.new(file_name, "r:UTF-8")
        @status_image << f.read
        f.close
      else
        @status_image << "\n [ изображение не найдено ] \n"
      end
      counter += 1
    end
  end

  def print_status(game)
    cls
    puts "Слово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки: #{game.bad_letters.join(", ").to_s}"

    if game.lost?
      puts "Вы проиграли :("
      puts "Загаданное слово было: " + game.letters.join("")
    elsif game.won?
      puts "Поздравляем, вы выиграли!"
    else
      puts "У вас осталось ошибок: #{game.errors_left}"
    end
    print_viselitsa(game.errors)
  end

  def cls
    system('cls')
  end

  def get_word_for_print(letters, good_letters)
    result = ""
    for item in letters do
      if good_letters.include?(item)
        result += item + " "
      else
        result += "__ "
      end
    end
    return result
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end
end
