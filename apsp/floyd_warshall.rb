class FloydWarshall
  def initialize(file_name)
    File.open(file_name, "r") do |io|
      graph_input = io.readline.split

      num_vertices = graph_input[0].to_i
      num_edges = graph_input[1].to_i

      graph = Array.new(num_vertices + 1) {
        Array.new(num_vertices + 1) {
          Float::INFINITY
        }
      }

      num_edges.times do
        edge_input = io.readline.split

        from = edge_input[0].to_i
        to = edge_input[1].to_i
        weight = edge_input[2].to_i

        graph[from][to] = weight
      end

      result = solve(num_vertices, graph)

      if result
        puts result
      else
        puts "NULL"
      end
    end
  end

  def solve(num_vertices, graph)
    table = Array.new(num_vertices + 1) {
      Array.new(num_vertices + 1) {
        Array.new(2)
      }
    }

    1.upto num_vertices do |i|
      1.upto num_vertices do |j|
        if i == j
          table[i][j][0] = 0
        else
          table[i][j][0] = graph[i][j]
        end
      end
    end

    1.upto num_vertices do |k|
      1.upto num_vertices do |i|
        1.upto num_vertices do |j|
          table[i][j][k % 2] = [
            table[i][j][(k - 1) % 2],
            table[i][k][(k - 1) % 2] + table[k][j][(k - 1) % 2]
          ].min
        end
        return nil if table[i][i][k % 2] < 0
      end
    end

    answers = []
    1.upto num_vertices do |i|
      1.upto num_vertices do |j|
        answers << table[i][j][num_vertices % 2]
      end
    end
    answers.min
  end
end

FloydWarshall.new("example.in")
FloydWarshall.new("example2.in")
FloydWarshall.new("example3.in")
# puts Time.now
# FloydWarshall.new("g1.in")
# puts Time.now
# FloydWarshall.new("g2.in")
# puts Time.now
# FloydWarshall.new("g3.in")
# puts Time.now

