class Hash
  # Merges defaults with the hash
  def with_defaults(defaults)
    self.merge(defaults) { |key,old,new| old.nil? ? new : old }
  end

  # Merges defaults with the hash (destructive)
  def with_defaults!(defaults)
    self.merge!(defaults) { |key,old,new| old.nil? ? new : old }
  end

  def nested_find(*keys)
    v = self
    keys.each do |key|
      v = v[key]
      return nil if v.nil?
    end
    return v
  end

  # http://snippets.dzone.com/posts/show/4146
  def deep_merge!(second)
    # From: http://www.ruby-forum.com/topic/142809
    # Author: Stefan Rusterholz
    merger = proc { |key,v1,v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    self.merge!(second, &merger)
  end

  def nested_hash(array)
    node = self
    array.each do |i|
      node[i]=Hash.new if node[i].nil?
      node = node[i]
    end
    self
  end

  def merge_nested_hash!(nested_hash)
    deep_merge!(nested_hash)
  end
end
