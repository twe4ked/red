require 'terminal_game_engine'

require 'lib/point'
require 'lib/buffer'

TerminalGameEngine.run do
  height = 25
  width = 80

  buffer = Buffer.new
  cursor = Point.new(width: width)

  on_tick do |tick|
    frame = TerminalGameEngine::Frame.new width, height

    on_input do |key_code|
      case
      when key_code == TerminalGameEngine::Input::Keys::CTRL_C
        exit
      when key_code.chr =~ /[[:print:]]/
        buffer << key_code.chr
        cursor = cursor.right
      when key_code = 127 # Backspace
        buffer = buffer.delete
        cursor = cursor.left
      else
        raise key_code.to_s
      end
    end

    frame.draw 0, 0, buffer.to_s(width: width)

    frame.render

    TerminalGameEngine::Frame.move_cursor *cursor.coordinates
  end
end
