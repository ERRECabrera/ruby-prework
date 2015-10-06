#require "pry"
#encoding: utf-8

def descifrado(mensaje, clav)
	abc = "a".upto("z").to_a
	result = []
	mensaje.downcase
	mensaje.each_char do |c|
		if c =~ /\W/
			result.push c
		else
			if clav == ""
				indice = abc.index c
				new_index = indice - 3
				if new_index < 0
					result.push abc.at(new_index)
				else
					result.push abc.at(new_index)
				end
			else
				indice = abc.index c
				new_index = indice + clav.to_i
				if new_index < 0
					result.push abc.at(new_index)
				elsif new_index > abc.length
					renew_index = new_index - 26
					result.push abc.at(renew_index)
				else
					result.push abc.at(new_index)
				end
			end			
		end
	end
	result.to_s
	result.join
end

puts "Escriba el mensaje a descifrar:"
mensaje_cifrado = gets.chomp
puts "Indique la clave numérica:\n(-3, por defecto)"
clave = gets.chomp
until clave =~ /[-+]\d{1,}/ || clave == ""
	puts "Por favor, indique la clave numérica con el formato + ó - seguido de un número:\nSi la deja en blanco será -3 por defecto"
	clave = gets.chomp
end
puts descifrado(mensaje_cifrado,clave).capitalize
#binding.pry