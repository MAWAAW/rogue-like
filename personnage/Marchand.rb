
require "./personnage/Personnage.rb"
require "./personnage/Pnj.rb"
require "./personnage/Allie.rb"

#== classe concrete : Allie
class Marchand < Allie

	#=== Les marchand vendent des potions
	def action( joueur )
		if joueur.or >= 100
			joueur.or -= 100
			@or += 100
			joueur.inventaire.ajout(Consomable.creer("Potion de vie",80,2,99,0))
		end
	end
	
	#=== communication (affichage) avec le joueur
	def actionNom
		return "Acheter potion (100or)"
	end

	def to_s
		return "allie"
	end

end



