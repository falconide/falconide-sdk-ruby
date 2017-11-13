require 'json'
module Falconide
    class Settings

      attr_accessor :footer, :clicktrack, :opentrack, :unsubscribe, :bcc , :attachmentid, :template

      def self.my_hash(obj)
         hash = {}
         obj.instance_variables.each {|var| hash[var.to_s.delete('@')] = obj.instance_variable_get(var) }
         hash
      end

      def json_r(val)
       JSON.generate(val)
      end
    end
end