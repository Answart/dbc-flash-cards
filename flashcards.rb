# Main file for

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
