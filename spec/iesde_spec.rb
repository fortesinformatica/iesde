require 'spec_helper'

describe Iesde do
  it 'has a version number' do
    expect(Iesde::VERSION).not_to be nil
  end

  describe "configure" do

    let(:username)    { "12345678" }
    let(:password)    { "123456789123456" }
    let(:ead_api_key) { "asdfasdfasdfasdf" }

    subject do
      Iesde.configure do |config|
        config.user        = username
        config.password    = password
        config.ead_api_key = ead_api_key
      end
    end

    before { subject }

    it "Has a configuration set" do
      expect(Iesde.config).to_not be_nil
    end

    it "Has a username" do
      expect(Iesde.config.user).to eq(username)
    end

    it "Has a password" do
      expect(Iesde.config.password).to eq(password)
    end

    it "Has a ead_api_key" do
      expect(Iesde.config.ead_api_key).to eq(ead_api_key)
    end
  end
end
