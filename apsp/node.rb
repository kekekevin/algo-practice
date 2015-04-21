class Node
  attr_accessor :in_edges, :out_edges

  def initialize
    @in_edges = []
    @out_edges = []
  end
end
