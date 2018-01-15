require 'io/console'
require_relative './stack.rb'
require_relative './Flag.rb'
require_relative './BrainFlakError.rb'
require_relative './Interpreter.rb'

class BrainFlakInterpreter < Interpreter
$r="round"
$s="square"
$c="curly"
$a="angle"
$n="nil"
$o="open"
$cl="close"
  # Nilads ~~~~~~~~~~~~~~~~~~~~~
	 
  def round_nilad()
    @current_value += 1 
    puts r
  end

  def square_nilad()
    @current_value += @active_stack.height 
    puts s+n
  end

  def curly_nilad()
    @current_value += @active_stack.pop 
    puts c+n
  end

  def angle_nilad()
    @active_stack = @active_stack == @left ? @right : @left 
    puts a+n
  end

  # Open Braces ~~~~~~~~~~~~~~~~

  def open_round()
    @main_stack.push([')', @current_value, @index]) 
    puts o+r
    @current_value = 0
  end

  def open_square()
    @main_stack.push([']', @current_value, @index]) 
    puts o+s
    @current_value = 0
  end

  def open_curly()
    @main_stack.push(['}', 0, @index])
    new_index = read_until_matching(@source, @index) 
    puts o+c
    if active_stack.peek == 0 then
      @main_stack.pop()
      @index = new_index
      @cycles += 1
    end
  end

  def open_angle()
    @main_stack.push(['>', @current_value, @index]) 
    puts o+a
    @current_value = 0
  end

  # Close Braces ~~~~~~~~~~~~~~~

  def close_round()
    data = @main_stack.pop()
    @active_stack.push(@current_value) 
    puts cl+r
    @current_value += data[1]
  end

  def close_square()
    data = @main_stack.pop() 
    puts cl+s
    @current_value *= -1
    @current_value += data[1]
  end

  def close_curly()
    data = @main_stack.pop() 
    puts cl+c
    @index = data[2] - 1
    @last_op = :close_curly
    @current_value += data[1]
  end

  def close_angle()
    data = @main_stack.pop() 
    puts cl+a
    @current_value = data[1]
  end

end
