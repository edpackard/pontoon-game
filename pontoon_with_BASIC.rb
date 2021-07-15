# Pontoon
# Adapted from the BASIC listing in the Amstrad CPC 464 User Instructions (1984)
# This is intended as a 'faithful' conversion of the BASIC code - it is not good Ruby!

# 1 REM PONTOON

# 10 REM INITIALISE
def initialise
  # 20 YC=2:CC=2
  # 30 ACES=0
  # 40 CACES=0
  # 50 S=0
  # 60 T=0
  aces = computer_aces = player = computer = 0
  # 70 DIM SUIT$(4)
  # 80 SUIT$(1)="CLUBS"
  # 90 SUIT$(2)="HEARTS"
  # 100 SUIT$(3)="SPADES"
  # 110 SUIT$(4)="DIAMONDS"
  suits = ['Clubs', 'Hearts', 'Spades', 'Diamonds']
  # 120 CLS
  system  "clear" or system "cls"
  # 130 DIM PACK(52)
  # 140 FOR X=1 TO 52
  # 150 PACK (X)=0
  # 160 NEXT X
  pack = Array.new(53, 0)
  first_deal(pack, suits, player, aces, computer, computer_aces)
end

# 170 REM DEAL TWO CARDS TO EACH PLAYER
def first_deal pack, suits, player, aces, computer, computer_aces
  # 180 LOCATE 10,3
  # 190 PRINT"YOU";SPC(15);"HOUSE"
  puts "You#{' '*15}House"
  # 200 LOCATE 3,5
  # 210 GOSUB 740
  value = deal(pack, suits)
  # 220 S=S+F
  player += value
  # 230 IF F=11 THEN ACES=ACES+1
  aces +=1 if value == 11
  # 240 LOCATE 3,6
  # 250 GOSUB 740
  value = deal(pack, suits)
  # 260 S=S+F
  player += value
  # 270 IF F=11 THEN ACES=ACES+1
  aces +=1 if value == 11
  # 280 LOCATE 24,5
  print ' ' * 18
  # 290 GOSUB 740
  value = deal(pack, suits)
  # 300 T=T+F
  computer += value
  # 310 IF F=11 THEN CACES=CACES+1
  computer_aces +=1 if value == 11
  # 320 LOCATE 24,6
  print ' ' * 18
  # 330 GOSUB 740
  value = deal(pack, suits)
  # 340 T=T+F
  computer += value
  # 350 IF F=11 THEN CACES=CACES+1
  computer_aces +=1 if value == 11

  input(pack, suits, player, aces, computer, computer_aces)
end

# 360 REM INPUT OPTION - TWIST (T) OR STICK (S)
def input pack, suits, player, aces, computer, computer_aces
  # 370 X$=INKEY$:IF X$<>"S" AND X$<>"T" THEN 370
  puts "Twist (T) or Stick (S) ?"
  answer = gets.chomp.upcase
  input(pack, suits, player,aces, computer, computer_aces) if (answer != "S" && answer != "T")
  # 380 IF X$="S" THEN 560
  stick(pack, suits, player, computer, computer_aces) if answer == "S"
  # 390 LOCATE 3,YC+5
  # 400 YC=YC+1
  # 410 GOSUB 740
  value = deal(pack, suits)
  # 420 S=S+F
  player += value
  # 430 IF F=11 THEN ACES=ACES+1
  aces += 1 if value == 11
  score_check(pack, suits, player, aces, computer, computer_aces)
end

# 440 REM CHECK SCORE AND ACES
def score_check pack, suits, player, aces, computer, computer_aces
  # 450 IF S<22 THEN 370
  input(pack, suits, player, aces, computer, computer_aces) if player < 22
  # 460 IF ACES = 0 THEN 500
  if aces > 0
    # 470 ACES = ACES-1
    aces -= 1
    # 480 S = S-10
    player -= 10
    # 490 GOTO 450
    score_check(pack,suits,player,aces,computer,computer_aces)
  end
  # 500 LOCATE 12,19
  # 510 PRINT "YOU'RE BUST"
  puts "You're Bust!"
  go_again
end

def go_again
  loop do
    # 520 PRINT "ANOTHER GAME (Y/N)"
    puts "Another Game? (Y/N)"
    # 530 X$=INKEY$:IF X$<>"Y" AND X$<>"N" THEN 530
    answer = gets.chomp.upcase
    # 540 IF X$="Y" THEN RUN
    initialise if answer == 'Y'
    # 550 END
    exit if answer == 'N'
  end
end

def stick pack, suits, player, computer, computer_aces
  # 560 IF T>16 THEN GOTO 700
  result player, computer if computer > 16
  # 570 CC=CC+1
  # 580 LOCATE 24,CC+4
  print ' ' * 18
  # 590 GOSUB 740
  value = deal(pack, suits)
  # 600 T=T+F
  computer += value
  # 610 IF F=11 THEN CACES=CACES+1
  computer_aces +=1 if value == 11
  # 620 IF T<21 THEN 560
  stick(pack, suits, player, computer, computer_aces) if computer < 21
  # 630 IF CACES = 0 THEN 670
  # result("p", player, computer) if computer_aces == 0
  result(player,computer) if computer_aces == 0
  # 640 CACES = CACES-1
  computer_aces -= 1
  # 650 T=T-10
  computer -= 10
  # 660 GOTO 620
  stick(pack, suits, player, computer, computer_aces) if computer < 21
end

def result player, computer
  if computer > 21 || computer < player
    # 670 LOCATE 12,19
    # 680 PRINT "YOU WIN!"
    puts "You win!"
    # 690 GOTO 520
    go_again
    # 700 LOCATE 12,19
    # 710 IF T<S THEN 680
  else
    # 720 PRINT "THE HOUSE WINS"
    puts "The House wins!"
    # 730 GOTO 520
    go_again
  end
end

# 740 REM DEAL CARD
def deal pack, suits
  # 750 LET CARD=INT ( RND (1)*52+1 )
  card = rand(52)+1 # between 1 and 52
  # 760 IF PACK(CARD)=1 THEN GOTO 750
  if pack[card]==1
    deal(pack, suits)
  elsif pack[card]==0
    # 770 PACK(CARD)=1
    pack[card] = 1
    # 780 F=CARD-13*INT(CARD/13)
    value = card - (13 * (card/13).to_i)
    # 790 IF F=0 THEN F=13
    value = 13 if value == 0
    # 800 IF F=1 OR F>10 THEN GOTO 850
    # 810 PRINT F;"OF ";
    # 820 IF F>10 THEN F=10
    # 830 PRINT SUIT$(INT((CARD-1)/13)+1)
    # 840 RETURN
    # 850 IF F=11 THEN PRINT "JACK OF  ";
    # 860 IF F=12 THEN PRINT "QUEEN OF ";
    # 870 IF F=13 THEN PRINT "KING OF  ";
    # 880 IF F<>1 THEN GOTO 820
    # 890 F = 11
    # 900 PRINT "ACE OF   ";
    # 910 GOTO 830
    suit = suits[(((card-1)/13).to_i)]
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