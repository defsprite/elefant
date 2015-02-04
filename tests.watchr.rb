# Run me with:
#   $ watchr tests.watchr.rb

# --------------------------------------------------
# Rules
# --------------------------------------------------
watch( '^test.*/test_.*\.rb'                 )  { ruby tests } #{ |m| ruby  m[0] }
watch( '^lib/(.*)\.rb'                       )  { ruby tests } #{ |m| ruby "test/test_#{m[1]}.rb" }
watch( '^test/test_helper\.rb'               )  { ruby tests }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
Signal.trap('QUIT') { ruby tests  } # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# --------------------------------------------------
# Helpers
# --------------------------------------------------
def ruby(*paths)
  run "clear"
  run "bundle exec ruby -I.:lib:test -e'%w( #{paths.flatten.join(' ')} ).each {|p| require p }'"
end

def tests
  Dir['test/**/test_*.rb'] - ['test/test_helper.rb']
end

def run( cmd )
  puts   cmd
  system cmd
end
