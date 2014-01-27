require 'set'
require_relative './util'

class Jumble
  def initialize
    @@dictionary = Set.new
    loadDictionary
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

  def start
    gameLoop
  end

  def gameLoop
    print "Enter jumbled letters: "
    getInput
    candidates = getCandidates
    valid_words = screenCandidates candidates# winners are valid words
    displayResults valid_words
  end

  def getInput
    @user_input = gets
    @user_input.gsub!(/\W*\d*/, "")
  end

  def getCandidates
    candidates = Set.new
    Util.subsetsOf(@user_input).each do |subset|
      candidates.merge Util.permutationsOf(subset)
    end
    candidates
  end

  def screenCandidates(candidates)
    candidates & @@dictionary
  end

  def displayResults(valid_words)
    if !valid_words.empty?
      print "Words: "
      valid_words.each do |word|
        print "#{word}  "
      end
      puts "\n"
    else
      puts "No words found."
    end

    print "Play again?(y/n): "
    getInput
    if @user_input == "y" || @user_input.empty?
      gameLoop
    end
  end

end