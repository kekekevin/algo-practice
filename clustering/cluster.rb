class Cluster
  def initialize(file_name, num_clusters)
    edges = initialize_edges(file_name)
    clusters = initialize_clusters(edges)
    cluster(clusters, edges, num_clusters)
  end

  def initialize_edges(file_name)
    edges = []
    File.open(file_name).readlines.each_with_index do |line, i|
      next if i == 0
      edge_input = line.split
      edges << {
        :from => edge_input[0].to_i,
        :to => edge_input[1].to_i,
        :cost => edge_input[2].to_i
      }
    end
    sort(edges)
  end

  def sort(edges)
    edges.sort_by { |e| e[:cost] }
  end

  def initialize_clusters(edges)
    clusters = {}
    edges.each do |e|
      clusters[e[:from]] = e[:from] unless clusters.key? e[:from]
      clusters[e[:to]] = e[:to] unless clusters.key? e[:to]
    end
    clusters
  end

  def cluster(clusters, edges, num_clusters)
    while cluster_count(clusters) > num_clusters
      e = edges.shift
      reassign_leaders(clusters[e[:from]], clusters[e[:to]], clusters)
    end
    find_spacing(clusters, edges)
  end

  def reassign_leaders(leader, other_leader, clusters)
    return if leader == other_leader

    clusters.each_key.find_all { |k| clusters[k] == other_leader }
      .each { |k| clusters[k] = leader }
  end

  def cluster_count(clusters)
    clusters.each_value.collect { |e| e }.uniq.length
  end

  def find_spacing(clusters, edges)
    spacing = edges.find do |e|
      clusters[e[:from]] != clusters[e[:to]]
    end
    puts spacing[:cost]
  end
end

Cluster.new("large.in", 4)
