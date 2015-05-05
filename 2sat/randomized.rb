class Randomized
  def initialize(filename)
    File.open(filename, "r") do |file|
      num_clauses = file.readline.to_i
      @variables = Array.new(num_clauses)
      clauses = Array.new(num_clauses) { Array.new(2) }

      num_clauses.times.collect do |i|
        clause_input = file.readline.split
        clauses[i][0] = clause_input[0].to_i
        clauses[i][1] = clause_input[1].to_i
      end
      puts filename
      if solve(clauses)
        puts "SAT"
      else
        puts "UNSAT"
      end
    end
  end

  def solve(clauses)
    5.times { prune(clauses) }
    puts clauses.length

    Math.log2(@variables.length).to_i.times do
      @variables.collect! { [true, false].sample }
      puts "#{Time.now}"
      (2 * @variables.length ** 2).times do
        violation = find_random_violation clauses

        if !violation
          return true
        else
          sample = clauses[violation].sample
          @variables[sample] = !@variables[sample]
        end
      end
    end
    false
  end

  def find_random_violation(clauses)
    prng = Random.new
    start = prng.rand(0..clauses.length - 1)
    (start..clauses.length - 1).each do |i|
      if !(value(clauses[i][0]) || value(clauses[i][1]))
        return 1
      end
    end
    (0..start).each do |i|
      if !(value(clauses[i][0]) || value(clauses[i][1]))
        return 1
      end
    end
    nil
  end

  def value(index)
    if index < 0
      !@variables[-index]
    else
      @variables[index]
    end
  end

  def prune(clauses)
    occurences = Array.new(@variables.length + 1) { 0 }

    clauses.each do |e|
      if e[0] < 0
        occurences[-e[0]] += 1
      else
        occurences[e[0]] += 1
      end
      if e[1] < 0
        occurences[-e[1]] += 1
      else
        occurences[e[1]] += 1
      end
    end

    variables = occurences.each_index.select { |i| occurences[i] == 1 }

    clauses.reject! do |e|
      variables.include?(e[0]) || variables.include?(-e[0]) ||
        variables.include?(e[1]) || variables.include?(-e[1])
    end

    puts "extraneous variables #{variables.length}"
    # puts "variables #{variables}"
    # puts "clauses #{clauses}"
  end
end

Randomized.new("example-unsat.in")
Randomized.new("example-sat.in")
# Randomized.new("input2.in")
# Randomized.new("input1.in")
