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
      s = (1 << m) -1
      loop do
        0.upto(num_points - 1) do |j|
          if ((s >> j) & 1) == 1
            if m == 1
              table[s][j + 1] = distances[0][j + 1]
            else
              min = table[s - (1 << j)][0] + distances[0][j + 1]
              1.upto (num_points - 1) do |k|
                if min > table[s - (1 << j)][k] + distances[k][j + 1]
                  min = table[s - (1 << j)][k] + distances[k][j + 1]
                end
              end
              table[s][j + 1] = min
            end
          end
        end
        s = next_subset(s, (1 << num_points - 1) - 1)
        break if !s
      end
    end
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
      nil
    else
      x
    end
  end
end

x = Tsp.new("example.in")
x = Tsp.new("example2.in")
# x = Tsp.new("example3.in")
x = Tsp.new("input.in")
