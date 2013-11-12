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
    it "creates a new directory" do
      FileUtils.should_receive(:mkdir).with("sample_kata")
      kata.build "sample_kata"
    end
  end
end
