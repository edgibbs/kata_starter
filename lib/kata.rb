require "thor"

class Kata < Thor
  package_name "Kata"

  desc "help", "displays help message"
  def help
    puts "Please run build to setup a project"
  end
end
