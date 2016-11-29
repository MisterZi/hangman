require 'unicode_utils/downcase'

# Основной класс игры. Хранит состояние игры и предоставляет функции
# для развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.)


class Game

  attr_reader :errors, :letters, :good_letters, :bad_letters

  def initialize(slovo)
    # инициализируем данные как поля класса
    @letters = get_letters(slovo)

    # кол-ва ошибок, максимум - 7
    @errors = 0

    # массивы, хранящие угаданные и неугаданные буквы
    @good_letters = []
    @bad_letters = []

    # индикатор состояния игры
    @status = 0
  end

  # Метод, который возвращает массив букв загаданного слова
  def get_letters(slovo)
    if (slovo == nil || slovo == "")
      abort "Слово не задано!"
    else
      slovo = slovo.encode("UTF-8")
    end

    return slovo.split("")
  end

  # Метод возвращает статус игры
  # 0 – игра активна, -1 – игра закончена поражением, 1 – игра закончена победой
  def status
    return @status
  end


  # Основной метод игры "сделать следующий шаг"  
  def next_step(bukva)

    # Предварительная проверка: если статус игры равен 1 или -1, значит игра закончена,
    # нет смысла дальше делать шаг
    if @status == -1 || @status == 1
      return # выходим из метода возвращая пустое значение
    end

    # если введенная буква уже есть в списке "правильных" или "ошибочных" букв,
    # то ничего не изменилось, выходим из метода
    if @good_letters.include?(bukva) || @bad_letters.include?(bukva)
      return
    end

    if @letters.include? bukva ||
      (bukva == "е" && @letters.include?("ё")) ||
      (bukva == "ё" && @letters.include?("е")) || 
      (bukva == "и" && @letters.include?("й")) ||
      (bukva == "й" && @letters.include?("и")) # если в слове есть буква

      @good_letters << bukva # запишем её в число "правильных" буква

      case bukva
      when 'е'
        @good_letters << "ё"
      when 'ё'
        @good_letters << "е"
      when 'и'
        @good_letters << "й"
      when 'й'
        @good_letters << "и"
      end
      
      # дополнительная проверка - угадано ли на этой букве все слово целиком
      if (letters - good_letters).empty?
        @status = 1 # статус - победа
      end

    else # если в слове нет введенной буквы – добавляем ошибочную букву и увеличиваем счетчик

      @bad_letters << bukva
      
      @errors += 1

      if @errors >= 7 # если ошибок больше 7 - статус игры -1, проигрышь
        @status = -1
      end
    end
  end

  # Метод, спрашивающий юзера букву и возвращающий ее как результат.
  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""
    while letter == "" do
      letter = STDIN.gets.encode("UTF-8").chomp
    end
    # после получения ввода, передаем управление в основной метод игры
    next_step(UnicodeUtils.downcase(letter))
  end
  
end