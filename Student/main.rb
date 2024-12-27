#Подключаем класс студентов из отдельного файла
require_relative 'student'
require_relative 'person'
require_relative 'student_short'
require_relative 'binary_tree'
require_relative "../patterns_classes/data_list_student_short"
require_relative 'StudentListJSON'
require_relative 'StudentListYAML'

# Создаем несколько экземпляров класса с разными комбинациями необязательных полей
student_example = Student.new(
	id: 1,
	last_name: "Петров",
	first_name: "Петя",
	middle_name: "Петрович", 
	phone: 12345678901,
	telegram: "@exmpltg",
	git: "github.com/example",
	birthdate: "1998/07/23"
)
student_me = Student.new(
	id: 2,
	last_name: "Дука",
	first_name: "Виталий",
	middle_name: "Андреевич", 
	email: "twinknezz@gmail.com",
	git: "github.com/sdnezz",
	birthdate: "1995/06/15"
)
student_valya = Student.new(
	id: 3,
	last_name: "Кислый",
	first_name: "Валентин",
	middle_name: "Кирилыч", 
	phone: 88005353531,
	telegram: "@kislayavalya",
	birthdate: "1992/12/30"
)

# Вызываем метод вывода информации об объекте класса на экран
puts student_example
# Изменяем контакты, только обращаясь к методу объекта класса для них
student_example.set_contacts(phone: 89998887766, email: "new_email@example.com")
puts student_example
# Проверяем наличие гита и контактов
student_example.validate_git_and_contact

# Выводим гит, инициалы и контакты через отдельные методы объекта класса
puts student_example.short_name
puts student_example.short_info
puts student_example.contact_info

# Выводим краткую информацию через метод объекта класса
puts student_example.get_info

# Создаем объект класса с краткой информацией, передавая туда уже созданный объект другого класса
student_example_short = StudentShort.new_from_student(student_example)
student_me_short = StudentShort.new_from_student(student_me)
student_valya_short = StudentShort.new_from_student(student_valya)
student_example_short_2 = StudentShort.new_from_string(id: 2, str: "Иванов И.И.; github.com/ivan; ivan@example.com")
puts student_example_short_2
puts 
puts
students = [student_example, student_me, student_valya]

students_short = [student_example_short, student_me_short, student_valya_short]

# Создаём объект DataListStudentShort
data_list_student_short = DataListStudentShort.new(students_short)

# Вызываем метод get_data и выводим результат
puts "Данные таблицы студентов:"
puts data_list_student_short.get_data

data_list_student_short.sorted_array = [student_me_short,student_valya_short]
puts "Данные таблицы студентов:"
puts data_list_student_short.get_data

students_list = StudentsListJSON.new(filepath: 'students.json')

# Чтение из файла
students_list.read_from_file

# Выводим всех студентов
puts "Список студентов c jsona:"
students_list.student_array.each { |student| puts student }

# Добавляем нового студента
new_student = Student.new(
  id: 4,
  first_name: "Иван",
  last_name: "Иванов",
  middle_name: "Иванович",
  git: "github.com/ivan",
  phone: "+79123456789",
  email: "ivanov@example.com"
)
students_list.add_student(new_student)

# Сохраняем изменения в файл
students_list.write_to_file

# Получаем студента по ID
puts "Студент с ID 2:"
puts students_list.get_student_by_id(2)

# Получаем страницу объектов StudentShort
puts "Первая страница объектов StudentShort:"
data_list = students_list.get_k_n_student_short_list(page: 1, amount_rows: 2)
puts data_list.get_data

# Удаляем студента по ID
students_list.delete_student_by_id(3)

# Сохраняем изменения
students_list.write_to_file

# Создаём объект
students_list = StudentsListYAML.new(filepath: 'students.yaml')

# Чтение из файла
students_list.read_from_file

# Вывод студентов
puts "Список студентов с yml:"
students_list.student_array.each { |student| puts student }

# Добавление нового студента
new_student = Student.new(
  first_name: "Иван",
  last_name: "Иванов",
  middle_name: "Иванович",
  git: "github.com/ivan",
  phone: "+79112223344",
  email: "ivanov@example.com"
)
students_list.add_student(new_student)

# Запись в файл
students_list.write_to_file

# Получение студента по ID
puts students_list.get_student_by_id(1)

# Получение страницы объектов StudentShort
puts students_list.get_k_n_student_short_list(page: 1, amount_rows: 2).get_data
