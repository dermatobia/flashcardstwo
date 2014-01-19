require_relative 'view_flashcards'
require_relative 'model_flashcards'
# require 'debugger'

class Controller
  
  def initialize(filename)
    @user = User.new
    @deck = Deck.from_file(filename)
    @current_card = nil
    @cardview = CardView.new
    @userview = UserView.new(@user)
    @failed_deck = FailedDeck.new
    @failed_deck_view = FailedDeckView.new
  end

  def play    
    initial_length = @deck.cards.length
    show_new_card
    input = ''
    hits = 0

    while hits < initial_length

      input = STDIN.gets.chomp
      case 
        when current_card.correct_answer?(input) 
          hits += 1                       
          correct
          user.update_total_correct
          userview.display_misses
          failed_deck.add_card_logic(@current_card, user.misses_on_current)
          user.reset_missed_on_current
          show_new_card if hits < initial_length
        when input == "quit"
          userview.display_correct
          failed_deck_view.display_failed(failed_deck)
          goodbye
          return
        else
          try_again
          user.update_missed_on_current
          show_same_card
      end

    end
    win
    @userview.display_correct
    goodbye
  end

  def draw_random_card
    @current_card = deck.retrieve_random_card
  end

  def show_new_card
    draw_random_card
    cardview.display_definition(@current_card)
  end

  def show_same_card
    cardview.display_definition(@current_card)
  end

  private
  attr_reader :cardview, :deck, :user, :userview, :failed_deck_view, :failed_deck
  attr_accessor :current_card

  def try_again
    puts "\n\nTry again!\n"
  end

  def correct
    puts "\n\nCorrect!\n"
  end

  def goodbye
    puts "\n\nThanks for playing SCJJ's Fantastic Flashcards Fiasco! Goodbye!"
  end

  def win
    puts "\n\nYou are a rock star!"
  end
end


if ARGV.any?
  c = Controller.new(ARGV[0])
  c.play
else
  c = Controller.new("flashcard_samples.txt")
  # c = Controller.new("alternative_deck.txt")
  c.play
end




