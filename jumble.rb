#!/usr/bin/env ruby
require 'set'

class Jumble
  def initialize(verbose = false)
    @verbose = verbose
    @dictionary = Set.new
    @subsets = Set.new
    @candidates = Set.new

    loadDictionary
    gameLoop
  end

  def loadDictionary
    File.open("lib/scowl-7.1/final/english-words.10", "r") do |f|
      f.each_line do |line|
        @dictionary.add line.chomp # chomp to remove newlines
      end
    end
  end

  def gameLoop
    print "Enter jumbled letters: "
    @jumble = gets
    # Strip non word characters and digits
    @jumble.gsub!(/\W*\d*/, "")

    @subsets.clear
    @candidates.clear
    createSubsets
    permuteSubsets
    checkDictionary
  end

  def createSubsets
    # There are 2^n subsets of str where n is str.length
    n = @jumble.length
    # We are counting in binary and including zero as the first
    #   subset, so subtract 1. We can also omit the subset which
    #   equals the initial set (e.g. `111`, subset #7 when the input
    #   is of length 3), so subtract another 1.
    num_subsets = 2**n - 2
    @subsets.add(@jumble) # sice we skipped the subset that equals initial set
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
          subset.prepend @jumble[j] # include that character in this subset
        end
      end

      @subsets.add(subset) # add to the Set of subsets

      if @verbose
        puts "subset " + "%0#{n}d" % subset_int.to_s(2) + " contains: " + subset
      end
    end

  end

  def permuteSubsets
    @subsets.each do |subset|
      @candidates.merge permute(subset)
    end
  end

  def permute(str="")
    new_perms = Set.new
    # puts "permuting: " + str
    n = str.length
    if n == 1
      return new_perms.add(str)
    end
    # For each character str[j] in str
    0.upto(n-1) do |j|
      # Get all permutations of strings NOT containing current character str[j]
      s = str[0...j] + str[j+1...n]
      perms = permute(s)
      # For each of those permutations NOT containg str[j]
      perms.each do | perm |
        # Build new permutations using current character str[j]
        0.upto(perm.length) do |k|
          new_perm = perm[0...k] + str[j] + perm[k...perm.length]
          new_perms.add new_perm
        end
      end
    end
    new_perms
  end

  def checkDictionary
    matches = @candidates & @dictionary
    if !matches.empty?
      print "Words: "
      matches.each do |match|
        print "#{match}  "
      end
      puts "\n"
    else
      puts "No words found."
    end
    gameLoop
  end

end

Jumble.new(false)