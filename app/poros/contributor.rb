class Contributor

  attr_reader :commits

  def initialize(data)
    @commits = data[:contributions]
  end
end