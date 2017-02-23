require 'spec_helper'

describe Iesde::Api::ObterVideo do
  context '#new' do
    let(:format) { :json }
    let(:opts)   {
      {
        'MatriculaID'  => 57238,
        'DisciplinaID' => 203
      }
    }

    let(:request) { double('request') }

    subject {Iesde::Api::ObterVideo.new(format, opts) }
    before do
      allow(request).to receive(:execute) {  }
    end

    it "call Request" do
      expect(Iesde::Request).to receive(:new).with('getVideoAula', :json) { request }
      subject
    end

    it 'respond_to link' do
      VCR.use_cassette('obter_video') do
        expect(subject).to respond_to(:link)
      end
    end
  end
end
