require 'spec_helper'

describe Iesde::Api::ObterAula do
  describe '#initialize' do
    let(:format) { :json }
    let(:opts)   {
      {
      'MatriculaID'  => 57238,
      'DisciplinaID' => 203
      }
    }

    subject { Iesde::Api::ObterAula.new(format, opts).as_json }

    context 'when response has' do
      context 'json' do
        it "returns the classes" do
          VCR.use_cassette('obter_aula') do
            expect(subject).to be_a Array
          end
        end

        it "not be empty" do
          VCR.use_cassette('obter_aula') do
            expect(subject).to_not be_empty
          end
        end
      end

      context 'String' do
        let(:opts)   {
          {
          'MatriculaID'  => 57238,
          'DisciplinaID' => 666
          }
        }

        it "returns the classes" do
          VCR.use_cassette('obter_aula_errado') do
            expect(subject).to be_a Array
          end
        end

        it "be empty" do
          VCR.use_cassette('obter_aula_errado') do
            expect(subject).to be_empty
          end
        end
      end
    end
  end
end
