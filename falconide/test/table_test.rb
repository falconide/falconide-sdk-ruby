require './lib/falconide/row'
require './lib/falconide/table'
require 'minitest'
require 'minitest/autorun'

describe "Table" do
    before do
    	@rowdata=Falconide::Row.new
        @rowdata.addColumnData("r1","v1")
        @rowdata.addColumnData("r2","v2")
        @table=Falconide::Table.new
        @table.addrow(@rowdata)
    end

    describe "Table test" do
    	it "it is initialized successfully ?" do
    		@table.wont_be_nil
    	end
    	it "fetch row" do
           @t1=@table.getTable
           assert_equal(1,@t1.length,"not same")
           @row=@t1[0]
           @data= @row.getRowData
           assert_equal("v1",@data["r1"], "not same")
    	end
    end

end