# Pontoon
# Adapted from the BASIC listing in the Amstrad CPC 464 User Instructions (1984)
# This is intended as a 'faithful' conversion of the BASIC code - it is not good Ruby!

def initialise
  aces = computer_aces = player = computer = 0
  suits = ['Clubs', 'Hearts', 'Spades', 'Diamonds']
  system 'clear' or system 'cls'
  pack = Array.new(53, 0)
  first_deal(pack, suits, player, aces, computer, computer_aces)
end

def first_deal(pack, suits, player, aces, computer, computer_aces)
  puts "You#{' ' * 15}House"
  value = deal(pack, suits)
  player += value
  aces += 1 if value == 11
  value = deal(pack, suits)
  player += value
  aces += 1 if value == 11
  print ' ' * 18
  value = deal(pack, suits)
  computer += value
  computer_aces += 1 if value == 11
  print ' ' * 18
  value = deal(pack, suits)
  computer += value
  computer_aces += 1 if value == 11
  input(pack, suits, player, aces, computer, computer_aces)
end

def input(pack, suits, player, aces, computer, computer_aces)
  puts 'Twist (T) or Stick (S) ?'
  answer = gets.chomp.upcase
  input(pack, suits, player, aces, computer, computer_aces) if (answer != 'S' && answer != 'T')
  stick(pack, suits, player, computer, computer_aces) if answer == 'S'
  value = deal(pack, suits)
  player += value
  aces += 1 if value == 11
  score_check(pack, suits, player, aces, computer, computer_aces)
end

def score_check(pack, suits, player, aces, computer, computer_aces)
  input(pack, suits, player, aces, computer, computer_aces) if player < 22
  if aces > 0
    aces -= 1
    player -= 10
    score_check(pack, suits, player, aces, computer, computer_aces)
  end
  puts "You're Bust!"
  go_again
end

def go_again
  loop do
    puts 'Another Game? (Y/N)'
    answer = gets.chomp.upcase
    initialise if answer == 'Y'
    exit if answer == 'N'
  end
end

def stick(pack, suits, player, computer, computer_aces)
  result player, computer if computer > 16
  print ' ' * 18
  value = deal(pack, suits)
  computer += value
  computer_aces += 1 if value == 11
  stick(pack, suits, player, computer, computer_aces) if computer < 21
  result(player, computer) if computer_aces == 0
  computer_aces -= 1
  computer -= 10
  stick(pack, suits, player, computer, computer_aces) if computer < 21
end

def result(player, computer)
  if computer > 21 || computer < player
    puts 'You win!'
    go_again
  else
    puts 'The House wins!'
    go_again
  end
end

def deal(pack, suits)
  card = rand(52) + 1
  if pack[card] == 1
    deal(pack, suits)
  elsif pack[card] == 0
    pack[card] = 1
    value = card - (13 * (card / 13).to_i)
    value = 13 if value == 0
    suit = suits[(((card - 1) / 13).to_i)]
    if value == 1
      puts "Ace of #{suit}"
    elsif value == 11
      puts "Jack of #{suit}"
    elsif value == 12
      puts "Queen of #{suit}"
    elsif value == 13
      puts "King of #{suit}"
    else
      puts "#{value} of #{suit}"
    end
    value = 10 if value > 10
    value = 11 if value == 1
    value
  end
end

initialise
