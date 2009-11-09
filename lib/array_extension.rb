module RubyExtension
module ArrayExtension
	def self.included(base)
		base.extend(ClassMethods)
		base.instance_eval do
			include InstanceMethods
		end
	end

	module ClassMethods
	end

	module InstanceMethods

		#	['a','b','c'].arrange([2,0,1]) => ['c','a','b']
		def arrange(new_array_index=[])
			new_array = self.dup
			new_array_index.each_with_index do |index,new_index|
				new_array[new_index] = self[index]
			end
			new_array
		end 

		def drop_blanks!
			delete_if{|a|a.blank?}
		end

		def capitalize
			collect(&:capitalize)
		end

		def capitalize!
			each_with_index do |element,index|
				self[index] = element.capitalize
			end
			self
		end

		def downcase
			collect(&:downcase)
		end

		def average
			if self.length > 0
				#	sum defined in activesupport/lib/active_support/core_ext/enumerable.rb
				self.digitize.sum.to_f / self.length
			else
				nil
			end
		end

		def median
			if self.length > 0
				sorted_values = self.digitize.sort
				length = sorted_values.length
				if length.odd?
					sorted_values[length/2]
				else
					( sorted_values[length/2] + sorted_values[-1+length/2] ).to_f / 2
				end
			else
				nil
			end
		end

		def swap_indexes(i,j)
			new_array = self.dup
			new_array[i],new_array[j] = self[j],self[i]
			new_array
		end

		def swap_indexes!(i,j)
			self[i],self[j] = self[j],self[i]
			self
		end

		def numericize
			collect(&:to_f)
		end
		alias_method :digitize, :numericize

	end
end
end
Array.send(:include, RubyExtension::ArrayExtension)
