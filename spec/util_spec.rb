require 'set'
require 'util'

describe Util do
  it "can find subsets" do
    # Known subsets of "asd".
    p = Set.new ["asd", "a", "s", "sa", "d", "da", "ds"]

    expect(Util.subsetsOf("asd") == p).to be true
  end

  it "can find permutations" do
    # Known permutations of "asd".
    p = Set.new ["asd", "sad", "sda", "ads", "das","dsa"]

    expect(Util.permutationsOf("asd") == p).to be true
  end
end