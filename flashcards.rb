class View

  def self.welcome
    puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition.  Ready?  Go!"
    sleep(0.3)
  end

  def self.continue_game (definition)
    puts "#{definition}"
    user_input = gets.chomp
    puts
    Controller.check_answer(user_input)
  end

  def self.correct_answer
    puts "Correct!"
  end

  def self.incorrect_answer
    puts "Incorrect! Try again:"
  end

  def self.print_score(scores)
    puts "\n\nGreat job!! Thanks for playing."
    puts "You got #{scores[0]} correct, and #{scores[1]} incorrect."
  end

end


class Controller

  def self.start_game
    View.welcome
    # Repleace line below with @deck_test = Deck.start()
    @master_deck = [{"what is a greeting?" => "hello" }, {"what is a another greeting?" => "hi" }]
    @master_deck.shuffle!
    @scores = Array.new(2){0}
    View.continue_game(@master_deck.first.keys[0])
    View.print_score(@scores)
  end

  def self.check_answer(user_answer)
    if user_answer.upcase == @master_deck.first.values[0].upcase #deck.card.guess   #need to access guess attribute in Card Class
      View.correct_answer
      @master_deck.shift
      @scores[0] += 1
      unless @master_deck.empty?
        View.continue_game(@master_deck.first.keys[0])
      end
    else
      View.incorrect_answer
      View.continue_game (@master_deck.first.keys[0])
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
      @flash_cards << {definition => @terms[index]}
    end
    @flash_cards
  end
end

class Player
  attr_accessor :challenges, :score

  def initialize
    @score = 0
    @challenges = []
  end
end

new_deck = Deck.new
p new_deck

Controller.start_game


# txtfile = File.open('flashcard_samples.txt') do |card|
#   card.each do |line|
#     key = line.chomp.split("\n")
#     nextline = line.next
#     hash[key] = nextline.chomp.split("\n")
#   end
# end
# p hash


# class Deck
#   def initialize(txtfile = 'flashcard_samples.txt')
#     @txtfile = txtfile
#     @all_cards = []



#   end
# end


# class Card
#   def initialize

#   end
# end


  #   @flash_cards = Hash[@definitions.zip(@terms)]





    # flash_cards = []
# definitions = []
# terms = []


# # big_array.each_with_index do |element, index|
# #   definitions << element if index.even?
# #   terms << element if index.odd?
# # end


# big_array.each_with_index do |element, index|
#   index.even? ? definitions << element : terms << element
# end


# flash_cards = definitions.zip(terms)
# p Hash[flash_cards]
