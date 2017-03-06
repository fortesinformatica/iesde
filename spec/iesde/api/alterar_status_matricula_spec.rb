require 'spec_helper'

describe Iesde::Api::AlterarStatusMatricula do
  let(:format)  { :json }
  let(:opts)    { { a: 1 } }
  let(:api)     {
    { config: {
        user:        ENV['IESDE_USER'],
        password:    ENV['IESDE_PWD'],
        ead_api_key: ENV['EAD_API_KEY']
      }
    }
  }
  let(:request) { double('request') }
  let(:status)  {  '{"status": 1 }' }

  subject      { Iesde::Api::AlterarStatusMatricula.new(format, opts) }

  before do
    allow(Iesde::Request).to receive(:new) { request }
    allow(request).to receive(:execute)    { status }
  end

  describe '#initialize' do
    it "call Request" do
      VCR.use_cassette('alterar_matricula') do
        expect(Iesde::Request).to receive(:new).with('situacao', :json, api) { request }
        subject
      end
    end
  end

  describe '#status' do
    it "returns status value" do
      VCR.use_cassette('alterar_matricula') do
        expect(subject.status).to eq(1)
      end
    end
  end

  describe '#msg' do
    context 'when there was an error' do
      let(:mensagem) { 'Algo de errado' }

      before do
        allow(request).to receive(:execute) { '{ "status": false, "mensagem": "' + mensagem + '"}' }
      end

      it "returns mensagem value" do
        VCR.use_cassette('alterar_matricula') do
          expect(subject.msg).to eq(mensagem)
        end
      end
    end
  end
end
