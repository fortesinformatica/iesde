require 'spec_helper'

describe Iesde::Model::Matricula do
  describe '#buscar' do
    VCR.use_cassette('buscar') do
      subject { Iesde::Model::Matricula.buscar }

      it "returns an array" do
        VCR.use_cassette('buscar_matricula') do
          expect(subject).to be_a Array
        end
      end

      it "calls ObterMatricula.new" do
        VCR.use_cassette('buscar_matricula') do
          expect(Iesde::Api::ObterMatricula).to receive(:new).with(:json).and_call_original
          subject
        end
      end
    end
  end

  describe '#criar' do
    subject { Iesde::Model::Matricula.criar(params)}
  end
end
