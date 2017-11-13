require './lib/falconide/email'
require './lib/falconide/emaildetails'
require 'minitest'
require 'minitest/autorun'

describe "Email" do
    before do
    	@email=Falconide::Email.new
    end

    describe "Email object construct test" do
    	it "is the email details set properly ?" do
    		@email.setemaildetails(Falconide::EmailDetails.new).wont_be_nil
    	end
    end

end