# frozen_string_literal: true

require_relative 'player'

# Class human
class Human < Player
  def initialize(name = 'Player', type = 'breaker')
    super
  end

  def new_guess_code
    @current_code_guess = %w[empty empty empty empty] unless @current_code_guess[3] == 'empty'
    selection = gets.chomp.to_i
    if selection.positive? && selection <= 6
      @current_code_guess[@current_code_guess.find_index('empty')] = @colors[selection - 1]
    else
      puts 'Invalid selection'
    end
  end

  def win?
    round_code_guess.push(@current_code_guess)
    round_solve.push(@current_solve)
    if @current_solve == %w[red red red red]
      @current_solve = %w[empty empty empty empty]
      @current_code_guess = %w[empty empty empty empty]
      true
    else
      @current_solve = %w[empty empty empty empty]
      @current_code_guess = %w[empty empty empty empty]
      false
    end
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
end
