require "pry"
#esta es la clase para los productos sin categoría
class Item
	attr_reader :name, :price, :name_discount, :discount, :porcentaje
	def initialize(name, price)
		@name = name
		@price = price
		@discount = {}
		@name_discount ="+++ sin descuento aplicable +++" #default
		@porcentaje = 0
	end
	#función q permite añadir descuentos en función del volumen de compra
	#el name_discount aparecerá visible junto al producto en el listado de compra para el cliente
	def add_discount(name_discount, percent, condition) #la condición puede ser: 1. integer.volumen_de_compra 2. float.precio 3. string.periodos_de_tiempo 4. array.días 
		@name_discount = "Aplicable un #{name_discount}"
		@porcentaje = percent
		@discount[percent] = condition
	end
	#esta función calcula el precio tras los descuentos
	def prices
		examinador = @discount[@porcentaje]
		if examinador.class == 0.0.class #significa q es un descuento por precio
			if @price >= @discount.values[0]
				@price = @price - (@price * (@discount.keys[0] / 100.00))
			else
				@price
			end
=begin
		elsif examinador.class == 0.class #significa q es un descuento por volumen de compra
>			if volumen_de_compra >= @discount.values[0] 
				@price = @price - (@price * (@discount.keys[0] / 100))
			else
				@price
			end
=end
		elsif examinador.class == "".class 
			if @discount.values[0] == "weekend" #puede crearse nuevos elsif para diferentes periodos: día, mes..
				if Time.now.strftime("%A") == "Saturday" || Time.now.strftime("%A") == "Sunday"
					@price = @price - (@price * (@discount.keys[0] / 100.00))
				else
					@price
				end
			end
		elsif examinador.class == [].class #significa q se aplica a los días definidos
			@discount.values[0] = array_days
			array_days.each do |days|
				if days == Time.now.strftime("%A") #día de hoy
					@price = @price - (@price * (@discount.keys[0] / 100.00))
				else
					@price
				end
			end
		else
			@price
		end
	end
end
#Categoría de productos. Crear estas categorías permite añadir descuentos diferentes
class Houseware < Item
end
class Fruit < Item
end
#la clase cesta o carrito de la compra
class Shoppingcart
	attr_accessor :cart
	def initialize
		@cart = []
		@cost = 0.0
	end
	def add_item(name)
		@cart.push(name)		
	end
	def factura #suma el valor del carrito de compra y aplica descuento
		@cart.each do |item|
#binding.pry #aquí no funciona el método#prices de los productos
			if item == "banana"
				@cost += Fruit.new("Banana", 10.00).prices
			elsif item == "orangejuice"
				@cost += Item.new("Orange Juice", 10.00).prices
			elsif item == "rice"
				@cost += Item.new("Rice", 1).prices
			elsif item == "vacuumcleener"
				@cost += Houseware.new("Vacuum Cleener", 150.00).prices
			elsif item == "anchovies"
				@cost += Item.new("Anchovies", 2.00)
			end
		end
		if @cart.length > 5
			@cost = @cost - (@cost * 0.10) #descuento del 10%
		else
			@cost
		end
	end
end
#clase para la tienda
class Shop
	attr_reader :nombre
	def initialize
		@stock = []		
	end
	def add_to_stock(name) #disponibilidad de productos
		@stock.push(name)
	end
	def storage
		count = 0
		@stock.each do |item|
			count += 1
			puts "|-|  #{count} - \"#{item.name}\" = #{item.price} euros."
			puts "|-|       [ #{item.name_discount} ]\n"
		end
	end
	def buy #proceso de compra
		system("clear")
		2.times do puts " " end
		print "                     \ \|/ /\n                     (O O)\n        +--------oOO--(_)-------------+\n        |  ¡Bienvenid@s a Retro-Shop!  |\n        +-----------------oOO----------+\n                   |__|__|\n                    | | |\n                    ooO Ooo\n"
		puts " "
		puts "  [TU TIENDA ONLINE CON SABOR A VIEJO TERMINAL]"
		puts " "
		sleep 2
		puts ">El siguiente proceso, le permitirá comprar en nuestra tienda.\n>¿Está preparado?"
		response = gets.chomp
		if response.downcase[0] == "s" #|| "y"
			puts " "
			puts ">Lo primero que nos gustaría saber es cómo se llama."
			nombre = gets.chomp
			puts " "
			puts ">Hemos creado un carrito de la compra para usted, #{nombre}."
			nombre.downcase
			nombre = Shoppingcart.new
			puts ">Ahora le mostraremos nuestro catálogo de productos."
			sleep 5
			system ("clear")
			puts " "
			2.times do puts "|-|" end
			storage
			2.times do puts "|-|" end
			puts " "
			puts ">Ya puede elegir los productos que desee."
			puts ">Haga la lista separada por comas, por favor."
			product = gets.chomp
			product_a = product.gsub(" ","") #borramos espacios
			product_b = product_a.gsub(".","") #borramos puntos
			product_c = product_b.gsub("y",",") #cambiamos "y" por ","
			product_array = product_c.downcase.split "," #creamos array_productos
			product_array.each do |cosa|
				nombre.add_item(cosa) #añade el producto al carrito
			end
			your_cart = nombre.cart.join ", " #une el array_productos en un string
			puts " "
			print ">Añadidos al carro: "
			print "#{your_cart}\n"
			puts ">¿Está todo bien?"
			duda = gets.chomp
			duda.downcase
			if duda[0] == "s" #|| "y"				
				factura = nombre.factura
				puts ">El precio de todo asciende a la cantidad de.. #{factura} euros." #llamada al método del carrito para calcular la factura
				puts ">¿Pagará con tarjeta?"
				pago = gets.chomp
				if pago.downcase[0] == "s" #|| "y"
					puts ">Muchas gracias, por comprar en RETROSHOP.ES\n>que tenga un buen día y esperamos verle pronto."
					return
				else
					puts ">Lo sentimos, este es un comercio online.\n>No podemos continuar con el proceso de compra sin una tarjeta de crédito."	
				end
			else
				puts " "
				puts ">Lo sentimos."
				puts ">Indiquenos la incidencia, por favor."
				incidencia = gets.chomp
				IO.write("log.txt", incidencia)
				puts " "
				puts ">Pruebe a visitarnos otro día. En breve, solucionaremos el problema."
				return
			end
		else
			return
		end
	end
end



#Area de comandos
#creación de productos
banana = Fruit.new("Banana", 10.00)
orange_juice = Item.new("Orange Juice", 10.00)
rice = Item.new("Rice", 1)
vacuum_cleener = Houseware.new("Vacuum Cleener", 150.00) 
anchovies = Item.new("Anchovies", 2.00)
#creación de descuentos
#Item.add_discount(name_discount, percent, condition)
banana.add_discount("descuento del 10% sólo los fines de semana", 10, "weekend")
vacuum_cleener.add_discount("descuento del 5%", 5, 100.00)
#creación de un carro de compra
prueba = Shoppingcart.new
#creación de tienda
retro_shop = Shop.new
#añade productos a la tienda
retro_shop.add_to_stock(banana)
retro_shop.add_to_stock(orange_juice)
retro_shop.add_to_stock(rice)
retro_shop.add_to_stock(vacuum_cleener)
retro_shop.add_to_stock(anchovies)
#comando ejecutar compra en tienda
#binding.pry #aquí se puede añadir cosas al carrito de compras "prueba" y comprobar q el método#factura funciona
retro_shop.buy #esto lanza el script de la terminal

#binding.pry