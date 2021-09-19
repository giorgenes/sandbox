---
to: <%= platform %>/<%= name %>/solution.rb
---
#!/usr/bin/env ruby

require 'pry'
require 'byebug'

if $PROGRAM_NAME == __FILE__
    puts "hello"
end

