
require "./personnage/Personnage"
require "./personnage/Pnj"
require "./personnage/Ennemi"
require "./personnage/Joueur"

require "./carte/Direction"
require "./carte/Coord"
#== Définition des Ennemi non pisteur, hérite de Ennemi
class NonPisteur < Ennemi

	#=== redefinition de initialize
	def initialize(nom,position,arme,protection)
		super(nom,position,arme,protection)
	end

	#=== Constructeur de NonPisteur
	private_class_method :new
	def NonPisteur.creer(nom,position,arme,protection)
		new(nom,position,arme,protection)
	end

	#=== redéfinition du comportement: aléatoire
	def comportement( joueur )
		puts "\n ......... NonPisteur >>> D e p l a c e m e n t .........\n"
		direction=rand(4)
		if(direction==Direction::DROITE)
			@position.coord.coordX=@position.coord.coordX+1
		elsif(direction==Direction::BAS)
			@position.coord.coordY=@position.coord.coordY-1
		elsif(direction==Direction::GAUCHE)
			@position.coord.coordX=@position.coord.coordX-1
		elsif(direction==Direction::HAUT)
			@position.coord.coordY=@position.coord.coordY+1
		else
			puts "repos"
		end
		if(self.position.coord.coordY==joueur.position.coord.coordY)
			self.attaquer(joueur)
		end
	end

	def to_s
		return "nonpisteur"
	end

end