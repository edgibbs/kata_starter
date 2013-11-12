require "thor"

class Kata < Thor
  package_name "Kata"

  desc "help", "displays help message"
  def help
    puts "Please run build to setup a project"
  end

  desc "build", "builds a new base kata directory"
  def build kata_name
    FileUtils.mkdir kata_name
  end
end
