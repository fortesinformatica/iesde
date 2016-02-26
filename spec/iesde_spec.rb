require 'spec_helper'

describe Iesde do
  it 'has a version number' do
    expect(Iesde::VERSION).not_to be nil
  end

  describe "configure" do

    let(:username) { "12345678" }
    let(:password) { "123456789123456" }

    subject do 
      Iesde.configure do |config|
        config.default_username = username
        config.default_password = password
      end
    end

    before { subject }

    it "Has a configuration set" do
      expect(Iesde.config).to_not be_nil
    end

    it "Has a username" do
      expect(Iesde.config.default_username).to eq(username)
    end
      
    it "Has a password" do
      expect(Iesde.config.default_password).to eq(password)
    end
  end

end
