require './tic.rb'
 
players = {:player1 => "Andrew", :player2 => "Bot"}
marks = {:player1 => "O", :player2 => "X"}
game = TicTacToe.new(players, marks)
loop do
	puts "Play game? (y/n)"
	answer = gets.chomp
	break if answer !~/[Yy]|[Ee][Ss]/
	game.play_game
end



