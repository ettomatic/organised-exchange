# frozen_string_literal: true
require 'timecop'
require 'organised_exchange'

RSpec.configure do |config|
  config.before do
    t = Time.local(2020, 12, 29, 16, 50, 0)
    Timecop.freeze(t)
  end
end
