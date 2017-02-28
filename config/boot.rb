<<<<<<< HEAD
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
=======
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
>>>>>>> 1d41284de70d8c06ca24f72e194a2bddbe2c33fc

require 'bundler/setup' # Set up gems listed in the Gemfile.
