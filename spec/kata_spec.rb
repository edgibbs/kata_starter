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
    end

    it "creates new directories" do
      FileUtils.should_receive(:mkdir).with("sample_kata")
      FileUtils.should_receive(:mkdir).with("sample_kata/lib")
      FileUtils.should_receive(:mkdir).with("sample_kata/spec")
      kata.build "sample_kata"
    end
  end
end
