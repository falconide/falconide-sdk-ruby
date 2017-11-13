require 'json'
module Falconide
	class Table
		def initialize
			@tablelist=Array.new
		end
		def addrow(row)
			@tablelist.push(row)
		end
		def getTable
			@tablelist
		end

		def self.my_hash(obj)
	       hash = {}
	       obj.instance_variables.each {|var|
            value=obj.instance_variable_get(var)
            if(value.instance_of?Array)
              value.each{|row|
            	if(row.instance_of?Falconide::Row)
                 hash = row.getRowData
                end
              }
	       	end
	       	}
	       hash
	    end

	    def json_r(val)
	       JSON.generate(val)
	    end
	end
end