require 'rake/extensiontask'
require 'rubygems/package_task'

##
# Rake::ExtensionTask comes from the rake-compiler and understands how to
# build and cross-compile extensions.
#
# See https://github.com/luislavena/rake-compiler for details

Rake::ExtensionTask.new 'facter' do |ext|
  ext.lib_dir = 'lib'
end

s = Gem::Specification.new 'facter', '3.5' do |s|
  s.summary = 'Facter gem wrapper'
  s.authors = %w[branan@puppet.com]

  # this tells RubyGems to build an extension upon install

  s.extensions = %w[ext/facter/extconf.rb]

  # naturally you must include the extension source in the gem

  s.files = FileList['ext/**/*', 'Rakefile']
end

Gem::PackageTask.new s do end

# This isn't a good test, but does provide a sanity check

task test: %w[compile] do
  ruby '-Ilib', '-rfacter', '-e', 'p Facter.to_hash'
end

task default: :test
