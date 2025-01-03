require_relative 'data_table'

class DataList
	attr_reader :sorted_array
	private :sorted_array

	def initialize(array)
		self.sorted_array = []
		self.sorted_array = array
		@names = [] # Имена столбцов, задаются наследником
	end

	# Метод-сеттер для обновления массива объектов
	def sorted_array=(new_array)
		# Проверяем, что это массив
		raise ArgumentError, 'Должен быть передан массив объектов' unless new_array.is_a?(Array)

		# Обновляем массив объектов
		@sorted_array = []
		new_array.sort { |a, b| b <=> a }.each do |element|
		  @sorted_array.append({ value: element, selected: false })
		end
	end

	def [](index)
		self.sorted_array[index]
	end

	def to_s
		self.sorted_array.to_s
	end

	def select(index)
		self.sorted_array[index - 1][:selected] = true
	end

	def get_selected
		self.sorted_array.find_all { |element| element[:selected] == true }
	end

	# Шаблонный метод для get_data
	def get_data
		get_names # Настраивает @names
		prepare_data # Формирует таблицу
	end

	# Методы, которые должны быть реализованы в наследниках
	protected def get_names
		raise NotImplementedError, 'Метод get_names должен быть реализован в наследнике'
	end

	private def prepare_data
	    table_data = []

	    # Формируем строки таблицы
	    self.sorted_array.each_with_index do |element, index|
	      row = [index + 1] # Нулевой столбец — порядковый номер
	      @names.each do |name|
	        row << element[:value].instance_variable_get(name)
	      end
	      table_data << row
	    end

	    # Создаём объект DataTable
	    DataTable.new(table_data).to_s
	end
end