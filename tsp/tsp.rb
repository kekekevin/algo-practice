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

    table.length.times do |i|
      if i == 0
        table[i][0] = 0
      else
        table[i][0] = Float::INFINITY
      end
    end

    1.upto(num_points) do |m|
      1.upto(2 ** (num_points - 1) - 1) do |s|
        subset = "%#{2 ** (num_points - 1)}b" % s
        if subset.count("1") == m
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
        end
      end
    end
    # table.each_with_index do |t, i|
      # puts "#{i} #{t}"
    # end
    table[-1].each_with_index.collect do |cost, j|
      cost + distances[j][0]
    end.min
  end
end

Tsp.new("example.in")
Tsp.new("example2.in")
