rspec\_html\_formatters
=======================

These two scripts are for formatting html/xml in RSpec tests (presumably for
exploration and debugging). They are intended to be copied into the lib
directory instead of installed as a gem because sometimes when debugging
somebody else's project, it's easier not to deal with the strict versioning
rules that apply to applications using bundler.

Installation
------------
Just copy either script into the lib directory of your rails app.


Usage
-----
Make sure to require the appropriate script in your test file. For example:
`require 'format_html_rexml'`. After doing so, pass the `display_formatted_html`
method a string containing the html that you would like to be formatted. If you
are using Capybara, outputting the current page's html looks like this:
`display_formatted_html(page.html)`.
