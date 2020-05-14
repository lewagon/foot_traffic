require_relative "lib/foot_traffic/version"

Gem::Specification.new do |spec|
  spec.name = "foot_traffic"
  spec.version = FootTraffic::VERSION
  spec.authors = ["Andy B"]
  spec.email = ["andrey@lewagon.org"]

  spec.summary = "Control a fleet of Chromes from a Ruby script. Built on Ferrum."
  spec.description = "Foot Traffic allows to simulate real web users for load testing, debugging, or feature discovery"
  spec.homepage = "https://github.com/lewagon/foot_traffic"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lewagon/foot_traffic"
  spec.metadata["changelog_uri"] = "https://github.com/lewagon/foot_traffic/CHANGELOG"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ferrum", "~> 0.8"
  spec.add_development_dependency "rspec", "~> 3.2"
end
