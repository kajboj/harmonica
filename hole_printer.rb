class HolePrinter
  def self.to_string(holes)
    [
      holes.map(&:hole),
      holes.map(&:note).map(&:note),
      holes.map(&:note).map(&:index).map(&:to_s),
      holes.map(&:note).map(&:octave).map(&:to_s),
    ].map do |strings|
      strings.map do |string|
        string.rjust(3)
      end.join(' ')
    end.join("\n")
  end
end
