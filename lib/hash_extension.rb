module RubyExtension
module HashExtension
	def self.included(base)
		base.extend(ClassMethods)
		base.instance_eval do
			include InstanceMethods
		end
	end

	module ClassMethods
	end

	module InstanceMethods

		def delete_keys_matching!(regex)
			self.keys.each do |k| 
				if k.to_s =~ Regexp.new(regex)
					self.delete(k)
				end 
			end 
			self
		end 

		def delete_keys!(*keys)
			keys.each do |k| 
				self.delete(k)
			end 
			self
		end 

	end

end
end
Hash.send( :include, RubyExtension::HashExtension )
#HashWithIndifferentAccess.send( :include, HashExtension )
