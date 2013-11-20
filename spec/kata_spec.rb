require "spec_helper"

describe Kata do
  let(:kata) { Kata.new }
  let(:file) { StringIO.new }

  describe "#help" do
    it "displays a help message" do
      STDOUT.should_receive(:puts).with("Please run build to setup a project")
      kata.help
    end
  end

  describe "#build" do
    before do
      FileUtils.stub(:mkdir)
      File.stub(:new).and_return(file)
    end

    it "creates new directories" do
      FileUtils.should_receive(:mkdir).with("sample_kata")
      FileUtils.should_receive(:mkdir).with("sample_kata/lib")
      FileUtils.should_receive(:mkdir).with("sample_kata/spec")
      kata.build "sample_kata"
    end

    context "creates a ruby version file for rvm" do
      it "adds a ruby version file" do
        File.should_receive(:new).with(".ruby-version", "w")
        kata.build "sample_kata"
      end

      it "writes the version to the file" do
        kata.build "sample_kata"
        file.string.chomp.should == "ruby-1.9.3-p392"
      end

      it "closes the file" do
        file.should_receive(:close)
        kata.build "sample_kata"
      end
    end
  end
end
