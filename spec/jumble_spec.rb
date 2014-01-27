require 'set'
require 'jumble'

describe Jumble do
  it "should solve the word jumble" do
    @jumble = Jumble.new
    @jumble.stub(:gets).exactly(2).times.and_return("dog", "n")
    @jumble.should_receive(:displayResults).with(Set.new ["do", "dog", "go", "god"])
    @jumble.start
  end
end