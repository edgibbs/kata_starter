require "spec_helper"

describe Kata do
  let(:kata) { Kata.new }
  let(:kata_name) { "sample_kata" }

  describe "#help" do
    it "displays a help message" do
      STDOUT.should_receive(:puts).with("Please run build to setup a project")
      kata.help
    end
  end

  describe "#build" do
    before do
      FileUtils.stub :mkdir
      File.stub(:new).and_return(StringIO.new, StringIO.new, StringIO.new)
    end

    it "creates new directories" do
      FileUtils.should_receive(:mkdir).with("#{kata_name}")
      FileUtils.should_receive(:mkdir).with("#{kata_name}/lib")
      FileUtils.should_receive(:mkdir).with("#{kata_name}/spec")
      kata.build kata_name
    end

    context "creates a ruby version file for rvm" do
      let(:ruby_version_file) { StringIO.new }

      before do
        File.stub(:new).with("#{kata_name}/.ruby-version", "w").and_return(ruby_version_file)
      end

      it "adds a ruby version file" do
        File.should_receive(:new).with("#{kata_name}/.ruby-version", "w")
        kata.build kata_name
      end

      it "writes the version to the file" do
        kata.build kata_name
        ruby_version_file.string.chomp.should == "ruby-2.2.0"
      end

      it "closes the file" do
        ruby_version_file.should_receive :close
        kata.build kata_name
      end
    end

    context "creates a Gemfile" do
      let(:gemfile) { StringIO.new }

      before do
        File.stub(:new).with("#{kata_name}/Gemfile", "w").and_return(gemfile)
      end

      it "adds a Gemfile" do
        File.should_receive(:new).with("#{kata_name}/Gemfile", "w")
        kata.build kata_name
      end

      it "writes the gems in the Gemfile" do
        kata.build kata_name
        gemfile.string.should include 'source "http://rubygems.org"'
        gemfile.string.should include 'gem "rspec"'
        gemfile.string.should include 'gem "yertle_formatter"'
      end

      it "closes the file" do
        gemfile.should_receive :close
        kata.build kata_name
      end
    end

    context "creates a spec helper" do
      let(:spec_helper_file) { StringIO.new }

      before do
        File.stub(:new).with("#{kata_name}/spec/spec_helper.rb", "w").and_return(spec_helper_file)
      end

      it "adds a spec helper" do
        File.should_receive(:new).with("#{kata_name}/spec/spec_helper.rb", "w")
        kata.build kata_name
      end

      it "writes the content to the spec helper" do
        kata.build kata_name
        spec_helper_file.string.should include 'Dir[File.join(".", "lib", "**/*.rb")].each do |file|'
        spec_helper_file.string.should include 'require file'
        spec_helper_file.string.should include 'end'
      end

      it "closes the file" do
        spec_helper_file.should_receive :close
        kata.build kata_name
      end
    end
  end
end
