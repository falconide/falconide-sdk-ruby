require './lib/falconide/emaildetails'
require 'minitest'
require 'minitest/autorun'

describe "EmailDetails" do
    before do
    	@response=Falconide::EmailDetails.new
    end

    describe "EmailDetails test" do
    	it "it is initialized successfully ?" do
    		@response.wont_be_nil
    	end
    end

end