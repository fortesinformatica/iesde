require 'spec_helper'

describe Iesde::Model::Aula do
  let(:opts)   {
    {
     "MatriculaID" => 57238,
         "CursoID" => 105689,
         "GradeID" => 56325,
    "DisciplinaID" => 203,
          "AulaID" => 8888,
            "Tema" => "Introdução à Administração Imobiliária e à Locação"
    }
  }
  let(:format) { :json }
  subject      { Iesde::Model::Aula.new(*opts) }

  context 'accessors' do
    it { is_expected.to respond_to(:matricula_id) }
    it { is_expected.to respond_to(:curso_id) }
    it { is_expected.to respond_to(:grade_id) }
    it { is_expected.to respond_to(:disciplina_id) }
    it { is_expected.to respond_to(:aula_id) }
    it { is_expected.to respond_to(:tema) }
  end

  describe '#buscar' do
    let(:opts) {
      [57238, 105689, 56325, 203, 8888, "Introdução à Administração Imobiliária e à Locação"]
    }

    let(:subject) { Iesde::Model::Aula.buscar(opts) }
    let(:obter_video) { double('obter_video') }

    before do
      allow(Iesde::Api::ObterAula).to receive(:new).with(:json, opts) { obter_video }
      allow(obter_video).to receive(:underscorize_fields)
    end


    it 'calls ObterAula.buscar with json and opts' do
      expect(Iesde::Api::ObterAula).to receive(:new).with(:json, opts)
      subject
    end

    it 'creates new Aula' do
      expect(obter_video).to receive(:underscorize_fields).with(Iesde::Model::Aula)
      subject
    end
  end

  describe '.link_video' do
    let(:instance)    { Iesde::Model::Aula.new(*opts) }
    let(:obter_video) { double('obter_video') }
    subject           { instance.link_video }

    context '#initialize' do
      before do
        allow(Iesde::Api::ObterVideo).to receive(:new).with(
          :json, {
              'MatriculaID' => ["MatriculaID", 57238],
              "AulaID"      => ["AulaID", 8888]
            }) { obter_video }
        allow(obter_video).to receive(:link)
      end

      it 'calls ObterVideo.new' do
        expect(Iesde::Api::ObterVideo).to receive(:new).with(
          :json, {
              'MatriculaID' => ["MatriculaID", 57238],
              "AulaID"      => ["AulaID", 8888]
            })
        subject
      end

      it 'calls .link' do
        expect(obter_video).to receive(:link)
        subject
      end
    end
  end
end
