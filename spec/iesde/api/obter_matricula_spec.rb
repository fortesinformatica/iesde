require 'spec_helper'

describe Iesde::Api::ObterMatricula do
  context '#new' do
    let(:format) { :json }

    let(:request) { double('request') }

    let(:param) {
      {
        config: {
          user:        ENV['IESDE_USER'],
          password:    ENV['IESDE_PWD'],
          ead_api_key: ENV['EAD_API_KEY']
        }
      }
    }
    subject {Iesde::Api::ObterMatricula.new(format) }
    before do
      allow(request).to receive(:execute) {  }
    end

    it "call Request" do
      expect(Iesde::Request).to receive(:new).with('getMatriculas', :json, param) { request }
      subject
    end
  end
end
