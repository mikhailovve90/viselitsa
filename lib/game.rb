require 'unicode_utils/downcase'

class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status

  attr_accessor :version

  MAX_ERRORS = 7

  def initialize(letters)
    @letters = get_letters(letters)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = :in_progress # :won, :lost
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

  def is_good?(letter)
    @letters.include?(letter) ||
      (@letters.include?("ё") && letter == "е") ||
      (@letters.include?("е") && letter == "ё") ||
      (@letters.include?("й") && letter == "и") ||
      (@letters.include?("и") && letter == "й")
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when "и" then letters.push("й")
    when "й" then letters.push("и")
    when "е" then letters.push("ё")
    when "ё" then letters.push("е")
    end
  end

  def solved?
    (@letters.uniq - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def lost?
    @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def lost?
    @status == :lost  || @errors >= MAX_ERRORS
  end

  def next_step(letter)
    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      @status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)
      @errors += 1

      @status = :lost if lost?
    end
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end
end
