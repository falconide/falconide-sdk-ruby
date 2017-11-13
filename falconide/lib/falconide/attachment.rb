require "base64"
require "json"
module Falconide
	class Attachment

		def initialize
			@files=Hash.new
			@totalsizeinmb=0
		end
		def addattachment(file)
			fileSizeInBytes = File.size(file)
			fileSizeinKb=(fileSizeInBytes/1024).to_f.round(3)
			fileSizeinMb=(fileSizeinKb/1024).to_f.round(3)
			@totalsizeinmb=@totalsizeinmb+fileSizeinMb
			if(@totalsizeinmb>40)
               raise "The file is too large (max allowed is 40 mb)"
            end
            fileobj = File.open(file, "rb")
			filecontent = fileobj.read
            encodedFile=Base64.encode64(filecontent)
            @files[File.basename(file)]=encodedFile
		end
		def files
			@files
		end

	    def json_r(val)
	       JSON.generate(val)
	    end
	end
 end