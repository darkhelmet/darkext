class Object
  def is_boolean?
    self.is_a?(TrueClass) || self.is_a?(FalseClass)
  end
end

class TrueClass
  def intern
    return :true
  end
end

class FalseClass
  def intern
    return :false
  end
end
