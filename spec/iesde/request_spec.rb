require 'spec_helper'

describe Iesde::Request do
  let(:host)    { "ead.portalava.com.br" }
  let(:port)    { 80 }
  let(:format)  { :json }
  let(:ask_for) { 'getCursos' }

  let(:config) {
    {
      config: {
        user:        ENV['IESDE_USER'],
        password:    ENV['IESDE_PWD'],
        ead_api_key: ENV['EAD_API_KEY']
      }
    }
  }
  let(:subject) { Iesde::Request.new(ask_for, format, config) }

  context 'execute' do
    it 'calls NET::HTTP.new' do
      VCR.use_cassette('request') do
        expect(Net::HTTP).to receive(:new).with(host, port).and_call_original
        subject.execute
      end
    end

    it 'does something' do
      VCR.use_cassette('request') do
        expect(Net::HTTP::DigestAuth).to receive(:new).and_call_original
        subject.execute
      end
    end
  end
end
