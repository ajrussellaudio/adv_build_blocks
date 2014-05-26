module Enumerable
	def my_each
		array = self
		n = self.length
		for i in 0...n
			yield(array[i])
		end
		array
	end

end