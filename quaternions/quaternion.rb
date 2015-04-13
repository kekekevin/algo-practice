class Quaternion
  def initialize(file_name)
    @letter_map = {
      1 =>   { 1 => 1,  'i' => 'i',  'j' => 'j',  'k' => 'k'  },
      'i' => { 1 => 'i', 'i' => 1,   'j' => 'k',  'k' => 'j' },
      'j' => { 1 => 'j', 'i' => 'k',  'j' => 1,   'k' => 'i'    },
      'k' => { 1 => 'k', 'i' => 'j',  'j' => 'i',  'k' => 1   }
    }
    @sign_map = {
      1 =>   { 1 => 1, 'i' => 1,  'j' => 1,  'k' => 1  },
      'i' => { 1 => 1, 'i' => -1, 'j' => 1,  'k' => -1 },
      'j' => { 1 => 1, 'i' => -1, 'j' => -1, 'k' => 1  },
      'k' => { 1 => 1, 'i' => 1,  'j' => -1, 'k' => -1 }
    }
    out_file = File.open("#{file_name}.out", 'w')

    File.open(file_name, 'r') do |io|
      test_cases = io.readline.to_i
      (1..test_cases).each_with_index do |e, i|
        lx = io.readline.split
        l = lx[0].to_i
        x = lx[1].to_i
        input = io.readline.chomp * x
        # puts l
        # puts x


        # puts 'j: #{solve_j(input, i_index)}'
        # j_array = solve_j(input, i_array)
        # puts 'k: #{solve_k(input, j_index)}'
        # k_array = solve_k(input, k_array)


        out_file.print "Case ##{e}: "

        flag = false

        # i_array = solve_i(input)
        puts tail_calc(input)
        # i_array.each do |i|
          # j_array = solve_j(input, i)
          # j_array.each do |j|
            # k_array = solve_k(input, j)
            # if k_array
              # flag = true
            # end
          # end
        # end
        if flag
          out_file.puts 'YES'
        else
          out_file.puts 'NO'
        end

        # out_file.puts ''
      end
    end

    out_file.close
  end

  def tail_calc(input)
    tail_calc = Array.new(input.length - 1)
    (0..input.length - 1).each do |i|
      letter = 1
      sign = 1
      (i..input.length - 1).each do |j|
        sign = sign * multiply_sign(letter, input[i])
        letter = multiply_letter(letter, input[i])
      end
      # tail_calc << { :sign => sign, :letter => letter }
    end
    # tail_calc
  end

  def solve_i(input)
    i_calc = Array.new(input.length - 1)
    (0..input.length - 1).each do |i|
      letter = 1
      sign =  1

      if i_calc[i - 1]
        letter = i_calc[i - 1][:letter]
        sign = i_calc[i - 1][:sign]
      end

      i_calc[i] = { :sign => sign * multiply_sign(letter, input[i]), :letter => multiply_letter(letter, input[i]) }
    end
    i_array = i_calc.each_with_index.collect do |e, i|
      i if e[:letter] == 'i' && e[:sign] == 1
    end

    i_array.select { |e| e }
  end

  def solve_j(input, i_index)
    j_calc = Array.new(input.length - 1)

    (i_index + 1..input.length - 1).each do |i|
      letter = 1
      sign = 1
      if j_calc[i - 1]
        letter = j_calc[i - 1][:letter]
        sign = j_calc[i - 1][:sign]
      end
      j_calc[i] = { :sign => sign * multiply_sign(letter, input[i]), :letter => multiply_letter(letter, input[i]) }
    end

    j_array = j_calc.each_with_index.collect do |e, i|
      i if e && e[:letter] == 'j' && e[:sign] == 1
    end

    j_array.select { |e| e }
  end

  def solve_k(input, j_index)
    k_calc = Array.new(input.length - 1)

    (j_index + 1..input.length - 1).each do |i|
      letter = 1
      sign = 1
      if k_calc[i - 1]
        letter = k_calc[i - 1][:letter]
        sign = k_calc[i - 1][:sign]
      end
      k_calc[i] = { :sign => sign * multiply_sign(letter, input[i]), :letter => multiply_letter(letter, input[i]) }
    end

    k_array = k_calc.each_with_index.collect do |e, i|
      i if e && e[:letter] == 'k' && e[:sign] == 1
    end

    k_array.select { |e| e }
  end

  def multiply_letter(a, b)
    @letter_map[a][b]
  end

  def multiply_sign(a, b)
    @sign_map[a][b]
  end
end

# Quaternion.new('small.in')
# Quaternion.new('example2.in')
Quaternion.new('small.in')
