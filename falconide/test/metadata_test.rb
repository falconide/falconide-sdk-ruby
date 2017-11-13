require './lib/falconide/metadata'
require 'minitest'
require 'minitest/autorun'

describe "MetaData" do
    before do
    	@metadata=Falconide::MetaData.new
        @metadata.addCC("test@gmail.com","api")
        @metadata.addCC("test2@gmail.com","api2")
        @metadata.addSubstitue("k","val")
    end

    describe "check if metadata is constructed" do
    	it "is metadata initialized ?" do
    	  @metadata.wont_be_nil
    	end
    	it "is xpiheader not nil" do
    	  @metadata.setxapiheader("test")
    	  assert_equal("test", @metadata.xapiheader,"Xapiheader is not set")
    	end

        it "recepientccs and xapirecepients are not null" do
           assert_equal("test@gmail.com",@metadata.recipientCcs(0),"not same")
           assert_equal("api",@metadata.recipientCCsXapis(0),"not same")
           assert_equal("test2@gmail.com",@metadata.recipientCcs(1),"not same")
           assert_equal("api2",@metadata.recipientCCsXapis(1),"not same")
        end

        it "is attributes created as not null" do
           @metadata.substitute.wont_be_nil
        end

    end

end