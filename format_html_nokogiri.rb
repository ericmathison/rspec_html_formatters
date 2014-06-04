require 'nokogiri'

# Based on a script by Emmanuel Oga:
# https://gist.github.com/EmmanuelOga/322025
# http://emmanueloga.wordpress.com/2009/09/29/pretty-printing-xhtml-with-nokogiri-and-xslt/
# Modifications by Eric Mathison

module FormatHtml
  def formatted_html(html)
    @html = Nokogiri(html)
    process
    @result
  end

  def display_formatted_html(html)
    @html = Nokogiri(html)
    process
    puts @result
  end

  private

  def process
    @result = ''
    set_xsl_var
    xsl = Nokogiri::XSLT(@xsl)
    @result = xsl.apply_to(@html).to_s
  end

  def set_xsl_var
    @xsl = <<-EOXSL
    <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output method="xml" encoding="ISO-8859-1"/>
      <xsl:param name="indent-increment" select="'   '"/>

      <xsl:template name="newline">
        <xsl:text disable-output-escaping="yes">
    </xsl:text>
      </xsl:template>

      <xsl:template match="comment() | processing-instruction()">
        <xsl:param name="indent" select="''"/>
        <xsl:call-template name="newline"/>
        <xsl:value-of select="$indent"/>
        <xsl:copy />
      </xsl:template>

      <xsl:template match="text()">
        <xsl:param name="indent" select="''"/>
        <xsl:call-template name="newline"/>
        <xsl:value-of select="$indent"/>
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:template>

      <xsl:template match="text()[normalize-space(.)='']"/>

      <xsl:template match="*">
        <xsl:param name="indent" select="''"/>
        <xsl:call-template name="newline"/>
        <xsl:value-of select="$indent"/>
          <xsl:choose>
           <xsl:when test="count(child::*) > 0">
            <xsl:copy>
             <xsl:copy-of select="@*"/>
             <xsl:apply-templates select="*|text()">
               <xsl:with-param name="indent" select="concat ($indent, $indent-increment)"/>
             </xsl:apply-templates>
             <xsl:call-template name="newline"/>
             <xsl:value-of select="$indent"/>
            </xsl:copy>
           </xsl:when>
           <xsl:otherwise>
            <xsl:copy-of select="."/>
           </xsl:otherwise>
         </xsl:choose>
      </xsl:template>
    </xsl:stylesheet>
    EOXSL
  end
end

RSpec.configure { |config| config.include FormatHtml }
