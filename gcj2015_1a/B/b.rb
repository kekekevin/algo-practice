class B
  def initialize(file_name)
    out_file = File.open(file_name.sub(/in/, "out"), "w")

    File.open(file_name, "r") do |io|
      test_cases = io.readline.to_i
      1.upto(test_cases).each do |t|
        input = io.readline.split
        b = input[0].to_i
        n = input[1].to_i

        m_input = io.readline.split
        m = []
        b.times do |i|
          m << m_input[i].to_i
        end
        m_min = m.min
        m_max = m.max
        rem = n
        1.upto(m_min * n) do |i|
          m.each do |j|
            if i % j == 0
              if m.count(j) < rem
                rem = rem - m.count(j)
              end
            end
          end
        end
        puts rem

        out_file.print "Case ##{t}: "
        out_file.puts "#{rem}"
      end
    end

    out_file.close
  end
end

B.new("example.in")
B.new("small.in")
