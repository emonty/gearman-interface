require 'mkmf'

HERE = File.expand_path(File.dirname(__FILE__))

$CPPFLAGS = $CFLAGS = $LDFLAGS = ""
$LDFLAGS = " -L/usr/local/lib -lstdc++ -lm -lc -lgcc_s"

if ENV['DEBUG']
  puts "Setting debug flags for gem."
  $CPPFLAGS << " -O0 -g"
else
  $CPPFLAGS << "-O4"
end

if have_header('libgearman/gearman.h')
  if have_library('gearman','gearman_version')
    create_makefile 'gearman'
  end
end

