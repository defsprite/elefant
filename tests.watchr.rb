# Run me with:
#   $ watchr tests.watchr.rb

# --------------------------------------------------
# Rules
# --------------------------------------------------
watch( '^test.*/*_test.*\.rb'                 ) { rake } # or run specific one { |m| ruby m[0] }
watch( '^lib/(.*)\.rb'                       )  { rake } # { |m| ruby "test/test_#{m[1]}.rb" }
watch( '^test/test_helper\.rb'               )  { rake }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
Signal.trap('QUIT') { rake  } # Ctrl-\
Signal.trap('INT' ) { abort("\n") } # Ctrl-C

# --------------------------------------------------
# Helpers
# --------------------------------------------------
def rake
  run "clear"
  run "bundle exec rake"
end

def run( cmd )
  puts   cmd
  system cmd
end
