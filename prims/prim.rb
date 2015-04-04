class Prim

  def initialize(file_name)
    file = File.open(file_name, "r") do | io |
      header = io.readline.split

      @num_nodes = header[0].to_i
      @num_edges = header[1].to_i

      @edges = (1..@num_edges).collect do
        edge_input = io.readline.split
        { :from => edge_input[0].to_i, :to => edge_input[1].to_i, :cost => edge_input[2].to_i }
      end
      @visited = []
    end
  end

  def find_mst
    sum = 0
    @visited << @edges[0][:from]

    (2..@num_nodes).each do
      min_edge = self.find_minimum_edge @visited

      @visited << min_edge[:from] unless @visited.include? min_edge[:from]
      @visited << min_edge[:to] unless @visited.include? min_edge[:to]

      sum += min_edge[:cost]
    end

    sum
  end

  def find_minimum_edge(nodes)
    @edges.select { |e| nodes.include?(e[:from]) ^ nodes.include?(e[:to]) }.inject do | memo, e |
      memo[:cost] > e[:cost] ? e : memo
    end
  end

end

prim = Prim.new("large_prim.in")
puts prim.find_mst
