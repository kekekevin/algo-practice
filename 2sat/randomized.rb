require "set"

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
    1000.times { prune(clauses) }
    # clauses.length.times { prune(clauses) }
    # puts clauses.length
    num_variables = clauses.collect { |e| [e[0].abs, e[1].abs] }.flatten.uniq.length
    # puts num_variables

    (Math.log2(num_variables + 1)).to_i.times do
      @variables.collect! { [true, false].sample }
      puts "#{Time.now}"
      (2 * num_variables ** 2 + 1).times do
        violation = find_random_violation clauses

        if !violation
          return true
        else
          sample = clauses[violation].sample.abs
          @variables[sample] = !@variables[sample]
        end
      end
    end
    false
  end

  def find_random_violation(clauses)
    return nil if clauses.empty?
    prng = Random.new
    start = prng.rand(0..clauses.length - 1)
    (start..clauses.length - 1).each do |i|
      if !(value(clauses[i][0]) || value(clauses[i][1]))
        return i
      end
    end
    (0..start).each do |i|
      if !(value(clauses[i][0]) || value(clauses[i][1]))
        return i
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
    occurences = Hash.new

    clauses.each do |e|
      if occurences.has_key? e[0]
        occurences[e[0]] += 1
      else
        occurences[e[0]] = 1
      end
      if occurences.has_key? e[1]
        occurences[e[1]] += 1
      else
        occurences[e[1]] = 1
      end
    end

    single_variables = occurences.each_key.select { |k| occurences[k] + (occurences[-k] || 0) == 1 }
    non_negated = occurences.each_key.select { |k| occurences[k] && occurences[-k] == nil }
    # puts "non_negated #{non_negated}"

    clauses.reject! do |e|
      single_variables.include?(e[0].abs) ||
        single_variables.include?(e[1].abs) ||
        non_negated.include?(e[0]) || non_negated.include?(e[1])
    end

    # puts "extraneous variables #{single_variables.length}"
    # puts "non_negated #{non_negated.length}"
    # puts "variables #{single_variables}"
    # puts "non_negated #{non_negated}"
  end
end

Randomized.new("example-unsat.in")
Randomized.new("example-sat.in")
Randomized.new("example2-sat.in")
Randomized.new("example3-sat.in")
Randomized.new("input1.in")
Randomized.new("input2.in")
Randomized.new("input3.in")
Randomized.new("input4.in")
Randomized.new("input5.in")
Randomized.new("input6.in")
