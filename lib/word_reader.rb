class WordReader
  def initialize
    @lines = []
  end

  def file_exist?(path)
    File.exist?(path)
  end

  def read_from_file(path)
    if file_exist?(path)
      f = File.new(path, "r:UTF-8")
      @lines = f.readlines
      f.close
    else
      puts "Файл не найден"
    end
    @lines.sample.chomp
  end
end


