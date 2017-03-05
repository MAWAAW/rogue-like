
require "./personnage/Personnage.rb"
require "./personnage/Pnj.rb"
require "./personnage/Allie.rb"

#== classe concrete : Allie
class Guerisseur < Allie

	#=== Les guerisseurs soigne le joueur contre de l'or
	def action( joueur )
		if joueur.or >= 60
			joueur.or -= 60
			joueur.pointsDeVie=joueur.pointsDeVieMax
			@or += 60
		end
	end

	#=== communication (affichage) avec le joueur
	def actionNom
		return "Se faire soigner (60or)"
	end

	def to_s
		return "allie"
	end

end



