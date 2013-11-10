require "spec_helper"

describe Kata do
  describe "#build" do
    let(:output) { StringIO.new }
    let(:kata) { Kata.new(output) }

    context "help" do
      it "displays a help message" do
        kata.help
        output.string.chomp.should == "Please run build to setup a project"
      end
    end
  end
end
