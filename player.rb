# frozen_string_literal: true

# class basic for all classes of player
class Player
  attr_reader :name, :game, :code, :current_code_guess,  :round_code_guess, :round_solve
  attr_accessor :current_solve

  def initialize(name, type)
    @name = name
    @total_points = 0
    @code = []
    @current_code_guess = %w[empty empty empty empty]
    @round_code_guess = []
    @current_solve = %w[empty empty empty empty]
    @round_solve = []

    @type = type
    @colors = %w[red blue green yellow purple cyan]
  end

  def reset_game
    @code = []
  end
end
