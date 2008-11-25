class Symbol
  # Does exactly what the activesupport version does,
  # with pretty much the same code.
  unless :to_proc.respond_to?(:to_proc)
    def to_proc
      Proc.new { |*args| args.shift.__send__(self, *args) }
    end
  end
end
