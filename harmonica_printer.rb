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
