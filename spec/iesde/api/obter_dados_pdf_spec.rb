require 'spec_helper'

describe Iesde::Api::ObterDadosPdf do

  subject { Iesde::Api::ObterDadosPdf.new(format, opts) }

  let(:format) { :json }
  let(:opts)   {
    {
      'qqr_coisa'        => 57238,
      'mais_outra_coisa' => 203
    }
  }

  let(:request) { double('request') }

  before do
    allow(request).to receive(:execute) { }
  end

  describe '#initialize' do
    it "call Request" do
      expect(Iesde::Request).to receive(:new).with('getPdfsDisciplina', :json) { request }
      subject
    end
  end
end
