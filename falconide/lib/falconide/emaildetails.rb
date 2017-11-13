require 'json'

module Falconide
  class EmailDetails
    attr_accessor :fromname, :subject, :from, :replytoid, :content

    def self.my_hash(obj)
         hash = {}
         obj.instance_variables.sort.each {|var| hash[var.to_s.delete('@')] = obj.instance_variable_get(var) }
         hash
    end

    def json_r(val)
       JSON.generate(val)
    end

  end

end