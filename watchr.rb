# Run me with:
#   $ watchr watchr.rb

# --------------------------------------------------
# Rules
# --------------------------------------------------
watch( '^test.*/*_test.*\.rb'                )  { rake } # or run specific one { |m| ruby m[0] }
watch( '^lib/(.*)\.rb'                       )  { rake } # { |m| ruby "test/test_#{m[1]}.rb" }
watch( '^test/test_helper\.rb'               )  { rake }
watch( '^web/public/css/(.*)\.scss'          )  { sass }

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

def sass
  run "bundle exec sass --style compressed --scss -I web/public/css/ web/public/css/elephant.scss web/public/css/elephant.css"
end

def run( cmd )
  puts   cmd
  system cmd
end
