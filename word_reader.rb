class WordReader
  def initialize
    @lines = []
  end

  def read_from_file(address)
    if File.exist?(address)
      f = File.new(address,"r:UTF-8")
      @lines = f.readlines
      f.close #закрытие файла
    else
      puts "Файл не найден"
    end
    return @lines.sample.chomp
  end
end


