require "thor"

class Kata < Thor
  package_name "Kata"

  def initialize(output = STDOUT)
    @output = output
  end

  desc "help", "displays help message"
  def help
    @output.puts "Please run build to setup a project"
  end
end
