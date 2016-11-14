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
end
