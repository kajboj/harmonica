require './note'
require './hole'

class Harmonica
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
    add_intervals(blows, :blow_bend2)
  end

  def blow_bends1
    add_intervals(blows, :blow_bend1)
  end

  def blows
    note = Note.new(@key, 0)
    INTERVALS[:blow].inject([]) do |a, interval|
      note = note.add_interval(interval)
      a << note
    end
  end

  def draws
    add_intervals(blows, :draw)
  end

  def draw_bends1
    add_intervals(draws, :draw_bend1)
  end

  def draw_bends2
    add_intervals(draws, :draw_bend2)
  end

  def draw_bends3
    add_intervals(draws, :draw_bend3)
  end

  def add_intervals(notes, intervals_symbol)
    Note.add_intervals(notes, INTERVALS[intervals_symbol])
  end

  def holes
    holes = []

    draws.each.with_index do |draw, index|
      holes << Hole.new((index+1).to_s, draw)
    end

    blows.each.with_index do |draw, index|
      holes << Hole.new("+"+(index+1).to_s, draw)
    end

    holes = holes.sort_by do |hole|
      hole.note.octave*100 + hole.note.index
    end

    holes
  end
end
