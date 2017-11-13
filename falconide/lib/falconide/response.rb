require 'json'
module Falconide
 class Response

  attr_accessor :code, :success, :message

	def initialize(code,message)
   	   @code=code
   		 @success=code==200
   		 @message=message
   	end
    def  json_r
    	 my_hash={:code =>self.code, :success => self.success , :message => self.message}
		  JSON.generate(my_hash)
    end
 end
end