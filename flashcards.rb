class View
  attr_reader :deck_choice, :which_deck, :chosen

  def self.welcome
    puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition.  Ready?  Go!"
    sleep(0.3)
  end

  def self.which_deck
    puts "-"*50
    puts "Which game would you like to play?"
    puts " --- easy (flashcard_easy.txt)"
    puts " --- hard (flashcard_samples.txt)"
    puts "-"*50
    deck_choice = gets.chomp!
    chosen_deck(deck_choice)
  end

  def self.chosen_deck(decision)
    if decision == "easy"
      chosen = 'flashcard_easy.txt'
    elsif decision == "hard"
      chosen = 'flashcard_samples.txt'
    else
      puts "Please choose a deck to play from the options above"
      which_deck
    end
    puts "You have chosen #{chosen}! Good luck!"
    return chosen
  end

  def self.continue_game (definition)
    puts "#{definition}"
    user_input = gets.chomp
    Controller.check_answer(user_input)
  end

  def self.correct_answer
    puts "-- Correct!\n\n"
  end

  def self.incorrect_answer
    puts "-- Incorrect! Try again:\n\n"
  end

  def self.print_score(scores)
    puts "\n\nGreat job!! Thanks for playing."
    puts "You got #{scores[0]} correct, and #{scores[1]} incorrect."
  end

end


class Controller

  def self.start_game
    View.welcome
    textfile = View.which_deck
    game = Deck.new(textfile)
    
    @deck = game.flash_cards
    @scores = Array.new(2){0}
    View.continue_game(@deck.first.keys[0])
    View.print_score(@scores)
  end

  def self.check_answer(user_answer)
    if user_answer.upcase == @deck.first.values[0].upcase #deck.card.guess   #need to access guess attribute in Card Class
      View.correct_answer
      @deck.shift
      @scores[0] += 1
      unless @deck.empty?
        View.continue_game(@deck.first.keys[0])
      end
    else
      View.incorrect_answer
      View.continue_game (@deck.first.keys[0])
      @scores[1] += 1
    end
  end
end

class Deck
  attr_accessor :players, :flash_cards

  def initialize(txtfile = 'flashcard_samples.txt', player_amount = 1)
    @txtfile = txtfile
    @flash_cards = []
    @definitions = []
    @terms = []
    create_hash
    @players = []
    player_amount.times { players << Player.new }
  end

  def create_hash
    big_array = File.readlines(@txtfile).join("").split("\n")
    big_array.delete("")
    big_array.each_with_index do |element, index|
      index.even? ? @definitions << element : @terms << element
    end

    @definitions.each_with_index do |definition, index|
      @flash_cards << { definition => @terms[index] }
    end
    @flash_cards.shuffle!
  end
end

class Player
  attr_accessor :challenges, :score

  def initialize
    @score = 0
    @challenges = []
  end
end


Controller.start_game
