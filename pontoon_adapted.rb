class Pontoon
  def initialize
    system 'clear' or system 'cls'
    @player = @computer = @aces = @computer_aces = 0
    @suits = %w[Clubs Hearts Spades Diamonds]
    @pack = Array.new(53, 0)
    puts "You#{' ' * 15}House"
    game('player')
    game('computer')
    input
  end

  def game(user)
    num = @player.zero? || @computer.zero? ? 2 : 1
    num.times do
      print ' ' * 18 if user == 'computer'
      value = deal
      calculate(value, user)
    end
  end

  def calculate(value, user)
    case user
    when 'player'
      @player += value
      @aces += 1 if value == 11
    when 'computer'
      @computer += value
      @computer_aces += 1 if value == 11
    end
  end

  def input
    puts 'Twist (T) or Stick (S) ?'
    case gets.chomp.upcase
    when 'S'
      stick
    when 'T'
      game 'player'
      score_check
    end
    input
  end

  def score_check
    input if @player < 22
    if @aces.positive?
      @aces -= 1
      @player -= 10
      score_check
    end
    puts "You're Bust!"
    go_again
  end

  def go_again
    loop do
      puts 'Another Game? (Y/N)'
      answer = gets.chomp.upcase
      Pontoon.new if answer == 'Y'
      exit if answer == 'N'
    end
  end

  def stick
    until @computer > 21
      result if @computer > 16
      game 'computer'
      stick
      result if @computer_aces.zero?
      @computer_aces -= 1
      @computer -= 10
    end
  end

  def result
    puts (@computer > 21 || @computer < @player ? 'You win!' : 'The House wins!')
    go_again
  end

  def deal
    card = rand(1..52)
    case @pack[card]
    when 1
      deal
    when 0
      @pack[card] = 1
      get_card_value(card)
    end
  end

  def get_card_value(card)
    value = card - (13 * (card / 13).to_i)
    value = 13 if value.zero?
    suit = @suits[(((card - 1) / 13).to_i)]
    display_card(value, suit)
    value = 10 if value > 10
    value = 11 if value == 1
    value
  end

  def display_card(value, suit)
    cards = { 1 => "Ace of #{suit}", 11 => "Jack of #{suit}",
              12 => "Queen of #{suit}", 13 => "King of #{suit}" }
    puts cards[value].nil? ? "#{value} of #{suit}" : cards[value]
  end
end

Pontoon.new
