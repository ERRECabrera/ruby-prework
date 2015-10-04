require "pry"
serie =[]
count = 0
serie.push count +=1 until count == 100
#binding.pry	
serie.each do |number|
	bang = number.to_s
	print "#{number}" if number % 3 != 0 && number % 5 != 0 && bang !~ /\A[1]/
	print "Fizz" if number % 3 == 0
	print "Buzz" if number % 5 == 0
	print "Bang" if bang =~ /\A[1]/
	print "\n"
end