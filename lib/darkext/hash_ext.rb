class Hash
  # Merges defaults with the hash
  def with_defaults(defaults)
    self.merge(defaults) { |key,old,new| old.nil? ? new : old }
  end

  # Merges defaults with the hash (destructive)
  def with_defaults!(defaults)
    self.merge!(defaults) { |key,old,new| old.nil? ? new : old }
  end
end
