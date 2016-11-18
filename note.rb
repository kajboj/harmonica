require './nil_note'

class Note
  NOTES = %w(C Db D Eb E F Gb G Ab A Bb B)

  attr_reader :note, :octave

  def initialize(note, octave)
    @note, @octave = note, octave
  end

  def add_interval(semitones)
    return NilNote.new if semitones.nil?
    if semitones == 0
      self
    elsif semitones > 0
      self.add_semitone.add_interval(semitones-1)
    else
      self.sub_semitone.add_interval(semitones+1)
    end
  end

  def add_semitone
    if note == 'B'
      Note.new('C', octave + 1)
    else
      next_index = index + 1
      Note.new(NOTES[next_index], octave)
    end
  end

  def sub_semitone
    if note == 'C'
      Note.new('B', octave - 1)
    else
      prev_index = index - 1
      Note.new(NOTES[prev_index], octave)
    end
  end

  def index
    NOTES.index(note)
  end

  def self.add_intervals(notes, intervals)
    notes.zip(intervals).inject([]) do |a, (blow_note, interval)|
      note = blow_note.add_interval(interval)
      a << note
    end
  end
end
