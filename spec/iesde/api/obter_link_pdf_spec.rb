require 'spec_helper'

describe Iesde::Api::ObterLinkPdf do

  subject {Iesde::Api::ObterLinkPdf.new(format, opts) }
  let(:opts)   {
    {
      'qqr_coisa'        => 57238,
      'mais_outra_coisa' => 203
    }
  }

  let(:format) { :json }

  let(:request) { double('request') }

  before do
    allow(request).to receive(:execute) { }
  end

  describe '#initialize' do
    it "call Request" do
      expect(Iesde::Request).to receive(:new).with('getPdf', :json) { request }
      subject
    end
  end
end
