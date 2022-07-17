# frozen_string_literal: true

require_relative 'player'

# Computer class
class Computer < Player
  def initialize(name = 'Computer', type = 'maker')
    super
  end

  def code_generate
    @code = []
    4.times { @code.push(@colors.sample) }
  end
end
