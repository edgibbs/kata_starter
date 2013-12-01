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

    ruby_version_file = File.new "#{kata_name}/.ruby-version", "w"
    ruby_version_file.puts "ruby-1.9.3-p392"
    ruby_version_file.close


    gemfile = File.new "#{kata_name}/Gemfile", "w"
    gemfile_contents = <<-CONTENT
source "http://rubygems.org"

gem "rspec"
gem "rspec-given"
gem "debugger"
    CONTENT

    gemfile.puts gemfile_contents
    gemfile.close

    spec_helper_file = File.new "#{kata_name}/spec/spec_helper.rb", "w"
    spec_helper_contents = <<-CONTENT
require "rspec-given"

Dir[File.join(".", "lib", "**/*.rb")].each do |file|
  require file
end
    CONTENT

    spec_helper_file.puts spec_helper_contents
    spec_helper_file.close
  end
end
