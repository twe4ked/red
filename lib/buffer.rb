class Buffer
  def initialize buffer: [], width:
    @buffer = buffer
    @width = width
  end

  def to_s
    buffer
      .each_slice(width)
      .map(&:join)
      .join("\n")
  end

  def << char
    Buffer.new buffer: buffer << char, width: width
  end

  def delete coordinates
    index_to_delete = coordinates[1] * width + coordinates[0]

    left = index_to_delete == 0 ? [] : buffer[0..index_to_delete-1]
    right = buffer[index_to_delete+1..-1]

    Buffer.new buffer: left + right, width: width
  end

  def size
    buffer.size
  end

  private

  attr_reader :buffer, :width
end
