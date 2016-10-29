class Buffer
  def initialize buffer: []
    @buffer = buffer
  end

  def to_s width:
    buffer
      .each_slice(width)
      .to_a
      .map(&:join)
      .join("\n")
  end

  def << char
    Buffer.new buffer: buffer << char
  end

  def delete
    Buffer.new buffer: buffer[0..-2]
  end

  private

  attr_reader :buffer
end
