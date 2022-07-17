# frozen_string_literal: true

# require_relative 'display'
# class Game is were the magig happends
class Game
  attr_reader :game

  include Display

  def initialize
    @type_of_oponents = '1'
    @points = 1
    @rounds = 0
    play_game
  end

  def play_game
    players
    number_of_rounds
    @type_of_oponents == '1' ? vs_computer : vs_player
  end

  def vs_computer
    if @rounds.even? && @rounds.positive?
      @player2.code_generate
      play_round(@player1, @player2.code)
    end
  end

  def play_round(player, code)
    select_combination(player)
    player.current_solve = player.compare_code(code, player.current_code_guess)
    show_board(player)
    if player.win?
      puts 'you win'
    else
      chance_points
      play_round(player, code)
    end
  end

  def show_board(player)
    clear_screen
    puts top_row
    player.round_code_guess.each_with_index do |_str, i|
      puts game_row(player.round_code_guess[i], player.round_solve[i], i + 1)
      puts middle_row
    end
    puts game_row(player.current_code_guess, player.current_solve, @points)
    puts bottom_row
  end

  def chance_points
    @points += 1
  end

  def next_round
    @rounds -= 1
  end

  def select_combination(player)
    while player.current_code_guess[3] == 'empty'
      show_board(player)
      puts 'Select a color'
      puts color_menu
      player.new_guess_code
    end
  end

  def players
    puts 'Select 1 to play against computer or 2 to play against between two players'
    case @type_of_oponents = gets.chomp
    when '1'
      @player1 = Human.new(select_name(1))
      @player2 = Computer.new
    when '2'
      @player1 = Human.new(select_name(1))
      @player2 = Human.new(select_name(2))
    else
      players
    end
  end

  def number_of_rounds
    puts 'Select number of rounds. Must be a even number'
    @rounds = gets.chomp.to_i
    number_of_rounds unless @rounds.positive? && @rounds.even?
  end
end
