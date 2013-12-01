require "thor"

class Kata < Thor
  package_name "Kata"

  desc "help", "displays help message"
  def help
    puts "Please run build to setup a project"
  end

  desc "build KATA_NAME", "builds a new base kata directory"
  def build kata_name
    build_directories kata_name
    create_ruby_version_file kata_name
    create_gemfile kata_name
    create_spec_helper_file kata_name
  end

  private

  def build_directories kata_name
    FileUtils.mkdir kata_name
    FileUtils.mkdir "#{kata_name}/lib"
    FileUtils.mkdir "#{kata_name}/spec"
  end

  def create_ruby_version_file kata_name
    ruby_version_file = File.new "#{kata_name}/.ruby-version", "w"
    ruby_version_file.puts "ruby-2.0.0-p247"
    ruby_version_file.close
  end

  def create_gemfile kata_name
    gemfile = File.new "#{kata_name}/Gemfile", "w"
    gemfile_contents = <<-CONTENT
source "http://rubygems.org"

gem "rspec"
gem "rspec-given"
gem "debugger"
    CONTENT
    gemfile.puts gemfile_contents
    gemfile.close
  end

  def create_spec_helper_file kata_name
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
