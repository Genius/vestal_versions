if ENV['COVERAGE']
  require 'coveralls'
  Coveralls.wear!
end

require 'vestal_versions'

require 'bundler'
Bundler.require(:test)

require 'rspec/its'

RSpec.configure do |c|
  c.expect_with(:rspec) { |e| e.syntax = [:should, :expect] }

  c.before(:suite) do
    CreateSchema.suppress_messages{ CreateSchema.migrate(:up) }
  end

  c.after(:each) do
    VestalVersions::Version.config.clear
    User.prepare_versioned_options({})
  end

  c.order = 'random'
end

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |f| require f }
