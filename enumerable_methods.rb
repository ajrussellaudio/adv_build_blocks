module Enumerable

	def my_each
		return enum_for(:my_each) unless block_given?
		array = self.to_a
		n = array.length
		for i in 0...n
			yield(array[i])
		end
		return array
	end

	def my_each_with_index
		return enum_for(:my_each_with_index) unless block_given?
		array = self.to_a
		n = array.length
		for i in 0...n
			yield(array[i], i)
		end
		return array
	end

	def my_select
		return enum_for(:my_select) unless block_given?
		selected = [ ]
		self.my_each do |item|
			is_selected = yield(item)
			selected << item if is_selected
		end
		return selected
	end

	def my_all?
		state = true
		self.my_each do |item|
			# if block is given and block evaluates not true,
			# or if block is not given and item is not true (truthy)
			if (block_given? && !yield(item)) || (!block_given? && !item)
				# then array.my_all? state is false
				state = false
				break
			end
		end
		return state
	end

	def my_any?
		state = false
		self.my_each do |item|
			# if block is given and block evaluates true,
			# or if block is not given and item is true (truthy)
			if (block_given? && yield(item)) || (!block_given? && item)
				# then array.my_any? state is true
				state = true
				break
			end
		end
		return state
	end

	def my_none?
		state = true
		self.my_each do |item|
			# if block is given and block evaluates true,
			# or if block is not given and item is true (truthy)
			if (block_given? && yield(item)) || (!block_given? && item)
				# then array.my_none? state is false
				state = false
				break
			end
		end
		return state
	end

	def my_count(*arg)
		raise ArgumentError if arg.length > 1
		match = arg.first

		count = 0
		self.my_each do |item|
			if (!block_given? && !match || item == match) || (block_given? && yield(item))
				count += 1
			end
		end
		return count
	end

	def my_map(input_proc)
		# return enum_for(:my_map) unless block_given?
		array = self.to_a
		output = []
		array.my_each do |item| 
			if block_given? 
				output << yield(input_proc.call(item))
			else
				output << input_proc.call(item)
			end
		end
		return output
	end

	def my_inject(*args)
		array = self.to_a

		if args.length > 2
			raise ArgumentError # .new("Wrong number of arguments: #{args.length} for 2")
		elsif args.length == 2
			initial = args.first
			sym = args.last
		elsif args.length == 1 && args.first.class == Symbol
			initial = nil
			sym = args.first
		elsif args.length == 1
			initial = args.first
			sym = nil
		else
			initial = nil
			sym = nil
		end
		
		if initial == nil
			memo = array.first
			steps = (1...array.length).to_a
		else
			memo = initial
			steps = (0...array.length).to_a
		end
		
		if sym == nil
			task = lambda { |memo, obj| yield(memo, obj) }
		else
			task = lambda { |memo, obj| memo.send(sym, obj) }
		end
		
		steps.my_each do |index|
			memo = task.call(memo, array[index])
		end

		return memo
	end

	# unmodified!
	# def my_map
	# 	return enum_for(:my_map) unless block_given?
	# 	array = self.to_a
	# 	output = []
	# 	array.my_each { |item| output << yield(item) }
	# 	return output
	# end

end

def multiply_els(array)
	array.my_inject(1, :*)
end








