#require "pry"

class ShakeShop
	def initialize
		@list_of_milkshakes = []
		@milkshakes_menu = {}
	end
	def add_milkshakes(milkshake)
		@list_of_milkshakes.push(milkshake)
	end
	def milkshakes_menu
		@list_of_milkshakes.each do |milkshake|
			@milkshakes_menu[milkshake.name_of_milkshakes] = milkshake.price_of_milkshake
		end
		puts "Enjoy our Milkshake's Menu:"
		number_of_menu = 0
		@milkshakes_menu.each do |nombre, precio|
			number_of_menu += 1
			puts "#{number_of_menu} - #{nombre} = #{precio} €uros."
		end
	end
end

class Milkshake 
	def initialize(name)
		@name = name
		@base_price = 3
		@ingredients = []
	end
	def name_of_milkshakes
		@ingredients_names = ""
		contador = 0
		@ingredients.each do |ingredient|
			contador += 1
			if  contador == 1 
				@ingredients_names = @ingredients_names + ingredient.name.downcase
			elsif contador < @ingredients.length && contador > 1
				@ingredients_names = @ingredients_names  + ", #{ingredient.name.downcase}"
			else
				@ingredients_names = @ingredients_names + " y #{ingredient.name.downcase}"
			end
		end
		@name_whit_ingredients = "Done whit #{@ingredients_names}"
		@name_of_milkshake = "Milkshake: \"#{@name}\" - #{@name_whit_ingredients}"
	end
	def add_ingredient(ingredient)
		@ingredients.push(ingredient)
	end
	def price_of_milkshake
		@total_price_of_milkshake = @base_price
		@ingredients.each do |ingredient|
			@total_price_of_milkshake += ingredient.price
		end
		@total_price_of_milkshake
	end
end

class Ingredient
	attr_reader :name, :price
	def initialize(name, price)
		@name = name
		@price = price
	end
end

#Ingredientes
banana = Ingredient.new("Banana", 2)
chocolats_chips = Ingredient.new("Chocolat's Chips", 1)
chocolat = Ingredient.new("Chocolat", 2)
biscuit = Ingredient.new("Biscuit", 3)
strawberry = Ingredient.new("Strawberry", 4)

#Batidos
#Nizars
nizars_milkshake = Milkshake.new("Nizars")
nizars_milkshake.add_ingredient(banana)
nizars_milkshake.add_ingredient(chocolats_chips)
#Biscuit
biscuit_milkshake = Milkshake.new("Biscuit")
biscuit_milkshake.add_ingredient(chocolat)
biscuit_milkshake.add_ingredient(biscuit)
#Banana
banana_milkshake = Milkshake.new("Banana Split")
banana_milkshake.add_ingredient(banana)
#Strawberry
strawberry_milkshake = Milkshake.new("Strawberry Fields")
strawberry_milkshake.add_ingredient(strawberry)

#Tiendas
josh’s_shake_shack = ShakeShop.new
josh’s_shake_shack.add_milkshakes(nizars_milkshake)
josh’s_shake_shack.add_milkshakes(biscuit_milkshake)
josh’s_shake_shack.add_milkshakes(banana_milkshake)
josh’s_shake_shack.add_milkshakes(strawberry_milkshake)
josh’s_shake_shack.milkshakes_menu


#binding.pry