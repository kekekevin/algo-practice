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

      puts solve(items, knapsack_size, 0)
      puts @cache

      File.open(file_name.sub(/in/, "out"), "w") do |io|
        io.puts file_name

      end
    end
  end

  def solve(items, weight, value)
    puts "#{items} #{weight} #{value}"
    if items.empty?
      return value
    end
    if items[0][:weight] > weight
      return value
    end
    return @cache[items.length - 1][weight] if @cache[items.length - 1].key? weight

    max = [
      solve(items[1..-1], weight, value),
      solve(items[1..-1], weight - items[0][:weight], items[0][:value] + value)
    ].max
    @cache[items.length - 1][weight] = max

    max
  end

end

KnapsackRecursive.new("example.in")
# KnapsackRecursive.new("example2.in")
# KnapsackRecursive.new("small.in")


