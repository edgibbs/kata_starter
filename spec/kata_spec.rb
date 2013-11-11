require "spec_helper"

describe Kata do
  let(:kata) { Kata.new }

  describe "@help" do
    it "displays a help message" do
      STDOUT.should_receive(:puts).with("Please run build to setup a project")
      kata.help
    end
  end
end
