class Player
	attr_reader :player, :mark

	def initialize player, mark
		@player = player
		@mark = mark
	end
end

class Board
	def initialize
		@board = initialize_board
	end

	def mark(location, mark)
		if @board[location] == "-"
			@board[location] = mark
			return true
		end

		false
	end

	def print_board
		puts "----------------"
		@board.reverse.each_slice(3) { |row| puts row.reverse.join(" | ")}
		puts "----------------"
	end 

	def win?
		check_win
	end

	def full_board
		return true if !@board.include?("-")

		false
	end

	private

	def initialize_board
		Array.new(9, "-")
	end

	def check_win
		three_in_row(0,1,2) ||
		three_in_row(3,4,5) ||
		three_in_row(6,7,8) ||
		three_in_row(0,3,6) ||
		three_in_row(1,4,7) ||
		three_in_row(2,5,8) ||
		three_in_row(0,4,8) ||
		three_in_row(2,4,6) 
	end

	def three_in_row(first, second, third)
		return true if @board[first] == @board[second] and @board[second] == @board[third] and 
			![@board[first], @board[second], @board[third]].include?("-")

		false
	end
		
end


class TicTacToe
	def initialize(players,marks)
		@player1 = Player.new(players[:player1], marks[:player1])
		@player2 = Player.new(players[:player2], marks[:player2])
		@board = Board.new
		@turn = @player1
	end

	def play_game 
		loop do 
			@board.print_board
			location = prompt_player
			change_turn if @board.mark(map(location), @turn.mark) and !@board.win?
			break if @board.win? or @board.full_board
		end

		@board.print_board

		if @board.win?
			puts winner
		else
			puts "Tie!"
		end
	end
	
	private 

	def prompt_player
		location = ""

		loop do 
			puts "Where does Player #{@turn.player} want to place their piece? (1-9)"
			location = gets.chomp
			break if location =~/\d/ and location.to_i.between?(1,9)
			puts "Enter in a valid position"
		end

		location.to_i
	end

	def change_turn 
		@turn = (@turn == @player1 ? @player2 : @player1)
	end

	def winner
		"#{@turn.player} wins!"
	end

	def map location
		location - 1
	end
end