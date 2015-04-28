class Tsp
  def initialize(file_name)
    File.open(file_name, "r") do |file|
      num_points = file.readline.to_i

      points = num_points.times.collect do
        point_input = file.readline.split
        { :x => point_input[0].to_f, :y => point_input[1].to_f }
      end

      distances = Array.new(num_points) { Array.new(num_points) }

      num_points.times do |i|
        num_points.times do |j|
          distances[i][j] = Math.sqrt((points[i][:x] - points[j][:x]) ** 2 + (points[i][:y] - points[j][:y]) ** 2)
        end
      end
      puts solve(points, distances)
    end
  end

  def solve(points, distances)
    num_points = points.length
    table = Array.new(2 ** (num_points - 1)) { Array.new(num_points) { Float::INFINITY } }

    table[0][0] = 0

    1.upto(num_points - 1) do |m|
      puts "m #{m} #{Time.now}"
      s = ("1" * m).to_i(2)
      loop do

        subset = "%#{2 ** (num_points - 1)}b" % s

        0.upto(num_points - 1) do |j|
          if subset[-j - 1] == "1"
            if m == 1
              table[s][j + 1] = distances[0][j + 1]
            else
              x = String.new(subset)
              x[-j - 1] = "0"
              # puts "subset #{subset}"
              # puts "#{x}"
              table[s][j + 1] = table[x.to_i(2)].each_with_index.collect do |e, k|
                e + distances[k][j + 1]
              end.min
            end
          end
        end
        s = next_subset(s, 2 ** (num_points - 1) - 1)
        break if !s
      end
    end
    # table.each_with_index do |t, i|
      # puts "#{i} #{t}"
    # end
    final_candidates = table[-1].each_with_index.collect do |cost, j|
      cost + distances[j][0]
    end

    final_candidates.min
  end

  # Gosper Hack for finding next subset
  def next_subset(x, max)
    y = x & -x
    c = x + y
    x = (((x ^ c) >> 2) / y) | c
    if x >= max
      return nil
    else
      x
    end
  end
end

x = Tsp.new("example.in")
x = Tsp.new("example2.in")
# x = Tsp.new("example3.in")
x = Tsp.new("input.in")
