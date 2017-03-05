
require "./personnage/Personnage.rb"
require "./personnage/Pnj.rb"

#== classe abstraite : Allie hérite de Pnj
class Allie < Pnj

	#=== methode abstraite redéfinis dans guerrisseur et marchant
	def action( joueur )
		#ABSTRAIT
	end

	#=== renvoi un string pour l'affichage avec le joueur
	def actionNom
		return "Je sais rien faire :C"
	end

	def to_s
		return "allie"
	end

end



