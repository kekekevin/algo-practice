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
        graph[from].out_edges << Edge.new(from, to, weight)
        graph[to].in_edges << Edge.new(from, to, weight)
      end

      puts graph

      graph.each_key do |key|
      end

      table = Array.new(num_edges) { Array.new(num_vertices) }
      table[0, ]
      1.upto(num_edges - 1) do |i|
        num_vertices.times do |v|
        end
      end
    end
  end
end

BellmanFord.new("example.in")

# store in degree to each vertex
#
