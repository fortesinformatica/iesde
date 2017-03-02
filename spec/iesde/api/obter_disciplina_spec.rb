require 'spec_helper'

describe Iesde::Api::ObterDisciplina do

    subject {Iesde::Api::ObterDisciplina.new(format, {}) }

    let(:format) { :json }

    let(:request) { double('request') }

    before do
      allow(request).to receive(:execute) { }
    end

    describe '#initialize' do
      it "call Request" do
        expect(Iesde::Request).to receive(:new).with('getDisciplinas', :json) { request }
        subject
      end
    end
  end
