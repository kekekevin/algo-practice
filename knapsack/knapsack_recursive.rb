class KnapsackRecursive
  def initialize(file_name)
    File.open(file_name, "r") do |io|
      knapsack_input = io.readline.split

      knapsack_size = knapsack_input[0].to_i
      num_items = knapsack_input[1].to_i

      @cache = Array.new(num_items) { Hash.new }

      items = 1.upto(num_items).collect do
        item_input = io.readline.split
        { :value => item_input[0].to_i, :weight => item_input[1].to_i }
      end
      items = items.sort_by { |e| e[:weight] }.reverse

      File.open(file_name.sub(/in/, "out"), "w") do |out_file|
        out_file.puts file_name
        out_file.puts solve(items, knapsack_size, 0)
      end
    end
  end

  def solve(items, weight, value)
    return value if items.empty?
    return @cache[items.length - 1][weight] + value if @cache[items.length - 1][weight]

    candidates = [solve(items[1..-1], weight, value)]
    if items[0][:weight] <= weight
      candidates << solve(items[1..-1], weight - items[0][:weight], items[0][:value] + value)
    end
    max = candidates.max

    @cache[items.length - 1][weight] = max - value

    max
  end

end

# KnapsackRecursive.new("example.in")
# KnapsackRecursive.new("example2.in")
KnapsackRecursive.new("small.in")
KnapsackRecursive.new("large.in")
