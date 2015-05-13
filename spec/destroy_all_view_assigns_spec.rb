require 'spec_helper'

describe DestroyAllViewAssigns do

  # do clean up, to prevent data polution
  after do
    DestroyAllViewAssigns.configure do |conf|
      conf.black_list = []
      conf.white_list = []
    end
  end

  it 'has a version number' do
    expect(DestroyAllViewAssigns::VERSION).not_to be nil
  end

  it "has no black listed controllers by default" do
    expect(DestroyAllViewAssigns.black_list).to be_empty
  end

  it "has no white listed controllers by default" do
    expect(DestroyAllViewAssigns.white_list).to be_empty
  end

  describe "#white_list" do
    let(:list) { ['UsersController', 'PostsController'] }
    let(:configure!) do
      DestroyAllViewAssigns.configure do |conf|
        conf.white_list = ['UsersController', 'PostsController']
      end
    end

    it "can be configured to filter some controllers" do
      configure!
      expect(DestroyAllViewAssigns.white_list).to eq(list.to_set)
    end
  end

  describe "#black_list" do
    let(:list) { ['UsersController', 'PostsController'] }
    let(:configure!) do
      DestroyAllViewAssigns.configure do |conf|
        conf.black_list = ['UsersController', 'PostsController']
      end
    end

    it "can be configured to filter some controllers" do
      configure!
      expect(DestroyAllViewAssigns.black_list).to eq(list.to_set)
    end
  end


  describe "#black_list and #white_list" do
    let(:list) { ['UsersController', 'PostsController'] }
    let(:configure!) do
      DestroyAllViewAssigns.configure do |conf|
        conf.black_list = ['UsersController', 'PostsController']
        conf.white_list = ['UsersController', 'PostsController']
      end
    end

    it "can not be configured for white AND black list at the same time" do
      expect {
        configure!
      }.to raise_error(DestroyAllViewAssigns::Configuration::Error)
    end
  end
end
