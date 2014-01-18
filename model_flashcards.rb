# Main file for 
require 'csv'

module Parser
  def parser(file)
    deck = Array.new
    # modified. It was looking for " ". Modified to ""
    raw_data = File.read(file).split("\n").delete_if{|word| word == ""}

    start = 0
    while start < raw_data.length
      definition = raw_data[start]
      answer = raw_data[start+1]
      deck.push(Card.new({definition: definition, answer: answer}))
      start += 2
    end
    deck
  end
end

class Card
  attr_reader :definition, :answer
  def initialize(data={})
    @definition = data[:definition]
    @answer = data[:answer]
  end
end

class Deck
  include Parser
  attr_reader :current_random_card, :deck
  def initialize(file)
    @file = file
    @deck =  parser(file)
    parser(file)
    @current_random_card = nil
  end

  def retrieve_random_card
   @current_random_card = @deck.sample
  end

  def correct_answer?(string) #name pending
    @current_random_card.answer.downcase == string.downcase
  end
end

class User
  attr_reader :misses_on_current, :total_correct
  def initialize
    @misses_on_current = 0
    @total_correct = 0
  end

  def update_missed_on_current
    @misses_on_current += 1
  end

  def reset_missed_on_current
    @misses_on_current = 0
  end

  def update_total_correct
    @total_correct += 1
  end
end

# deck = Deck.new('flashcard_samples.txt')
# p deck.deck
class FailedDeck < Deck
  attr_reader :deck
  def initialize
    @deck = Array.new
    @current_random_card = nil
  end

  def add_card_logic(card, count)
    if count >= 4
      @deck << [card, count]
    end
  end

  # def add_card_logic(card, missed_count)
  #   if missed_count >= 4
  #     add_card(card)
  #   end
  # end
end
