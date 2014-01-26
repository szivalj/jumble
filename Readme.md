# Jumble

To run, execute `ruby jumble.rb` from the root directory.

## Problem

Can you create a program to solve a word jumble?  (
<http://en.wikipedia.org/wiki/Jumble> More info here.)  The program should accept a string as input, and then return a list of words that can be created using the submitted letters.  For example, on the input "dog", the program should return a set of words including "god", "do", and "go".

Please implement the program in Python but refrain from using any helper modules or imports (e.g. itertools). In order to verify your words, just download an English word list ( <http://wordlist.sourceforge.net/> here are a few).

## Solution

To solve an anagram we would generate all permutations of the given string and check each permutation against a word list. This problem is similar, we have to test all permutations of every subset of characters from the input string.

* Find all subsets of characters from the input string.

* Generate candidate strings by forming all permutations of the substring. (The "anagram test")

* Test the candidates against a word list.

We'll accomplish this by:

1. Load word list into a Set (Dictionary).

2. Make Set of subsets of characters from the input string.

3. Make Set of all permutations of subsets (Candidates).

4. Get intersection of Candidates and Dictionary.

We use Sets wherever it makes sense, since they don't allow duplicates and are implemented by the almighty Hash.