class Float
  EPISILON = 1e-6

  # Equals for floats with tolerance
  def equals?(x, tolerance = EPISOLON)
    (self - x).abs < tolerance
  end
end
