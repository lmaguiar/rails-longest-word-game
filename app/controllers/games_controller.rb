require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)
  def home
  end

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

# Improvement = linha 19, ver primeiro se está no grid, depois ir no dicionário
  def score
    @letters = params[:letters].downcase.split('')
    @word = params[:word]
    @answer = if english_word
                if word_in_grid(@word, @letters)
                  "Well done! #{@word.capitalize} works!"
                else
                  "#{@word.capitalize} is not in the grid"
                end
              else
                "#{@word} is not an english word"
              end
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    lw_dictionary = open(url).read
    response = JSON.parse(lw_dictionary)
    response['found']
  end

  def word_in_grid(word, letters)
    new_hash = Hash.new(0)
    letters.each { |letter| new_hash[letter] += 1 }
    word.split('').each do |letter|
      new_hash[letter] -= 1
      return false if new_hash[letter].negative?
    end
    true
  end
end
