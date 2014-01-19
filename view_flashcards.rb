class CardView
  def display_definition(card)
    puts definition(card)
  end

  def definition(card)
<<-STRING


#{card.definition}


Answer:
STRING
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
  def display_failed(failed_deck)
    puts create_list(failed_deck)
  end

  def create_list(failed_deck)
    str = "\nFrequency of wrong answer in failed deck\n"
    failed_deck.deck.each do |card|
      str << "Question:\n" +
            "#{card[0].definition}\n" +
            "Failed #{card[1]} times.\n\n"
      end
    str
  end
end
