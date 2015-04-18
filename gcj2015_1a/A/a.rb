class A
  def initialize(file_name)
    out_file = File.open(file_name.sub(/in/, "out"), "w")

    File.open(file_name, "r") do |io|
      test_cases = io.readline.to_i
      (1..test_cases).each_with_index do |e, t|
        n = io.readline.to_i
        m_input = io.readline.split

        down = []
        up = []
        # puts "n #{n}"
        0.upto(n - 2) do |i|
          # puts i
          x = m_input[i].to_i
          y = m_input[i + 1].to_i
          if x - y > 0
            down << (x - y).abs
          else
            up << (x - y).abs
          end
        end
        # puts up
        # puts "up #{up}"
        # puts down
        # puts "down #{down}"
        m1 = down.inject(0) { |mem, var| mem + var }

        m2_rate = down.max || 0
        m2 = 0

        0.upto(n - 2) do |i|
          # puts i
          x = m_input[i].to_i
          if m2_rate >= x
            m2 += x
          else
            m2 += m2_rate
          end
        end


        # puts "answers"
        puts m1
        puts m2

        out_file.print "Case ##{e}: "
        out_file.puts "#{m1} #{m2}"
      end
    end

    out_file.close
  end
end

# A.new("example.in")
# A.new("small.in")
A.new("large.in")
