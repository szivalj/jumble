#!/usr/bin/env ruby
require 'set'
require_relative 'lib/util'

class Jumble
  def initialize
    @@dictionary = Set.new
    @candidates = Set.new

    loadDictionary
    gameLoop
  end

  def loadDictionary
    if @@dictionary.empty?
      word_lists = [
        "american-words.10",
        "american-words.20",
        "english-words.10",
        "english-words.20"
      ]
      word_lists.each do | word_list |
        File.open("lib/scowl-7.1/final/#{word_list}", "r") do |f|
          f.each_line do |line|
            @@dictionary.add line.chomp # chomp to remove newlines
          end
        end
      end
    end
    puts "Dictionary contains #{@@dictionary.size} words."
  end

  def gameLoop
    print "Enter jumbled letters: "
    @user_input = gets
    # Strip non word characters and digits
    @user_input.gsub!(/\W*\d*/, "")
    generateCandidates
    checkDictionary
  end

  def generateCandidates
    @candidates.clear
    Util.subsetsOf(@user_input).each do |subset|
      @candidates.merge Util.permutationsOf(subset)
    end
  end

  def checkDictionary
    matches = @candidates & @@dictionary
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

Jumble.new