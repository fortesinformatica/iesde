require 'spec_helper'
require_relative '../../lib/concerns/linkable'

describe Linkable do
  context 'link' do
    class Example
      include Linkable

      def initialize(response)
        @response = response
      end
    end

    it 'does something' do
      e = Example.new("\"https:\\/\\/ead.local.co\\/videos\\/aulas\\/cooolllllller\\/asdfasdf.pdf?secure=asdfasdf\"")
      expect(e.link).to eq('https://ead.local.co/videos/aulas/cooolllllller/asdfasdf.pdf?secure=asdfasdf')
    end
  end
end
