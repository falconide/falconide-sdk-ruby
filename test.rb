require 'falconide'
class Test

 begin
    	email=Falconide::Email.new
 	email.setApiKey("<API key>") #Unique Api Key
 	email.setemaildetails(Falconide::EmailDetails.new)
 	email.setEmailContent("<Email Content>"); #Set Email Content
	email.setFrom("<From Address>"); #Set From Address
	email.setFromName("<FromnName>"); #Set From Address
	email.setReplyToId("<EmailID>"); #Setid to be sent 
	email.setSubject("Falcon Ruby SDK - Sample Email 0.2"); #Set Subject of the mail
	email.setSettings(Falconide::Settings.new)
	metadata=Falconide::MetaData.new
	email.addrecipient("<Recipient Email Address>", metadata); # Set emailid to be sent
	email.enableClickTrack();
	email.enableOpenTrack();
	email.addFooter();
	#email.addAttachment("test.pdf")  #to add attachment
	#email.addAttachmentId("1")      
    	#email.addAttachmentId("2")
    	#email.processEmail();
    	Falconide::send(email)
    	response=Falconide::response
end
end
