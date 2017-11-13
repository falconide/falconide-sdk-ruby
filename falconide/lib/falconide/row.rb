require 'json'
module Falconide
	class Row
		def initialize
			@rowdata=Hash.new
		end

		def addColumnData(colname,value)
			@rowdata[colname]=value
		end
		def clearColumnData(colname)
			@rowdata[colname]=nil
		end

		def getRowData
			@rowdata
		end

	    def json_r(val)
	       JSON.generate(val)
	    end
	end

end
