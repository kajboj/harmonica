class HolePrinter
  def self.to_string(holes)
    [
      holes.map(&:hole),
      holes.map(&:note).map(&:note),
    ].map do |strings|
      strings.map do |string|
        string.rjust(4)
      end.join(' ')
    end.join("\n")
  end
end
