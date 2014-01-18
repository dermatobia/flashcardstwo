require_relative 'view_flashcards'
require_relative 'model_flashcards'
require 'debugger'

class Controller
  
  def initialize(filename)
    @user = User.new
    @deck = Deck.new(filename)
    @current_card = @deck.retrieve_random_card  
    @cardview = CardView.new(@current_card)
    @userview = UserView.new(@user)

    @failed_deck = FailedDeck.new
    @failed_deck_view = FailedDeckView.new @failed_deck

  end

  def play    
    cardview.display_definition

# debugger
    input = STDIN.gets.chomp

    case 
    when input == 'quit'
      @userview.display_correct
      @failed_deck_view.display_failed
      goodbye
      return
    when deck.correct_answer?(input)                        
      correct
      @user.update_total_correct
      @userview.display_misses
      @failed_deck.add_card_logic(@current_card, @user.misses_on_current)
      @user.reset_missed_on_current
      draw_random_card
      cardview.set_card(@current_card)
      play
    else
      try_again
      @user.update_missed_on_current
      play
    end
  end

  def draw_random_card
    self.current_card = deck.retrieve_random_card
  end



  private
  attr_reader :cardview, :deck
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
end

# c = Controller.new("alternative_deck.txt")
# c.play

# puts ARGV[0].class
if ARGV.any?
  c = Controller.new(ARGV[0])
  c.play
else
  c = Controller.new("flashcard_samples.txt")
  c.play
end




