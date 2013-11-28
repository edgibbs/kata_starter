require "spec_helper"

describe Kata do
  let(:kata) { Kata.new }

  describe "#help" do
    it "displays a help message" do
      STDOUT.should_receive(:puts).with("Please run build to setup a project")
      kata.help
    end
  end

  describe "#build" do
    before do
      FileUtils.stub(:mkdir)
      File.stub(:new).and_return(StringIO.new, StringIO.new, StringIO.new)
    end

    it "creates new directories" do
      FileUtils.should_receive(:mkdir).with("sample_kata")
      FileUtils.should_receive(:mkdir).with("sample_kata/lib")
      FileUtils.should_receive(:mkdir).with("sample_kata/spec")
      kata.build "sample_kata"
    end

    context "creates a ruby version file for rvm" do
      let(:ruby_version_file) { StringIO.new }

      before do
        File.stub(:new).with(".ruby-version", "w").and_return(ruby_version_file)
      end

      it "adds a ruby version file" do
        File.should_receive(:new).with(".ruby-version", "w")
        kata.build "sample_kata"
      end

      it "writes the version to the file" do
        kata.build "sample_kata"
        ruby_version_file.string.chomp.should == "ruby-1.9.3-p392"
      end

      it "closes the file" do
        ruby_version_file.should_receive(:close)
        kata.build "sample_kata"
      end
    end

    context "creates a Gemfile" do
      let(:gemfile) { StringIO.new }

      before do
        File.stub(:new).with("Gemfile", "w").and_return(gemfile)
      end

      it "adds a Gemfile" do
        File.should_receive(:new).with("Gemfile", "w")
        kata.build "sample_kata"
      end

      it "writes the gems in the Gemfile" do
        kata.build "sample_kata"
        gemfile.string.should include 'source "http://rubygems.org"'
        gemfile.string.should include 'gem "rspec"'
        gemfile.string.should include 'gem "rspec-given"'
        gemfile.string.should include 'gem "debugger"'
      end

      it "closes the file" do
        gemfile.should_receive(:close)
        kata.build "sample_kata"
      end
    end
  end
end
