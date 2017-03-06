require 'spec_helper'
require_relative '../../lib/concerns/stringable'

describe Stringable do
  class Example
    include Stringable

    def initialize(response)
      @response = response
    end
  end

  let(:param) { 'Param' }

  it "creates a decent to_s output" do
    e = Example.new(param)
    expect(e.to_s).to eq("response: #{param}")
  end
end
