class Object
  def try(*args, &block)
    return if self.nil?
    block.given? ? yield(self) : self.__send__(args.shift, *args)
  end
end
