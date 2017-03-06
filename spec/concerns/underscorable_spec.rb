require 'spec_helper'
require_relative '../../lib/concerns/underscorable'

describe Underscorable do
  class Example
    include Underscorable

    def initialize(response)
      @response = response
    end

    def as_json
      [{
        'FirstKey'  => 'first key',
        'SecondKey' => 'second key'
      }]
    end
  end

  class AnotherClass
    attr_accessor :param, :param_2

    def initialize(*args)
      @param, @param_2 = args
    end
  end

  context 'Instanciate model given with provided as_json info' do
    before do
      e       = Example.new('something')
      @another = e.underscorize_fields(AnotherClass).first
    end

    specify { expect(@another.param).to eq('first key') }
    specify { expect(@another.param_2).to eq('second key') }
  end
end
