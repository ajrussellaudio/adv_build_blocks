class Array

	def bubble_sort(array)
		for pass in 1..array.length
			array.each_with_index do |item, i|
				if array[i+1] && array[i] > array[i+1]
					array.swap_items(i)
				end
			end
		end
		array
	end

	def swap_items(i)
		self[i], self[i+1] = self[i+1], self[i]
	end

end