class Contributor
  attr_reader :commits, :login

  def initialize(data)
    @commits = data[:contributions]
    @login = data[:login]
  end
end