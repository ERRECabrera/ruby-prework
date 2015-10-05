#require "pry"
def split_sortab (e)
	e_splited = e.split " "
	result = []
	e_splited.each do |word|
		result.push word.gsub(/\W/, "")
	end
	result.sort
end
puts "Write a sentence:"
sentence = gets.chomp
print split_sortab(sentence)
print "\n"
#binding.pry