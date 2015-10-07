require "pry"
#encoding: utf-8

def descifrado(mensaje, clav)
	result = []
	minus = mensaje.downcase
	minus.each_char do |c|
		if c =~ /\W/
			result.push c
		else
			if clav == ""
				ref = c.ord
				new_ref = ref - 3
				if new_ref < 97
					renew_ref = 123 - (97 - new_ref)
					result.push renew_ref.chr
				else
					result.push new_ref.chr
				end
			else
				ref = c.ord
				new_ref = ref + clav.to_i
				if new_ref < 97
					renew_ref = 123 - (97 - new_ref)
					result.push renew_ref.chr
				elsif new_ref > 122
					ciclos = clav.to_i / 26
					renew_ref = new_ref - 26
					result.push renew_ref.chr
				else
					result.push new_ref.chr
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
until clave.to_i <= 26 && clave.to_i >= -26 
	puts "Tenemos un límite de +-26.\nIntroduce otro valor."
	clave = gets.chomp
end

puts descifrado(mensaje_cifrado,clave).capitalize
#binding.pry