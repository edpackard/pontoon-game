This is a project to convert and otherwise play around with a 'type-in' BASIC program from the Amstrad CPC464 user manual (1984!): it is a rather basic Pontoon game. I remember painstakingly typing this in as a child, and being profoundly disappointed with the results! 

However, as part of the coding bootcamp I am currently undertaking, I had to code a simple Blackjack program in Ruby. This reminded me of my early programming experiments on the Amstrad, so I thought I'd dig out the Pontoon code and see if I could convert it to Ruby. 

The files in this repo are:

pontoon-amstrad.txt
A plain text file with the original program (I have fixed a couple of game-breaking typos that were in the manual...) If you're using the WinApe Amstrad emulator, you can copy and paste this code straight into an emulated CPC464 using the Auto-Type feature.

pontoon_with_BASIC.rb
This is a working Ruby program that includes the above text file as comments - it shows, line by line, how I have attempted to convert BASIC to Ruby. I have, for the most part, ignored the dialectical LOCATE command from the Amstrad so my console output does not match the Amstrad original, but the game still looks OK in the terminal, with the player's cards on the left and the computer on the right. 

pontoon.rb
This is the above file with the text comments stripped out, showing what an ugly mess it is when you try to convert BASIC to Ruby in a faithful manner!

pontoon_adapted.rb
This isn't great Ruby code, I know - I am a beginner! - but it is an improvement on pontoon.rb and is my attempt to recreate the spirit of the original BASIC game in Ruby.

The gameplay certainly hasn't improved with age, but it's a  mildly distracting Terminal program, with lots of scope for further customisation.
