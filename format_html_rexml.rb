require 'rexml/document'

module FormatHtml
  def display_formatted_html(html)
    @html = html
    process
    puts @result
  end

  private

  def process
    @indent_spaces = 2
    @result = ''
    @doc = REXML::Document.new(@html).write(@result, @indent_spaces)
  end
end

RSpec.configure { |config| config.include FormatHtml }
