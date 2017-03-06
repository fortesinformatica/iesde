require 'spec_helper'

describe Iesde::API do
  let(:o_que)  { :cursos }
  let(:format) { :json }
  let(:opts)   { {} }
  let(:request) { double('Request') }
  let(:response)  { '"title": "example glossary"' }
  let(:config) {
    {
      config: {
        user:        ENV['IESDE_USER'],
        password:    ENV['IESDE_PWD'],
        ead_api_key: ENV['EAD_API_KEY']
      }
    }
  }

  before do
    allow(Iesde::Request).to receive(:new).with('getCursos', format, config ) { request }
    allow(request).to receive(:execute) { response }
  end

  context '#new' do
    before do
      opts[:config] = config
    end

    subject { Iesde::API.new(o_que, format, opts) }

    context 'type of requisition' do
      context "when it's valid" do
        it 'requests with valid path' do
          expect(Iesde::Request).to receive(:new).with('getCursos', format,  config)
          subject
        end

        context 'executes the request' do
          let(:opts) { { one: 'valid param', two: 'other valid param' } }

          after { subject }

          specify { expect(request).to receive(:execute).with(opts.reject { |k,_| k == :config }) }
        end

        context 'config param' do
          context 'when given config into opts' do
            let(:config)         { {user: 'usuario', password: 's3cr3t', ead_api_key: 'API-KEY'} }
            let(:another_config) { {user: 'usuario2', password: 's3cr3t0', ead_api_key: 'API-KEY-2'} }

            before do
              opts[:config] = config
            end

            xit 'use the given configuration' do
              subject
              expect(Iesde::config.user).to        eq(config[:user])
              expect(Iesde::config.password).to    eq(config[:password])
              expect(Iesde::config.ead_api_key).to eq(config[:ead_api_key])
            end

            context 'it does not changes default values' do
              before do
                opts[:config] = another_config
              end

              it 'to new ones' do
                expect{ subject }.to_not change {
                  Iesde::config.user
                }
                expect{ subject }.to_not change {
                  Iesde::config.password
                }
                expect{ subject }.to_not change{
                  Iesde::config.ead_api_key
                }
              end
            end
          end
        end
      end

      context 'when it is not valid' do
        let(:o_que)   { :none }

        specify { expect{subject}.to raise_error { ArgumentError } }
      end

    end
  end

  context '#as_json' do
    let(:api) { Iesde::API.new(o_que, format, opts) }

    context 'with a' do
      context 'valid response' do
        it 'returns a JSON' do
          expect(api.as_json).to eq response
        end

        it 'parses as JSON' do
          expect(JSON).to receive(:parse).with(response)
          api.as_json
        end
      end

      context 'invalid response' do
        it 'returns response itself' do
          expect(api.as_json).to eq response
        end
      end
    end
  end

  describe '#tem_chave?' do
  end

  describe '#tem_matricula?' do
  end

  describe '#salvo_com_sucesso?' do
  end

  describe '#msg' do
  end

  describe '#self.build_url' do
  end

  describe '#tipo_requisicao' do
  end

end
