class CardView
  attr_reader :card

  def initialize(card)
    @card = card
  end

  def display_definition
    puts definition
  end

  def definition
    <<-STRING


#{@card.definition}


Answer:
STRING
  end

  def set_card(card)
    @card = card
  end
end

class UserView
  def initialize(user)
    @user = user
  end

  def display_misses
    puts "\nYou missed #{@user.misses_on_current} times on that question."
  end

  def display_correct
    puts "\nYou got #{@user.total_correct} questions right!"
  end
end

class FailedDeckView
  def initialize failed_deck
    @deck = failed_deck
  end

  def display_failed
    puts create_list
  end

  def create_list
    str = ""
    @deck.deck.each do |card|
      str << "Questio:\n" +
            "#{card[0].definition}\n" +
            "Failed #{card[1]} times.\n\n"
      end
    str
  end
end
