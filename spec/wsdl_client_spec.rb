require 'spec_helper'

module Iesde
  describe WSDLClient do

    describe "create" do

      context "When the parameter is valid" do

        context "and the parameter is :lista_curso" do
          it "creates a ListaCurso client" do
            expect(WSDLClient.create(:lista_curso)).to be_a(Clients::ListaCurso)
          end
        end

        context "and the parameter is :inativa_acesso" do
          it "creates a InativaAcesso client" do
            expect(WSDLClient.create(:inativa_acesso)).to be_a(Clients::InativaAcesso)
          end
        end

        context "and the parameter is :cadastro" do
          it "creates a Cadastro client" do
            expect(WSDLClient.create(:cadastro)).to be_a(Clients::Cadastro)
          end
        end

        context "and the parameter is :logout" do
          it "creates a Logout client" do
            expect(WSDLClient.create(:logout)).to be_a(Clients::Logout)
          end
        end

        context "and the parameter is :obtem_aulas" do
          it "creates a ObtemAula client" do
            expect(WSDLClient.create(:obtem_aulas)).to be_a(Clients::ObtemAula)
          end
        end

        context "and the parameter is :obtem_matriculas" do
          it "creates a ObtemMatricula client" do
            expect(WSDLClient.create(:obtem_matriculas)).to be_a(Clients::ObtemMatricula)
          end
        end

      end

      context "when the parameter is invalid" do
        it "Raises a NameError" do
          expect{ WSDLClient.create(:nothing_important) }.to raise_error(NameError)
        end
      end

    end

    describe "fetch_user_credentials" do
      let(:username) { "12345678" }
      let(:password) { "123456789123456" }

      let(:client) { WSDLClient.new }

      before do
        Iesde.configure do |config|
          config.default_username = username
          config.default_password = password
        end
      end

      it "returns a hash with the configuration data prepended to the param hash" do
        expect(client.fetch_user_credentials({a: 1})).to eq({login: username, senha: password, a: 1})
      end
    end

    describe "check_params_format" do
      
      let(:client) { WSDLClient.new }

      before { client.format = [ :one, :two, :three ] }

      context "when there is a missing param" do
        it "Adds error message" do
          expect(client.check_params_format({one: 1, two: 2})).to_not be_empty
        end
      end
      context "when there are all params" do
        context "and the params are in the wrong order" do
          it "Adds error message" do
            expect(client.check_params_format({one: 1, three: 3, two: 2})).to_not be_empty
          end
        end
        context "and the params are in the right order" do
          it "Doesn`t add error message" do
            expect(client.check_params_format({one: 1, two: 2, three: 3})).to be_empty
          end
        end
      end

    end

  end
end