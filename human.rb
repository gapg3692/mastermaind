# frozen_string_literal: true

require_relative 'player'

# Class human
class Human < Player
  def initialize(name = 'Player', type = 'human')
    super
  end

  def new_guess_code
    code_fill(@current_code_guess)
  end

  def code_generate
    code_fill(@code)
  end

  def code_fill(code_to_fill)
    code_to_fill = %w[empty empty empty empty] unless code_to_fill[3] == 'empty'
    selection = gets.chomp.to_i
    if selection.positive? && selection <= 6
      code_to_fill[code_to_fill.find_index('empty')] = @colors[selection - 1]
    else
      'Invalid selection, Repeat'
    end
  end
end
