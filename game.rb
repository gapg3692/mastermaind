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
    show_results
    play_again
  end

  def show_results
    puts "#{@player1.name} have #{@player1.total_points} points and #{@player2.name} have #{@player2.total_points} points"
    if @player1.total_points < @player2.total_points
      puts "#{@player1.name} wins!!!"
    elsif  @player2.total_points < @player1.total_points
      puts "#{@player2.name} wins!!!"
    else
      puts 'That was a tie!'
    end
  end

  def play_again
    puts 'If you what to play again select 1, else select 2'
    case gets.chomp
    when '1'
      play_game
    when '2'
      exit
    else
      play_again
    end
  end

  def reset_game
    @rounds = 0
    @points = 1
    @type_of_oponents = '1'
  end

  def vs_computer
    if @rounds.even? && @rounds.positive?
      @player2.code_generate
      play_round(@player1, @player2.code)
    else
      player_code_generate(@player1)
      play_round(@player2, @player1.code)
    end
    vs_computer if @rounds.positive?
    reset_game
  end

  def vs_player
    if @rounds.even? && @rounds.positive?
      player_code_generate(@player2)
      play_round(@player1, @player2.code)
    else
      player_code_generate(@player1)
      play_round(@player2, @player1.code)
    end
    vs_computer if @rounds.positive?
    reset_game
  end

  def player_code_generate(player)
    while player.code[3] == 'empty'
      show_board_code_select(player)
      puts "#{player.name} select a color"
      puts color_menu
      player.code_generate
    end
  end

  def play_round(player, code)
    select_combination(player)
    player.current_solve = player.compare_code(code, player.current_code_guess)
    player.find_code if player.type == 'computer'
    show_board(player)
    if player.win?
      puts "#{player.name} cracked the code in #{@points} chances"
      next_round(player)
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

  def show_board_code_select(player)
    clear_screen
    puts "#{player.name} select your secret code"
    puts code_top_row
    puts code_row(player.code)
    puts code_bottom_row
  end

  def chance_points
    @points += 1
  end

  def next_round(player)
    player.increase_points(@points)
    @points = 1
    @rounds -= 1
    if @rounds.positive?
      puts 'Press Enter key to play the next round'
      gets.chomp
    end
  end

  def select_combination(player)
    if player.type == 'human'
      while player.current_code_guess[3] == 'empty'
        show_board(player)
        puts "#{player.name} select a color"
        puts color_menu
        player.new_guess_code
      end
    else
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
