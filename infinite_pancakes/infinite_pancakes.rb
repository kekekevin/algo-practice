
class InfinitePancakes
  def initialize(file_name)
    out_file = File.open("#{file_name}.out", "w")

    File.open(file_name, "r") do |io|
      test_cases = io.readline.to_i
      (1..test_cases).each_with_index do |e, i|
        num_diners = io.readline.to_i
        diners = io.readline.split.collect &:to_i

        out_file.print "Case ##{e}: "
        out_file.puts solve(diners, 0)
      end
    end

    out_file.close
  end

  def solve(diners, minutes)
    if diners.empty?
      return minutes
    elsif diners.max == 1
      return minutes + 1
    else
      [solve(eat(diners), minutes + 1), solve(special(diners), minutes + 1)].min
    end
  end

  def eat(diners)
    diners.collect { |e| e - 1 }.select { |e| e > 0 }
  end

  def special(diners)
    temp = diners.sort
    max = temp[-1]
    if max.even?
      temp[0..-2] << (max / 2) << (max / 2)
    else
      if max % 3 == 0
        temp[0..-2] << max / 3 << max - max / 3
      else
        temp[0..-2] << (max / 2) << (max / 2) + 1
      end
    end
  end
end

# InfinitePancakes.new("example.in")
InfinitePancakes.new("small.in")
InfinitePancakes.new("small2.in")
