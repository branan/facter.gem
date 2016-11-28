require 'mkmf'
require 'erb'

cmake_binary = find_executable('cmake')
source_root = File.expand_path("#{__FILE__}/..")
cmake_opts = ENV['FACTER_CMAKE_OPTS']

make_template = File.open(source_root+"/Makefile.erb").read
makefile = ERB.new(make_template).result(binding)
File.write('Makefile', makefile)
