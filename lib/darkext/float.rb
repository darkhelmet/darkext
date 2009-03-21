class Float
  # Equals for floats with tolerance
  def equals?(x, tolerance = 1e-6)
    (self - x).abs < tolerance
  end
end
