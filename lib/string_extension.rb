module RubyExtension
module StringExtension
  def self.included(base)
    base.extend(ClassMethods)
    base.instance_eval do
      include InstanceMethods
    end
  end

  module ClassMethods
  end

  module InstanceMethods

		def to_params_hash
			h = HashWithIndifferentAccess.new
			self.split('&').each do |p|
				(k,v) = p.split('=',2)
				h[k] = URI.decode(v)
			end
			return h
		end

		def uniq
			self
		end

  end

end
end
String.send( :include, RubyExtension::StringExtension )
