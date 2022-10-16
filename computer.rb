# frozen_string_literal: true

require_relative 'player'

# Computer class
class Computer < Player
  attr_reader :solution

  def initialize(name = 'Computer', type = 'computer')
    super
    solution_reset
  end

  def code_generate
    # @code = []
    # 4.times { @code.push(@colors.sample) }
    @code = %w[red blue green yellow]
  end

  def solution_reset
    @solution = []
    (@colors * 4).permutation(4) do |permutation|
      @solution.push(permutation)
    end
    @solution.uniq!
  end

  def new_guess_code
    @current_code_guess = @solution.length == 1296 ? %w[red red blue blue] : @solution[0]
  end

  def find_code
    solution_reset if @solution.length == 1
    @solution.select! { |solution| solution if @current_solve == compare_code(@current_code_guess, solution) }
  end

  def win?
    result = super
    solution_reset if result
  end
end
