def bubble_sort(array)
	n = array.length
	swapped = true
	until !swapped do
		swapped = false
		for i in 1...n do
			# if this pair is out of order
			if array[i-1] > array[i]
				# swap them and remember something changed
				array[i-1], array[i] = array[i], array[i-1]
				swapped = true
			end
		end
	end
	array
end

def bubble_sort_by(array)
	n = array.length
	swapped = true
	until !swapped do
		swapped = false
		for i in 1...n do
			sort = yield(array[i-1], array[i])
			if sort < 0
				array[i-1], array[i] = array[i], array[i-1]
				swapped = true
			end
		end
	end
	array	
end

