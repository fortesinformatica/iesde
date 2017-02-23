require 'spec_helper'

describe Iesde::Model::Disciplina do

  describe '#self.buscar' do
    subject { Iesde::Model::Disciplina.buscar }

    it "returns an array" do
      VCR.use_cassette('buscar_disciplina') do
        expect(subject).to be_a Array
      end
    end

    it 'calls ObterDisciplina.new with :json' do
      VCR.use_cassette('buscar_disciplina') do
        expect(Iesde::Api::ObterDisciplina).to receive(:new).with(:json).and_call_original
        subject
      end
    end
  end
end
