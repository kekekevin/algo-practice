class StandingOvation

  def initialize(file_name)
    out_file = File.open("#{file_name}.out", "w")

    File.open(file_name, "r") do |io|
      test_cases = io.readline.to_i
      (1..test_cases).each_with_index do |e, i|
        input = io.readline.split
        s_max = input[0].to_i
        audience = input[1].each_char.collect &:to_i

        out_file.print "Case ##{e}: "
        out_file.puts solve(s_max, audience)

      end
    end

    out_file.close
  end

  def solve(s_max, audience)
    (0..s_max).collect { |i| required(i, audience) }.max
  end

  def required(shyness, audience)
    shyness - (0..shyness - 1).inject(0) { |mem, var| mem + audience[var] }
  end


end

StandingOvation.new("large.in")
