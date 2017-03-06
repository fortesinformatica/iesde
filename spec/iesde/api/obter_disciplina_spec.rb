require 'spec_helper'

describe Iesde::Api::ObterDisciplina do

    subject {Iesde::Api::ObterDisciplina.new(format, {}) }

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

    before do
      allow(request).to receive(:execute) { }
    end

    describe '#initialize' do
      it "call Request" do
        expect(Iesde::Request).to receive(:new).with('getDisciplinas', :json, param) { request }
        subject
      end
    end
  end
