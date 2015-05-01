class Randomized
  def initialize(filename)
    File.open(filename, "r") do |file|
      num_clauses = file.readline.to_i
      variables = Array.new(num_clauses)
      clauses = Array.new(num_clauses) { Array.new(2) }

      num_clauses.times.collect do |i|
        clause_input = file.readline.split
        clauses[i][0] = clause_input[0].to_i
        clauses[i][1] = clause_input[1].to_i
      end
      puts filename
      if solve(variables, clauses)
        puts "SAT"
      else
        puts "UNSAT"
      end
    end
  end

  def solve(variables, clauses)
    Math.log2(variables.length).to_i.times do
      variables.collect! { [true, false].sample }
      puts "variables #{variables}"
      (variables.length).times do
        result = clauses.collect { |e| value(e[0], variables) && value(e[0], variables) }

        # puts "#{result}"

        sat = true
        result.each do |e|
          sat = sat && e
          if sat == false
            break
          end
        end

        if sat
          return true
        else
          # start at random place
          violations = result.each_index.select { |i| !result[i] }
          # puts "violations #{violations}"
          sample = clauses[violations.sample].sample
          variables[sample] = !variables[sample]
          # puts "sample #{sample}"
        end
      end
    end
    false
  end

  def value(index, variables)
    if index < 0
      !variables[-index]
    else
      variables[index]
    end
  end
end

Randomized.new("example-unsat.in")
Randomized.new("example-sat.in")
# Randomized.new("large-sat.in")
