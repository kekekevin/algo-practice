class Cluster
  def initialize(file_name)
    nodes = []
    File.open(file_name).readlines.each_with_index do |line, i|
      if i == 0
        @num_bits = line.split[1].to_i
      else
        nodes << (0..@num_bits - 1).inject([]) { |mem, var| mem << line.split[var].to_i }.join.to_i(2)
      end
    end
    hamming = generate_hamming_distance
    clusters = initialize_clusters(nodes)
    cluster(clusters, hamming)
  end

  def initialize_clusters(nodes)
    nodes.each_with_object({}) { |var, mem| mem[var] = var }
  end

  def generate_hamming_distance
    hamming1 = []
    (0..@num_bits - 1).each do |i|
      hamming1 << [0] * @num_bits
      hamming1[-1][i] = 1
    end
    hamming2 = []
    (0..@num_bits - 1).each do |i|
      (i + 1..@num_bits - 1).each do |j|
        hamming2 << [0] * @num_bits
        hamming2[-1][i] = 1
        hamming2[-1][j] = 1
      end
    end
    hamming1 + hamming2 + [[0] * @num_bits]
  end

  def hamming_distance(int_array, int_array2)
    int_array.zip(int_array2).collect { |bytes| bytes[0] ^ bytes[1] }
  end

  def cluster(clusters, hamming)
    clusters.each do |k, _v|
      hamming.each do |h|
        node = k.to_s(2).rjust(@num_bits, "0").split("").collect(&:to_i)
        matching_node = hamming_distance(node, h).join.to_i(2)
        if clusters.key? matching_node
          leader = clusters[k]
          other_leader = clusters[matching_node]
          reassign_leaders(leader, other_leader, clusters)
        end
      end
    end
    puts clusters.each_value.collect { |e| e }.uniq.length
  end

  def reassign_leaders(leader, other_leader, clusters)
    return if leader == other_leader

    clusters.each_key.find_all { |k| clusters[k] == other_leader }
      .each { |k| clusters[k] = leader }
  end

end

Cluster.new("medium.in")
