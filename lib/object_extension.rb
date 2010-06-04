module RubyExtension	#	:nodoc:
module ObjectExtension
	def self.included(base)
#		base.extend(ClassMethods)
		base.instance_eval do
			include InstanceMethods
		end
	end

#	module ClassMethods	#	:nodoc:
#	end

	module InstanceMethods

		def to_boolean
		end

	end

end
end
Object.send(:include, RubyExtension::ObjectExtension)
