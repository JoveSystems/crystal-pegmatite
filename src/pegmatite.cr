require "./pegmatite/*"

module Pegmatite
  VERSION = "0.1.0"
  
  # A token is a triple containing a name, a start offset, and end offset,
  # representing a named pattern that was matched within the overall pattern.
  alias Token = {Symbol, Int32, Int32}
  
  # Return the array of tokens resulting from executing the given pattern
  # grammar over the given source string, starting from the given offset.
  # Raises a Pattern::MatchError if parsing fails.
  def self.tokenize(
    pattern : Pattern,
    source : String,
    offset = 0,
  ) : Array(Token)
    length, result = pattern.match(source, offset, true)
    
    case result
    when Pattern
      raise Pattern::MatchError.new(result, length)
    when Token
      [result]
    when Array(Token)
      result
    else
      [] of Token
    end
  end
end
