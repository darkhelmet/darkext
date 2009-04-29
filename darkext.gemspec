# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{darkext}
  s.version = "0.11.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Huckstep"]
  s.date = %q{2009-04-28}
  s.default_executable = %q{sinatra-app}
  s.description = %q{Just some useful Ruby functionality. No particular focus, except usefulness}
  s.email = %q{darkhelmet@darkhelmetlive.com}
  s.executables = ["sinatra-app"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "History.txt",
    "README.rdoc",
    "VERSION.yml",
    "app_generators/sinatra_app_generator.rb",
    "app_generators/templates/app.rb",
    "app_generators/templates/config.ru",
    "app_generators/templates/error.rb",
    "app_generators/templates/gitignore",
    "app_generators/templates/helpers.rb",
    "app_generators/templates/http_method.rb",
    "app_generators/templates/options.rb",
    "bin/sinatra-app",
    "lib/darkext.rb",
    "lib/darkext/array.rb",
    "lib/darkext/beagle.rb",
    "lib/darkext/boolean.rb",
    "lib/darkext/fiber.rb",
    "lib/darkext/float.rb",
    "lib/darkext/hash.rb",
    "lib/darkext/integer.rb",
    "lib/darkext/io.rb",
    "lib/darkext/net.rb",
    "lib/darkext/numeric.rb",
    "lib/darkext/object.rb",
    "lib/darkext/sinatra.rb",
    "lib/darkext/sitemap_generator.rb",
    "lib/darkext/statistics.rb",
    "lib/darkext/string.rb",
    "lib/darkext/symbol.rb",
    "spec/array_spec.rb",
    "spec/beagle_spec.rb",
    "spec/boolean_spec.rb",
    "spec/fiber_spec.rb",
    "spec/float_spec.rb",
    "spec/hash_spec.rb",
    "spec/integer_spec.rb",
    "spec/io_spec.rb",
    "spec/net_spec.rb",
    "spec/numeric_spec.rb",
    "spec/object_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/statistics_spec.rb",
    "spec/string_spec.rb",
    "spec/symbol_spec.rb",
    "test/array_test.rb",
    "test/boolean_test.rb",
    "test/fiber_test.rb",
    "test/float_test.rb",
    "test/hash_test.rb",
    "test/helper.rb",
    "test/integer_test.rb",
    "test/io_test.rb",
    "test/numeric_test.rb",
    "test/object_test.rb",
    "test/statistics_test.rb",
    "test/string_test.rb",
    "test/symbol_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/darkhelmet/darkext}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Just some useful Ruby functionality}
  s.test_files = [
    "spec/array_spec.rb",
    "spec/beagle_spec.rb",
    "spec/boolean_spec.rb",
    "spec/fiber_spec.rb",
    "spec/float_spec.rb",
    "spec/hash_spec.rb",
    "spec/integer_spec.rb",
    "spec/io_spec.rb",
    "spec/net_spec.rb",
    "spec/numeric_spec.rb",
    "spec/object_spec.rb",
    "spec/statistics_spec.rb",
    "spec/string_spec.rb",
    "spec/symbol_spec.rb",
    "spec/spec_helper.rb",
    "test/helper.rb",
    "test/array_test.rb",
    "test/boolean_test.rb",
    "test/fiber_test.rb",
    "test/float_test.rb",
    "test/hash_test.rb",
    "test/integer_test.rb",
    "test/io_test.rb",
    "test/numeric_test.rb",
    "test/object_test.rb",
    "test/statistics_test.rb",
    "test/string_test.rb",
    "test/symbol_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
