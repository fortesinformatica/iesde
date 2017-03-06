require 'spec_helper'

describe Iesde::Api::CriarMatricula do
  let(:retorno) { { "MatriculaID" => "1234" } }
  let(:format) { :json }
  let(:opts)   {
    {
      'qqr_coisa'  => 57238,
      'mais_outra_coisa' => 203
    }
  }


  let(:param) {
    {
      config: {
        user:        ENV['IESDE_USER'],
        password:    ENV['IESDE_PWD'],
        ead_api_key: ENV['EAD_API_KEY']
      }
    }
  }

  let(:request) { double('request') }
  subject {Iesde::Api::CriarMatricula.new(format, opts) }

  before do
    allow(request).to receive(:execute) { retorno }
  end

  describe '#initialize' do
    it "call Request" do
      expect(Iesde::Request).to receive(:new).with('cadastro', :json, param) { request }
      subject
    end
  end

  describe '.matricula_id_do_retorno' do
    before do
      VCR.use_cassette('criar_matricula') do
        allow(subject).to receive(:as_json) { retorno }
      end
    end

    it 'returns MatriculaID from response' do
      VCR.use_cassette('criar_matricula') do
        expect(subject.matricula_id_do_retorno).to eq('1234')
      end
    end
  end
end
