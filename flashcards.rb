# Main file for 
require 'csv'

class Card
  attr_reader :definition, :answer
  def initialize(data={})
    @definition = data[:definition]
    @answer = data[:answer]
  end

  def definition_only
<<-STRING
#{@definition}


Answer:
STRING
  end

  def definition_and_answer
<<-STRING
#{@definition}


Answer: #{@answer}
STRING
  end
end

class Deck
  attr_reader :current_random_card
  def initialize(file)
    @file = file
    @deck =  Array.new
    parser(file)
    @current_random_card = nil
  end

  def retrieve_random_card
    @current_random_card = @deck.sample
  end

  def parser(file)
    dictionary = Array.new
    raw_data = File.read(file).split("\n").delete_if{|word| word == " "}

    start = 0
    while start < raw_data.length
      definition = raw_data[start]
      answer = raw_data[start+1]
      @deck.push(Card.new({definition: definition, answer: answer}))
      start += 2
    end
  end

  def correct_answer?(string) #name pending
    @current_random_card.answer == string
  end
end
