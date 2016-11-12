class Harmonica
  NOTES = %w(C Db D Eb E F Gb G Ab A Bb B)

  INTERVALS = {
               #   1    2    3    4    5    6    7    8    9   10
    blow_bend2: [nil, nil, nil, nil, nil, nil, nil, nil, nil,  -2], # relative to blow
    blow_bend1: [nil, nil, nil, nil, nil, nil, nil,  -1,  -1,  -1], # relative to blow
    blow:       [  0,   4,   3,   5,   4,   3,   5,   4,   3,   5], # relative to the key
    draw:       [  2,   3,   4,   2,   1,   2,  -1,  -2,  -2,  -3], # relative to the blow
    draw_bend1: [ -1,  -1,  -1,  -1, nil,  -1, nil, nil, nil, nil], # relative to draw
    draw_bend2: [nil,  -2,  -2, nil, nil, nil, nil, nil, nil, nil], # relative to draw
    draw_bend3: [nil, nil,  -3, nil, nil, nil, nil, nil, nil, nil], # relative to draw
  }

  attr_reader :key

  def initialize(key)
    @key = key.upcase
  end

  def blow_bends2
    add_intervals(blows, INTERVALS[:blow_bend2])
  end

  def blow_bends1
    add_intervals(blows, INTERVALS[:blow_bend1])
  end

  def blows
    note = @key
    INTERVALS[:blow].inject([]) do |a, interval|
      note = add_interval(note, interval)
      a << note
    end
  end

  def draws
    add_intervals(blows, INTERVALS[:draw])
  end

  def draw_bends1
    add_intervals(draws, INTERVALS[:draw_bend1])
  end

  def draw_bends2
    add_intervals(draws, INTERVALS[:draw_bend2])
  end

  def draw_bends3
    add_intervals(draws, INTERVALS[:draw_bend3])
  end

  def add_intervals(notes, intervals)
    notes.zip(intervals).inject([]) do |a, (blow_note, interval)|
      note = add_interval(blow_note, interval)
      a << note
    end
  end

  def add_interval(note, semitones)
    return nil if semitones.nil?
    index = (NOTES.index(note) + semitones) % NOTES.size
    NOTES[index]
  end
end

class HarmonicaPrinter
  def self.to_string(harp)
    [
      harp.blow_bends2,
      harp.blow_bends1,
      harp.blows,
      (1..10),
      harp.draws,
      harp.draw_bends1,
      harp.draw_bends2,
      harp.draw_bends3
    ].map do |row|
      join(row)
    end.join("\n")
  end

  def self.join(things)
    things.map do |thing|
      thing.to_s.ljust(2).rjust(4)
    end.join
  end
end


harp = Harmonica.new('C')

puts HarmonicaPrinter.to_string(harp)
