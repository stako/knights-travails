# frozen_string_literal: true

require_relative "lib/knights_travails"

knight = KnightsTravails::Knight.new
puts "Shortest path from [0, 0] to [3, 3]"
knight.moves([0, 0], [3, 3])
puts "\nShortest path from [3, 3] to [0, 0]"
knight.moves([3, 3], [0, 0])
puts "\nShortest path from [0, 0] to [7, 7]"
knight.moves([0, 0], [7, 7])
