class DiffScheduler

  def initialize(file)
    file = File.open(file, "r") do |io|
      num_inputs = io.readline.to_i
      @jobs = (1..num_inputs).collect do
        input = io.readline.split
        { :weight => input[0].to_i, :length => input[1].to_i }
      end
    end
  end

  def score(job)
    job[:weight] - job[:length]
  end

  def schedule
    @jobs.sort do |x, y|
      if score(y) == score(x)
        y[:weight] <=> x[:weight]
      else
        score(y) <=> score(x)
      end
    end
  end

  def completion_time
    completion_time = 0
    self.schedule.inject(0) do |sum, job|
      completion_time += job[:length]
      sum + job[:weight] * completion_time
    end
  end

end

scheduler = DiffScheduler.new("large_schedule.in")

puts scheduler.completion_time
