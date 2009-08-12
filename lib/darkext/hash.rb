class Hash
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

  def method_missing(m,*a)
    if m.to_s =~ /=$/
      self[$`] = a[0]
    elsif a.empty?
      self[m]
    else
      raise NoMethodError, "#{ m}"
    end
  end

  # http://noobkit.com/show/ruby/gems/development/merb/hash/symbolize_keys-21.html
  def symbolize_keys!
    each do |k,v|
      sym = k.respond_to?(:to_sym) ? k.to_sym : k
      self[sym] = Hash === v ? v.symbolize_keys! : v
      delete(k) unless k == sym
    end
    self
  end
end
