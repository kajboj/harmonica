require './harmonica_printer'
require './harmonica'

harp = Harmonica.new('C')

puts HarmonicaPrinter.to_string(harp)
