require File.expand_path("../falconide/version", __FILE__)
require File.expand_path("../falconide/response", __FILE__)
require File.expand_path("../falconide/emaildetails", __FILE__)
require File.expand_path("../falconide/settings", __FILE__)
require File.expand_path("../falconide/email", __FILE__)
require File.expand_path("../falconide/row", __FILE__)
require File.expand_path("../falconide/table", __FILE__)
require File.expand_path("../falconide/metadata", __FILE__)
require File.expand_path("../falconide/attachment", __FILE__)
require File.expand_path("../falconide/validationerror", __FILE__)

module Falconide

	require 'net/http'
    require 'openssl'

     OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

     attr_accessor :api_key
     attr_reader   :app_uri, :endpoint

     def HttpClient_post(body)
         client=HttpClient.new
         return client.post(api_uri+endpoint,body)
     end

     def version
     	Falconide::VERSION
     end

     def api_uri
     	api_uri="https://api.falconide.com"
     end

     def endpoint
        endpoint="/falconapi/web.send.json"
     end

     def send(email)
     	if(email.nil?)
     		raise Falconide::validationerror.new("Email object cannot be null")
        end

        if(Falconide::api_key.to_s.nil?)
        	raise Falconide::validationerror.new("API Key cannot be null")
        end
       #convert the objects as per the request
       email.processEmail
       email.validate
       emaildata=Falconide::Email.my_hash(email)
        if(!email.getxapiheaders.nil? && email.getxapiheaders.length > 0)
             emaildetails=emaildata["email_details"]
             emaildetails["X-APIHEADER"]=email.getxapiheaders
             emaildata["email_details"]=emaildetails
        end
        if (!email.getrecipientsccxapi.nil? && email.getrecipientsccxapi.length > 0)
        	 emaildata["X-APIHEADER_CC"]=email.getrecipientsccxapi
		end
		if(email.isAnyAttachmentAvailable)
             emaildata["encoding_type"]="base64"
		end
		json_request=email.json_r(emaildata)
		puts json_request
        body="data="+json_request.to_s
        puts  "sending email"
        uri = URI(Falconide::api_uri+Falconide::endpoint)
        req = Net::HTTP::Post.new(uri.request_uri,initheader={'Content-Type' => 'application/x-www-form-urlencoded'})
        req.body="data="+json_request.to_s
        @res = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
              http.verify_mode = OpenSSL::SSL::VERIFY_NONE
			  http.ssl_version = :SSLv3
			  http.request req
		      end
		puts @res.body
     end
     def response
     	if(@res.nil?)
     		@response=nil
     	else
     	    @response=Falconide::Response.new(@res.code,@res.body)
        end
        @response
     end

    module_function :api_uri, :endpoint, :send, :version, :HttpClient_post, :api_key=, :api_key, :response

end
