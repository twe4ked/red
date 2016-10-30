class Buffer
  def initialize buffer: [], width:
    @buffer = buffer
    @width = width
  end

  def to_s
    buffer
      .each_slice(width)
      .to_a
      .map(&:join)
      .join("\n")
  end

  def << char
    Buffer.new buffer: buffer << char, width: width
  end

  def delete
    Buffer.new buffer: buffer[0..-2]
  end

  private

  attr_reader :buffer, :width
end
