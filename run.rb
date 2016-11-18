require './harmonica_printer'
require './hole_printer'
require './harmonica'

harp = Harmonica.new('C')

puts HarmonicaPrinter.to_string(harp)
puts
puts HolePrinter.to_string(harp.holes)
