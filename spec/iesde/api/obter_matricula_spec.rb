require 'spec_helper'

describe Iesde::Api::ObterMatricula do
  context '#new' do
    let(:format) { :json }

    let(:request) { double('request') }

    subject {Iesde::Api::ObterMatricula.new(format) }
    before do
      allow(request).to receive(:execute) {  }
    end

    it "call Request" do
      expect(Iesde::Request).to receive(:new).with('getMatriculas', :json) { request }
      subject
    end
  end
end
