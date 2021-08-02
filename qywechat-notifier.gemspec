
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "qywechat/notifier/version"

Gem::Specification.new do |spec|
  spec.name          = "qywechat-notifier"
  spec.version       = Qywechat::Notifier::VERSION
  spec.authors       = ["yunyi"]
  spec.email         = ["chen1125he@163.com"]

  spec.summary       = %q{qywechat exception notifier}
  spec.homepage      = "https://github.com/dao42/qywechat-notifier"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency('exception_notification')
  spec.add_dependency('http', "~> 4.4.1")
end
