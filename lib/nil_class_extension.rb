module RubyExtension
module NilClassExtension
	def self.included(base)
		base.extend(ClassMethods)
		base.instance_eval do
			include InstanceMethods
		end
	end

	module ClassMethods
	end

	module InstanceMethods

		def split(*args)
			[]
		end

	end

end
end
NilClass.send( :include, RubyExtension::NilClassExtension )
