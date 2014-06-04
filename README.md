rspec\_html\_formatters
=======================

These two scripts are for formatting html/xml in RSpec tests (presumably for
exploration and debugging). They are intended to be temporarily copied into the
lib directory when needed instead of installed as a gem because sometimes when
debugging somebody else's project (or even your own), it's easier not to have to
add items to the Gemfile. That's especially true if you've already made edits
to the Gemfile that you don't want to interfere with.

Installation
------------
Just copy either script into the lib directory of your rails app.


Usage
-----
Make sure to require the appropriate script in your test file. For example:
`require 'format_html_rexml'`. You will then have access to the methods
`display_formatted_html` and `formatted_html` which take a single string
argument containing html. The former will ouput formatted html while the latter
will simply return it. If you are using Capybara, outputting the current page's
html looks like this: `display_formatted_html(page.html)`.

Which file to use
----------------------------
The advantage of using format\_html\_rexml.rb is that is uses REXML which is
included in the standard library. So, if you are using Bundler, you won't get
a complaint that REXML isn't in your Gemfile. It also won't include an xml
header like the format\_html\_nokogiri.rb version will. REXML's parsing ability
is not as robust as Nokogiri's though. Minor html syntax errors will cause an
error and stop the html from being formatted. If you are looking for html syntax
errors, that could be an advantage though.
