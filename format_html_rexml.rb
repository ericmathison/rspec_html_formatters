require 'rexml/document'

class FormatHTML
  def initialize(html)
    indent_spaces = 2
    @result = ''
    @doc = REXML::Document.new(html).write(@result, indent_spaces)
  end

  def display
    puts @result
  end
end
