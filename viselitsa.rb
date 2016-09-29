
current_path = "./" + File.dirname(__FILE__)

require current_path + "/lib/game.rb"
require current_path + "/lib/result_printer.rb"
require current_path + "/lib/word_reader.rb"

puts "Игра виселица.\n\n"

# Путь, откуда брать картинки
images_file_name = current_path + "/image"

# создаем объект, печатающий результаты
printer = ResultPrinter.new(images_file_name)

# создаем объект, отвечающий за ввод слова в игру
word_reader = WordReader.new

# Имя файла, откуда брать слово для загадывания
words_file_name = current_path + "/data/words.txt"

# создаем объект типа Game, в конструкторе передаем загаданное слово из word_reader-а
game = Game.new(word_reader.read_from_file(words_file_name))

# основной цикл программы, в котором развивается игра
# выходим из цикла, когда объект игры сообщит нам, c пом. метода status
while game.status == 0 do
  # выводим статус игры
  printer.print_status(game)
  # просим угадать следующую букву
  game.ask_next_letter
end

printer.print_status(game)