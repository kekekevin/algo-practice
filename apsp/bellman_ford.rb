class Edge
  attr_accessor :from, :to, :weight

  def initialize(from, to, weight)
    @from = from
    @to = to
    @weight = weight
  end
end

class Node
  attr_accessor :in_edges, :out_edges

  def initialize
    @in_edges = []
    @out_edges = []
  end
end

class BellmanFord
  def initialize(file_name)
    File.open(file_name, "r") do |io|
      graph_input = io.readline.split

      num_vertices = graph_input[0].to_i
      num_edges = graph_input[1].to_i

      graph = Hash.new

      num_edges.times do |e|
        edge_input = io.readline.split

        from = edge_input[0].to_i
        to = edge_input[1].to_i
        weight = edge_input[2].to_i

        graph[from] = Node.new unless graph.key? from
        graph[to] = Node.new unless graph.key? to
        edge = Edge.new(from, to, weight)
        graph[from].out_edges << edge
        graph[to].in_edges << edge
      end

      # puts graph
      result = graph.each_key.select { |key| graph[key].out_edges.any? { |e| e.weight < 0} }
        .collect { |key| solve(key, num_edges, num_vertices, graph) }.min
      if result
        puts result
      else
        puts "NULL"
      end
    end
  end

  def solve(source, num_edges, num_vertices, graph)
    table = Array.new(2) { Array.new(num_vertices) }

    0.upto(num_vertices - 1) { |i| table[0][i] = Float::INFINITY }
    table[0][source - 1] = 0

    solution = num_edges - 1

    1.upto(num_edges) do |i|
      num_vertices.times do |v|
        candidates = graph[v + 1].in_edges.collect do |e|
          # puts "#{v} #{e.from - 1}"
          # puts "#{table}"
          # puts e.weight

          # puts table[i - 1][e.from - 1] + e.weight
          table[(i - 1) % 2][e.from - 1] + e.weight
        end
        candidates << table[(i - 1) % 2][v]
        table[i % 2][v] = candidates.min
      end
      if table[i % 2] == table[(i - 1) % 2]
        puts "exiting early"
        solution = i
        break
      end
      if table[i % 2].all? { |j| j > 0 }
        puts "not shortest shortest"
        solution = i
        break
      end
    end
    # puts "#{table}"
    return nil if table[0] != table[1]
    table[solution % 2].min
  end
end

BellmanFord.new("example.in")
BellmanFord.new("example2.in")
BellmanFord.new("example3.in")
# BellmanFord.new("g1.in")

# store in degree to each vertex
#
