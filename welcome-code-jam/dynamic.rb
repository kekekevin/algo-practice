class Dynamic

  def initialize
    @search_string = "welcome to code jam"
  end

  def get_value(x, y)
    if x < 0 || y < 0
      0
    else
      @result_table[x][y]
    end
  end

  def populate_result_table
    @input_string.each_char.with_index do |input_char, x|
      @search_string.each_char.with_index do |search_char, y|
        if input_char == search_char
          if y == 0
            @result_table[x][y] = 1 + get_value(x - 1, 0)
          else
            @result_table[x][y] = get_value(x - 1, y - 1) + get_value(x - 1, y)
          end
        else
          @result_table[x][y] = get_value(x - 1, y)
        end
      end
    end
  end

  def result(input_string)
    @input_string = input_string
    @result_table = Array.new(@input_string.length) { Array.new(@search_string.length) }

    self.populate_result_table

    @result_table[-1][-1]
  end

end

dynamic = Dynamic.new
in_file = File.open("C-large-practice.in", "r")
num_inputs = in_file.readline
out_file = File.open("practice.out", "w")

(1..num_inputs.to_i).each do |i|
  out_file.puts "Case \##{i}: #{dynamic.result(in_file.readline).to_s.rjust(4, '0')[-4..-1]}"
end

out_file.close
in_file.close
