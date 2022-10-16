# frozen_string_literal: true

# class basic for all classes of player
class Player
  attr_reader :name, :game, :code, :current_code_guess, :round_code_guess, :round_solve, :type, :total_points
  attr_accessor :current_solve

  def initialize(name, type)
    @name = name
    @total_points = 0
    @code = %w[empty empty empty empty]
    @current_code_guess = %w[empty empty empty empty]
    @round_code_guess = []
    @current_solve = %w[empty empty empty empty]
    @round_solve = []
    @type = type
    @colors = %w[red blue green yellow purple cyan]
  end

  def reset_game
    @code = %w[empty empty empty empty]
    @round_code_guess = []
    @round_solve = []
  end

  def compare_code(code, guess_code)
    temp_code = code.clone
    temp_guess = guess_code.clone
    temp_solve = %w[empty empty empty empty]
    temp_guess.each_with_index do |str, i|
      next unless temp_code[i] == str

      temp_solve.shift
      temp_solve.push('red')
      temp_code[i] = 'empty'
      temp_guess[i] = 'found'
    end
    temp_guess.each do |str|
      next unless temp_code.include? str

      temp_solve.shift
      temp_solve.push('white')
      temp_code[temp_code.index(str)] = 'empty'
    end

    temp_solve
  end

  def win?
    round_code_guess.push(@current_code_guess)
    round_solve.push(@current_solve)
    result = @current_solve == %w[red red red red]
    @current_solve = %w[empty empty empty empty]
    @current_code_guess = %w[empty empty empty empty]
    reset_game if result
    result
  end

  def increase_points(round_points)
    @total_points += round_points
  end
end
