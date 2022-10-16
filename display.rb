# frozen_string_literal: true

# Display contains the elements for printing the gameboard
module Display
  TOP_LEFT = "\u250C"
  TOP_RIGHT = "\u2510"
  BOTTOM_LEFT = "\u2514"
  BOTTOM_RIGHT = "\u2518"
  HOR = "\u2500"
  VER = "\u2502"
  T_DOWN = "\u252C"
  T_UP = "\u2534"
  T_RIGHT = "\u251C"
  T_LEFT = "\u2524"
  T_ALL = "\u253C"

  def top_row
    TOP_LEFT + HOR * 2 + T_DOWN + HOR * 13 + T_DOWN + HOR * 9 + TOP_RIGHT
  end

  def code_top_row
    TOP_LEFT + HOR * 13 + TOP_RIGHT
  end

  def middle_row
    T_RIGHT + HOR * 2 + T_ALL + HOR * 13 + T_ALL + HOR * 9 + T_LEFT
  end

  def bottom_row
    BOTTOM_LEFT + HOR * 2 + T_UP + HOR * 13 + T_UP + HOR * 9 + BOTTOM_RIGHT
  end
  def code_bottom_row
    BOTTOM_LEFT + HOR * 13 + BOTTOM_RIGHT
  end

  def game_row(pegs, keys, number)
    pegs = pegs.map { |str| get_peg(str) }
    keys = keys.map { |str| get_key(str) }
    number_strings = number < 10 ? " #{number}" : number.to_s
    VER + number_strings + VER + ' ' + pegs.join('  ') + '  ' + VER + ' ' + keys.join(' ') + ' ' + VER
  end

  def code_row(pegs)
    pegs = pegs.map { |str| get_peg(str) }
    VER + ' ' + pegs.join('  ') + '  ' + VER
  end

  def get_peg(color = 'empty')
    {
      'empty' => "\u25ef",
      'red' => "\u2b24".red,
      'green' => "\u2b24".green,
      'blue' => "\u2b24".blue,
      'yellow' => "\u2b24".yellow,
      'purple' => "\u2b24".purple,
      'cyan' => "\u2b24".cyan
    }[color]
  end

  def color_menu
    ' 1 '.bg_red + ' ' + ' 2 '.bg_blue + ' ' + ' 3 '.bg_green + ' ' + ' 4 '.bg_yellow + ' ' + ' 5 '.bg_purple + ' ' + ' 6 '.bg_cyan
  end

  def get_key(color = 'empty')
    {
      'empty' => "\u25cb",
      'used' => "\u25cc",
      'red' => "\u25cf".red,
      'white' => "\u25cf".white
    }[color]
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def select_name(number)
    puts "Select player #{number} name"
    gets.chomp
  end
end
