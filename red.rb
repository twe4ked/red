require 'terminal_game_engine'

require 'lib/point'
require 'lib/buffer'
require 'lib/keys'

TerminalGameEngine.run do
  height = 25
  width = 80

  buffer = Buffer.new width: width
  cursor = Point.new width: width

  mode = :insert

  on_tick do |tick|
    frame = TerminalGameEngine::Frame.new width, height

    on_input do |key|
      case mode
      when :insert
        case
        when key == Keys::CTRL_C
          exit
        when key == Keys::ESCAPE
          mode = :normal
        when key =~ /[[:print:]]/
          max_chars = width * (height-1)
          if buffer.size >= max_chars-1
            print "\a"
          else
            buffer << key
            cursor = cursor.right
          end
        when key = Keys::BACKSPACE
          if cursor.beginning_of_line?
            cursor = cursor.left
          else
            cursor = cursor.left
            buffer = buffer.delete cursor.coordinates
          end
        else
          raise key
        end
      when :normal
        case key
        when Keys::CTRL_C
          exit
        when 'i'
          mode = :insert
        when 'h'
          cursor = cursor.left
        when 'l'
          cursor = cursor.right
        end
      end
    end

    frame.draw 0, 0, buffer.to_s
    frame.draw width-4, height-1, buffer.size.to_s.rjust(4, '0')
    frame.draw 0, height-1, "[#{mode.to_s.upcase}]"

    frame.render

    TerminalGameEngine::Frame.move_cursor *cursor.coordinates
  end
end
