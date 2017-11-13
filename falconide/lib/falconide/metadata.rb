require 'json'
module Falconide
	class MetaData

        def initialize
           @attributes=Hash.new
           @recipientCcs = Array.new
		   @recipientCCsXapis = Array.new
		   @trigdata=Hash.new
        end

		def xapiheader
			@xapiheader
		end

		def setxapiheader(header)
			@xapiheader=header
		end

        def addCC(ccEmail, ccxApi)
			if (@recipientCcs == nil)
				@recipientCcs = Array.new
				@recipientCCsXapis = Array.new

			end
   			 if (ccEmail != nil)
				@recipientCcs.push(ccEmail)
			 end
			 if (ccxApi != nil)
				@recipientCCsXapis.push(ccxApi)
			 end
        end

	    def  recipientCcs(index)
	    	@recipientCcs[index]
	    end

	    def  recipientCCsXapis(index)
            @recipientCCsXapis[index]
	    end
	    def  getrecipientCcs
	    	@recipientCcs
	    end

	    def  getrecipientCCsXapis
            @recipientCCsXapis
	    end

        def addSubstitue(key,value)
        	@attributes[key]=value
        end
        def substitute
        	@attributes
        end
        def createTable(varname,table)
        	@trigdata[varname]=table
        end
        def trigdata
        	@trigdata
        end
        def cleartable(varname)
        	if !trigdata.nil?
        		trigdata[varname]=nil
            end
        end
        def clearAlltable(varname)
        	if !trigdata.nil?
        		trigdata.clear
            end
        end
        def self.my_hash(obj)
           hash = {}
           obj.instance_variables.each {|var|
           hash[var.to_s.delete('@')] = obj.instance_variable_get(var) }
           hash
        end

        def json_r(val)
           JSON.generate(val)
        end
	end
end
