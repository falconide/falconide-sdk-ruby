require './lib/falconide/row'
require 'minitest'
require 'minitest/autorun'

describe "Row" do
    before do
    	@rowdata=Falconide::Row.new
    end

    describe "Row  test" do
    	it "it is initialized successfully ?" do
    		@rowdata.wont_be_nil
    	end
    	it "add value to row and fetch" do
    		@rowdata.addColumnData("t1","value")
    		row=@rowdata.getRowData
    		assert_equal("value",row["t1"],"not same")
    	end
    end

end