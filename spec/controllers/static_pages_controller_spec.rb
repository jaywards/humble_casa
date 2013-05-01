require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'pricing_plans'" do
    it "returns http success" do
      get 'pricing_plans'
      response.should be_success
    end
  end

  describe "GET 'feature_tour'" do
    it "returns http success" do
      get 'feature_tour'
      response.should be_success
    end
  end

  describe "GET 'contact_us'" do
    it "returns http success" do
      get 'contact_us'
      response.should be_success
    end
  end

  describe "GET 'careers'" do
    it "returns http success" do
      get 'careers'
      response.should be_success
    end
  end

end
