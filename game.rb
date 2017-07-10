require 'unicode_utils/downcase'

class Game
  def initialize(letters)
    @letters = get_letters(letters)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(letters)
    if letters == nil || letters == ""
      abort "Для игры введите загаданное слово в качестве аргумента при запуске программы"
    end
    return letters.split("")
  end

  def ask_next_letter
    puts "Введите следующую букву"
    letter = ""
    while letter == "" do
      letter = UnicodeUtils.downcase(STDIN.gets.chomp)
    end
    next_step(letter)
  end

  def next_step(letter)
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(letter) ||
      @bad_letters.include?(letter)
      return 0
    end

    if(@letters.include?("ё") && letter == "е") || (@letters.include?("е") && letter == "ё")
      @good_letters.push("е")
      @good_letters.push(letter)
    elsif(@letters.include?("й") && letter == "и") || (@letters.include?("и") && letter == "й")
      @good_letters.push("и")
      @good_letters.push(letter)
    elsif @letters.include?(letter)
      @good_letters.push(letter)
      if @letters.uniq - @good_letters == []
        @status = 1
      end
    else
      @bad_letters.push(letter)
      @errors += 1
      if @errors >= 7
        @status = -1
      end
    end
  end

  def status
    @status
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
