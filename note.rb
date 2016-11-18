class Note
  NOTES = %w(C Db D Eb E F Gb G Ab A Bb B)

  def self.add_interval(note, semitones)
    return nil if semitones.nil?
    index = (NOTES.index(note) + semitones) % NOTES.size
    NOTES[index]
  end

  def self.add_intervals(notes, intervals)
    notes.zip(intervals).inject([]) do |a, (blow_note, interval)|
      note = add_interval(blow_note, interval)
      a << note
    end
  end

  def self.interval(hole1, hole2)
    harp = Harmonica.new('C')

    harp.interval(hole1)
  end

  def self.holes_to_intervals(holes)
    return nil if holes.empty?

    hole = holes[0]
    intervals = [0]
    holes.each do |next_hole|
      intervals << interval(hole, next_hole)
      hole = next_hole
    end

    intervals
  end
end
