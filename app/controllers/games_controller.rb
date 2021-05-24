require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters].split(',')
    @sorting_letters = @letters.sort.chunk_while { |a, b| a == b }.to_a
    @word = params[:word]
    @up_word = @word.upcase
    @chars_word = @up_word.chars.sort.chunk_while { |a, b| a == b }.to_a
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @content = JSON.parse(open(url).read)

    def length_test
      return @word.length <= 10
    end

    def grid_test
      @g_test = true
      @up_word.each_char { |char| @g_test = false if @letters.include?(char) == false }
      return @g_test
    end

    def word_test
      @word_test = true
      @sorting_letters.each do |letter|
        @chars_word.each { |l| @word_test = false if letter[0] == l[0] && l.length > letter.length }
      end
      return @word_test
    end

    @grid_testing = grid_test
    @length_testing = length_test
    @word_testing = word_test
  end
end
