class SentenceCounter
  attr_reader :string

  def initialize(string)
    @string = string
  end

  def count
    sub.scan(/(\. |\?|\!|\.\.\.)/).size
  end

  private

  def sub
    if @string
      @string.gsub(/Mr\.|Mrs\.|Ms\.|Dr\.|[\?|\!|\.]["|']/, '#')
    else
      ''
    end
  end

end
