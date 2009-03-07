class Object
  def try(*args, &block)
    return nil if self.nil?
    block.given? ? yield(self) : self.__send__(args.shift, *args)
  end

  def tap
    yield(self)
    return self
  end
end
