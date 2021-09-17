#!/usr/bin/env ruby

$: << File.expand_path('../../lib', __FILE__)

require 'robot'
require 'parser'

if ARGV.size < 1
  puts "usage: robot FILE"
  exit 1
end

parser = Parser.new(File.open(ARGV[0]))
parser.execute(STDOUT)
