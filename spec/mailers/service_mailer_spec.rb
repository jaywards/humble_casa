require "spec_helper"

describe ServiceMailer do
  describe "service_created" do
    let(:mail) { ServiceMailer.service_created }

    it "renders the headers" do
      mail.subject.should eq("Service created")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "service_completed" do
    let(:mail) { ServiceMailer.service_completed }

    it "renders the headers" do
      mail.subject.should eq("Service completed")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
