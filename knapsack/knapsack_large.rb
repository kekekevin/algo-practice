class KnapsackLarge
  def initialize(file_name)
    File.open(file_name, "r") do |io|
      knapsack_input = io.readline.split

      knapsack_size = knapsack_input[0].to_i
      num_items = knapsack_input[1].to_i

      items = 1.upto(num_items).collect do
        item_input = io.readline.split
        { :value => item_input[0].to_i, :weight => item_input[1].to_i }
      end

      items_array = Array.new(2) { Array.new(knapsack_size + 1) }


      0.upto(num_items) do |n|
        0.upto(knapsack_size) do |w|
          if n == 0
            items_array[n][w] = 0
            items_array[n + 1][w] = 0
          else
            value = items[n - 1][:value]
            weight = items[n - 1][:weight]
            if w - weight < 0
              items_array[(n + 1) % 2][w] = [items_array[n % 2][w], 0].max
            else
              items_array[(n + 1) % 2][w] = [items_array[n % 2][w], items_array[n % 2][w - weight] + value].max
            end
          end
        end
        # puts "#{items_array}"
      end

      File.open(file_name.sub(/in/, "out"), "w") do |io|
        io.puts file_name
        io.puts items_array[1][knapsack_size]
      end
    end
  end
end

# KnapsackLarge.new("example2.in")
# KnapsackLarge.new("small.in")
KnapsackLarge.new("large.in")


