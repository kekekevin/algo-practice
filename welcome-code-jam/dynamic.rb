class Dynamic

	def initialize
		@input_string = "wweellccoommee to code qps jam"
		@search_string = "welcome to code jam"
		@result_table = Array.new(@input_string.length) { Array.new(@search_string.length) }
	end

	def get_value(x, y)
		if x < 0 || y < 0
			0
		else
			@result_table[x][y]
		end
	end

	def populate_result_table
		@input_string.each_char.with_index do | input_char, x |
			@search_string.each_char.with_index do | search_char, y |
				if input_char == search_char
					if y == 0
						@result_table[x][y] = 1 + get_value(x-1, 0)
					else
						@result_table[x][y] = get_value(x - 1, y - 1) + get_value(x - 1, y)
					end
				else
					@result_table[x][y] = get_value(x - 1, y)
				end
			end
		end 
	end

	def print
		@result_table.each_with_index do | row, x |
			row.each_with_index do | val, y |
				puts "#{x} #{y} #{val}"
			end
		end
	end

end

dynamic = Dynamic.new
dynamic.populate_result_table
dynamic.print
