require 'set'
class Util
  @@permutations = Hash.new
  # Takes a string, returns a Set of subsets.
  def self.subsetsOf(str="")
    subsets = Set.new
    # There are 2^n subsets of str where n is str.length
    n = str.length
    # We are counting in binary and including zero as the first
    #   subset, so subtract 1. We can also omit the subset which
    #   equals the whole set (e.g. `111`, subset #7 when the input
    #   is of length 3), so subtract another 1.
    num_subsets = 2**n - 2
    subsets.add(str) # sice we skip the subset that equals whole set
    # subset_int is an integer whose binary representation maps to
    #   inclusion/exclusion of those characters from the set
    #   e.g. subset #5 is `101`, it includes "a" and "c"
    #   but omits "b" from "abc".
    # Also we end up omitting the 0th subset, as it is always the empty set.
    #   So 1.upto instead of 0.upto
    1.upto(num_subsets) do |subset_int|
      subset = ""
      for j in 0...n # loop through each each bit
        unless subset_int[j].zero? # if the bit is 1
          subset.prepend str[j] # include that character in this subset
        end
      end

      subsets.add(subset) # add to the Set of subsets
    end
    subsets
  end

  # Takes a string, returns a Set of permutations.
  def self.permutationsOf(str="")
    # If we already computed permutations for this string
    if @@permutations.has_key?(str)
      return @@permutations[str]
    end
    # Permutation when str.length 1
    n = str.length
    if n == 1
      @@permutations[str] = Set.new [str]
      return @@permutations[str]
    end

    new_perms = Set.new
    # For each character str[j] in str
    0.upto(n-1) do |j|
      # Get all permutations of the string NOT containing current character str[j]
      s = str[0...j] + str[j+1...n]
      perms = self.permutationsOf(s)
      # For each of those permutations
      perms.each do | perm |
        # Build new permutations using current character str[j]
        0.upto(perm.length) do |k|
          new_perm = perm[0...k] + str[j] + perm[k...perm.length]
          new_perms.add new_perm
        end
      end
    end
    @@permutations[str] = new_perms
    @@permutations[str]
  end
end