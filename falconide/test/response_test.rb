require './lib/falconide/response'
require 'minitest'
require 'minitest/autorun'

describe "Response" do
    before do
    	@response=Falconide::Response.new(0,"test")
    	@response_success=Falconide::Response.new(200,"Success")
    end

    describe "Response test" do
    	it "it is initialized successfully ?" do
    		@response.wont_be_nil
    	end

    	it "response is not success ?" do
    		assert(@response.success==false,"Response is successful")
        end
    end

    describe  "Success Response Test" do
    	it "has initialized sucessfully?" do
    		@response_success.wont_be_nil
    	end

    	it "has success message ?" do
    		assert_equal("Success",@response_success.message,"Message is not success")
        end
    end
end
