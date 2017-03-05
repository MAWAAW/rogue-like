
require "./personnage/Personnage.rb"
require "./personnage/Pnj.rb"

#== Ennemi: abstract class hérite de Pnj
class Ennemi < Pnj
	@arme
	@protection

	#=== accesseurs en lecture
	def getArme()
		return @arme
	end

	def getProtection
		return @protection
	end

	#=== redefinition de initialize(String,Case,Arme,Protection)
	def initialize(nom,position,arme,protection)
		super(nom,position)
		@arme=arme
		@protection=protection
	end

	#=== Constructeur de Ennemi
	private_class_method :new
	def Ennemi.creer(nom,position,arme,protection)
		new(nom,position,arme,protection)
	end

	#=== affichage de Ennemi
	def to_s
		super()+"Arme: #{@arme} Protection: #{@protection}\n"
	end

	#=== Combat : Lorsque le joueur et l'ennemi sont sur la meme case
	def attaquer(joueur)
		# combat jusqu'a la mort du joueur ou de l'ennemi
		while(joueur.pointsDeVie>0 && self.pointsDeVie>0)
			@pointsDeVie-= joueur.arme.puissance / @protection.puissance
			joueur.pointsDeVie-= @arme.puissance / joueur.protection.puissance
		end
		# si l'ennemi est mort avant le joueur
		if( joueur.pointsDeVie > 0 )
			joueur.or += @or
			joueur.incScore( @or+@arme.puissance+@protection.puissance )
			meurt
		end
	end

  #=== methode pour faire mourrir l'Ennemi
	def meurt()
		self.position.pnj=nil
	end
	
	def actionNom
	  return "Attaquer"
	end

end



