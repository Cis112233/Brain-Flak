require 'io/console'
require_relative './stack.rb'
require_relative './Flag.rb'
require_relative './BrainFlakError.rb'
require_relative './Interpreter.rb'

class ClassicInterpreter < Interpreter

  def initialize(source, left_in, right_in, debug, max_cycles, ascii_mode)
    super(source, left_in, right_in, debug, max_cycles)
    @ascii_mode = ascii_mode
  end

  # Nilads ~~~~~~~~~~~~~~~~~~~~~
 
  def round_nilad()
    @current_value += 1
  end

  def square_nilad()
    @current_value -= 1
  end

  def curly_nilad()
    @current_value += @active_stack.pop
  end

  def angle_nilad()
    @active_stack = @active_stack == @left ? @right : @left
  end

  # Open Braces ~~~~~~~~~~~~~~~~

  def open_round()
    @main_stack.push([')', @current_value, @index])
    @current_value = 0
  end

  def open_square()
    @main_stack.push([']', @current_value, @index])
    @current_value = 0
  end

  def open_curly()
    @main_stack.push(['}', 0, @index])
    new_index = read_until_matching(@source, @index)
    if active_stack.peek == 0 then
      @main_stack.pop()
      @index = new_index
    end
  end

  def open_angle()
    @main_stack.push(['>', @current_value, @index])
    @current_value = 0
  end

  # Close Braces ~~~~~~~~~~~~~~~

  def close_round()
    data = main_stack.pop()
    @active_stack.push(@current_value)
    @current_value += data[1]
  end

  def close_square()
    data = main_stack.pop()
    if @ascii_mode
      print (@current_value % 2 ** 32).chr(Encoding::UTF_8)
    else
      puts @current_value
     end
    @current_value += data[1]
  end

  def close_curly()
    data = @main_stack.pop()
    @index = data[2] - 1
    @last_op = :close_curly
    @current_value += data[1]
  end

  def close_angle()
    data = main_stack.pop()
    @current_value = data[1]
  end

end
