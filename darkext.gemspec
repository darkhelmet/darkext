# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{darkext}
  s.version = "0.9.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Huckstep"]
  s.date = %q{2009-03-13}
  s.description = %q{Just some useful Ruby functionality. No particular focus, except usefulness}
  s.email = %q{darkhelmet@darkhelmetlive.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["VERSION.yml", "README.rdoc", "History.txt", "lib/darkext", "lib/darkext/numeric.rb", "lib/darkext/string.rb", "lib/darkext/io.rb", "lib/darkext/fiber.rb", "lib/darkext/symbol.rb", "lib/darkext/statistics.rb", "lib/darkext/sinatra.rb", "lib/darkext/boolean.rb", "lib/darkext/hash.rb", "lib/darkext/net.rb", "lib/darkext/object.rb", "lib/darkext/array.rb", "lib/darkext/sitemap_generator.rb", "lib/darkext/beagle.rb", "lib/darkext/float.rb", "lib/darkext/integer.rb", "lib/darkext.rb", "test/helper.rb", "test/darkext_test.rb", "spec/spec.opts"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/darkhelmet/darkext}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Just some useful Ruby functionality}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
