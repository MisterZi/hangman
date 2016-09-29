require 'unicode_utils/downcase'

# Класс, отвечающий за ввод данных в программу "виселица"

class WordReader

  # Возможность читать слово из аргументов командной строки.
  # В качестве отедльного метода для обратной совместимости.
  def read_from_args
    return ARGV[0]
  end

  # Метод, возвращающий случайное слово, прочитанное из файла 
  def read_from_file(file_name)        
    # проверка на наличие файла
    begin
      f = File.new(file_name, "r:UTF-8")
      lines = f.readlines   # читаем все строки в массив
      f.close # закрываем файл
    rescue Errno::ENOENT
      abort "Не найден файл: " + file_name
    end

    # возвращаем случайную строчку из прочитанного массива
    return UnicodeUtils.downcase(lines.sample.chomp)    
  end
end