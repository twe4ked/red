require 'terminal_game_engine'

require 'lib/point'
require 'lib/buffer'
require 'lib/keys'

TerminalGameEngine.run do
  height = 25
  width = 80

  buffer = Buffer.new
  cursor = Point.new(width: width)

  on_tick do |tick|
    frame = TerminalGameEngine::Frame.new width, height

    on_input do |key|
      case
      when key == Keys::CTRL_C
        exit
      when key =~ /[[:print:]]/
        buffer << key
        cursor = cursor.right
      when key = Keys::BACKSPACE
        if cursor.beginning_of_line?
          cursor = cursor.left
        else
          buffer = buffer.delete
          cursor = cursor.left
        end
      else
        raise key
      end
    end

    frame.draw 0, 0, buffer.to_s(width: width)

    frame.render

    TerminalGameEngine::Frame.move_cursor *cursor.coordinates
  end
end
