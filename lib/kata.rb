require "thor"

class Kata < Thor
  package_name "Kata"

  desc "help", "displays help message"
  def help
    puts "Please run build to setup a project"
  end

  desc "build KATA_NAME", "builds a new base kata directory"
  def build kata_name
    FileUtils.mkdir kata_name
    FileUtils.mkdir "#{kata_name}/lib"
    FileUtils.mkdir "#{kata_name}/spec"

    ruby_version_file = File.new(".ruby-version", "w")
    ruby_version_file.puts("ruby-1.9.3-p392")
    ruby_version_file.close
  end
end
