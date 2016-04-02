source 'https://rubygems.org'

# Specify your gem's dependencies in sjs.gemspec
gemspec

@@check ||= at_exit do
  require 'lock_jar/bundler'
  LockJar::Bundler.lock!
end
