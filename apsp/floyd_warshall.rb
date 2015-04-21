require_relative "node"
require_relative "edge"

class FloydWarshall
  def initialize(file_name)
    File.open(file_name, "r") do |io|
      graph_input = io.readline.split

      num_vertices = graph_input[0].to_i
      num_edges = graph_input[1].to_i

      graph = Hash.new

      num_edges.times do |e|
        edge_input = io.readline.split

        from = edge_input[0].to_i - 1
        to = edge_input[1].to_i - 1
        weight = edge_input[2].to_i

        graph[from] = Node.new unless graph.key? from
        graph[to] = Node.new unless graph.key? to
        edge = Edge.new(from, to, weight)
        graph[from].out_edges << edge
        graph[to].in_edges << edge
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
    table = Array.new(num_vertices) { Array.new(num_vertices) { Array.new(num_vertices + 1) } }

    num_vertices.times do |i|
      num_vertices.times do |j|
        edge = graph[i].out_edges.find { |e| e.to == j + 1 }
        if i == j
          table[i][j][0] = 0
        elsif edge
          table[i][j][0] = edge.weight
        else
          table[i][j][0] = Float::INFINITY
        end
      end
    end
    num_vertices.times do |i|
    end
    puts "#{table}"
  end
end
FloydWarshall.new("example.in")
