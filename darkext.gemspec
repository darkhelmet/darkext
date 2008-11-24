Gem::Specification.new do |s|
  s.name = %q{darkext}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Huckstep"]
  s.cert_chain = ["/home/helmet/.gem/gem-public_cert.pem"]
  s.date = %q{2008-11-24}
  s.description = %q{Just some useful Ruby functionality. No particular focus, except usefulness}
  s.email = ["darkhelmet@darkhelmetlive.com"]
  s.extra_rdoc_files = ["Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/darkext.rb", "script/console", "script/destroy", "script/generate", "test/test_darkext.rb", "test/test_helper.rb", "lib/darkext/array.rb", "lib/darkext/boolean.rb", "lib/darkext/hash.rb", "lib/darkext/io.rb", "lib/darkext/numeric.rb", "lib/darkext/statistics.rb", "lib/darkext/string.rb", "lib/darkext/symbol.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/darkhelmet/darkext/}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{darkext}
  s.rubygems_version = %q{1.3.1}
  #s.signing_key = %q{/home/helmet/.gem/gem-private_key.pem}
  s.summary = %q{Just some useful Ruby functionality}
  s.test_files = ["test/test_helper.rb", "test/test_darkext.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.1.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
