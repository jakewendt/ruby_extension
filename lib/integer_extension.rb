module RubyExtension
module IntegerExtension
	def self.included(base)
		base.extend(ClassMethods)
		base.instance_eval do
			include InstanceMethods
		end
	end

	module ClassMethods
	end

	module InstanceMethods

		def factorial
			f = n = self
			f *= n -= 1 while( n > 1 )
			return f
		end

	end

end
end
Integer.send( :include, RubyExtension::IntegerExtension )
