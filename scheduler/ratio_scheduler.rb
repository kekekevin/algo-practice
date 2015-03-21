class RatioScheduler

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
    job[:weight].to_f / job[:length]
  end

  def schedule
    @jobs.sort { |x, y| score(y) <=> score(x) }
  end

  def completion_time
    completion_time = 0
    self.schedule.inject(0) do |sum, job|
      completion_time += job[:length]
      sum + job[:weight] * completion_time
    end
  end

end

scheduler = RatioScheduler.new("large_schedule.in")

puts scheduler.completion_time
