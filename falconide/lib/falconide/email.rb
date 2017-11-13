require 'json'
module Falconide
	class Email
        def initialize
            @recipients=Array.new
            @metadatalist=Array.new
            @files=Falconide::Attachment.new
            @attributes=Hash.new
            @recipients_cc=Array.new
            @recipients_cc_xapi=Array.new
            isprocessingdone=false
            @xapiheaders=Array.new
            @trigdata=Array.new
        end
		def  api_key
			@api_key
		end

		def  setApiKey(apikey)
			@api_key=apikey
		end

		def  setemaildetails(emaildetails)
			raise "invalid emaildetails " unless emaildetails.instance_of? Falconide::EmailDetails
			@email_details=emaildetails
		end

        def setSettings(settings)
			raise "invalid setttings " unless settings.instance_of? Falconide::Settings
		    @settings=settings
        end

		def setEmailContent(content)
            @email_details.content=content
		end

		def setFrom(from)
			@email_details.from=from
		end

		def setFromName(fromname)
			@email_details.fromname=fromname
		end

		def setReplyToId(replytoid)
			@email_details.replytoid=replytoid
		end

		def setSubject(subject)
			@email_details.subject=subject
		end

		def clearTemplates()
			@settings.setTemplate=nil;
		end

		def addFooter()
			@settings.footer="1";
		end

		def removeFooter()
			@settings.footer="0";
		end

		def enableClickTrack()
			@settings.clicktrack="1";
		end

		def disableClickTrack()
			@settings.clicktrack="0";
		end

		def enableOpenTrack()
			@settings.opentrack="1";

		end

		def disableOpenTrack()
			@settings.opentrack="0";
		end

		def setBcc(bcc)
			@settings.bcc=bcc;
		end

		def clearBcc()
			@settings.bcc=nil;
		end

		def enableUnsubscribe()
			@settings.unsubscribe="1"
		end

		def disableUnsubscribe()
			@settings.unsubscribe="0";
		end

		def setAttachmentsIds(idsCommaSeparated)
			@settings.attachmentid=idsCommaSeparated;
		end

		def clearAttachmentsIds()
			@settings.attachmentid=nil;
		end
        def addrecipient(emailid, metadata)
        	@recipients.push(emailid)

        	if !metadata.nil?
        		@metadatalist.push(metadata)
        	end
        end
        def recipients
        	@recipients
        end
        def clearRecipients
        	@recipients=null
        end
		def addAttachmentId(id)
           if @settings.attachmentid.nil?
			   @settings.attachmentid= "" + id
           else
			   @settings.attachmentid= @settings.attachmentid + "," + id
           end
		end
		def addAttachment(file)
			@files.addattachment(file)
		end
		def isAnyAttachmentAvailable
			 if( @files.files && @files.files.length >0 )
			 	return true
			 end
			 return false
		end

        def validate
	        if (@email_details.nil?)
				raise Falconide::ValidationError.new("EmailDetails obj is not initialize"),"email: email details"
			end
			if (@email_details.content.nil?)
				raise Falconide::ValidationError.new("Content is null"), "email: email contents"
			end

			if (@email_details.from.nil? or @email_details.subject.nil?)
				raise Falconide::ValidationError.new("EmailDetails obj attributes form and subject not initialize"),"email: email details"
			end
			if (@recipients.nil? or @recipients.length==0)
				raise Falconide::ValidationError.new("recipients found null"),"email:"
			end
        end
        def processEmail
            count=0
            @recipients.each{   |recipient|
               data=@metadatalist[count]
               if(!data.substitute.nil?)
                   data.substitute.keys.each {|key|
                   	 if (!@attributes[key].nil?)
                   	 	@attributes[key].push(data.substitute[key])
                   	 else
                   	 	vals=Array.new
                   	  	vals.push(data.substitute[key])
                   	  	@attributes[key]=vals
                   	 end

                   }
               end
               if(!data.xapiheader.nil?)
               	  @xapiheaders.push(data.xapiheader)
               else
               	  @xapiheaders.push("")
               end
               if(!data.getrecipientCcs.nil?)
	               	str = ""
					data.getrecipientCcs.each{|recipt|
						str = str + recipt + ",";
					}
					str = str[0, str.length() - 1];
					@recipients_cc.push(str)
               end
               if(!data.getrecipientCCsXapis.nil?)
                   str=""
                   data.getrecipientCCsXapis.each{|xapi|
                    	str = str + xapi + ",";
                   }
                    str = str[0, str.length() - 1];
					@recipients_cc_xapi.push(str)
               end
               if(!data.trigdata.nil?)
                  @trigdata.push(data.trigdata)
               end
               count=count+1
             }
           isprocessingdone=true
        end

        def opendedit
        	@isprocessingdone=false
        end
        def getattributes
        	@attributes
        end
        def getxapiheaders
        	@xapiheaders
        end
        def getrecipientsccxapi
        	@recipients_cc_xapi
        end
		def self.my_hash(obj)
           hash = {}

           obj.instance_variables.sort.each {|var|
           value=obj.instance_variable_get(var)

           if(value.instance_of?Falconide::EmailDetails)
           	   altVal=Falconide::EmailDetails.my_hash(value)
           	   hash[var.to_s.delete('@')] = altVal
           elsif(var.to_s.eql?"@metadatalist")
           	    listOfMetadata=Array.new
           	    value.each { |meta|
                 if(meta.instance_of?Falconide::MetaData)
                  listOfMetadata.push(Falconide::MetaData.my_hash(meta))
                 end
           	    }
           	    hash[var.to_s.delete('@')] = listOfMetadata
           elsif(value.instance_of?Falconide::Attachment)
           	   altVal=value.files
           	   if(!altVal.empty?)
           	     hash[var.to_s.delete('@')] = altVal
           	   end
           elsif(value.instance_of?Falconide::Settings)
           	   altVal=Falconide::Settings.my_hash(value)
           	   hash[var.to_s.delete('@')] = altVal
           else
           	   hash[var.to_s.delete('@')] = value
           end
           }
           hash
           hash.delete("metadatalist")
           hash.delete("xapiheaders")
           hash.delete("recipients_cc_xapi")
           trigdata=hash["trigdata"]
           hash["trigdata"]=processtrigdata(trigdata)
           hash
        end

        def json_r(val)
           #JSON.pretty_generate(val)

           JSON.pretty_generate(val)
        end

        def self.processtrigdata(trigd)
           trigd.each {|data|
           	tableMap=data
           	if(!tableMap.nil?)
              tableMap.keys.sort.each {|table|
              	tableobj=tableMap[table]
              	if(tableobj.instance_of?Falconide::Table)
              		tableMap[table]=Array.new.push(Falconide::Table.my_hash(tableobj))
              	end
              }
           	end
           }
           return trigd
        end
 	end

end