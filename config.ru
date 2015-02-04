require 'elephant'
require 'elephant/web'


require 'active_record'
ActiveRecord::Base.establish_connection(adapter: 'postgresql', database: 'subscrib_webapp_development', user: 'sassi', password: nil)

#Elephant.configure do |config|
#  config.connection_options = {adapter: 'postgresql', database: 'elephant_test', user: 'sassi', password: nil}
#  config.disable_ar = false
#end

run Elephant::Web
