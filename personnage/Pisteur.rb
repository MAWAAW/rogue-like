
require "./personnage/Personnage"
require "./personnage/Pnj"
require "./personnage/Ennemi"
require "./personnage/Joueur"
require "./personnage/Allie"

require "./carte/Direction"
require "./carte/Coord"

#=== Définition des ennemis qui suivent le héros
class Pisteur < Ennemi

	#=== redefinition de initialize
	def initialize(nom,position,arme,protection)
		super(nom,position,arme,protection)
	end

	#=== Constructeur de Pisteur
	private_class_method :new
	def Pisteur.creer(nom,position,arme,protection)
		new(nom,position,arme,protection)
	end

	#=== redéfinition du comportement: suiveur
	def comportement( joueur )

		#Coordonnées du joueur relative au pisteur
		x = @position.coord.coordX - joueur.position.coord.coordX
		y = @position.coord.coordY - joueur.position.coord.coordY
		if x == 0 && y == 0
			attaquer(joueur)
		elsif x.abs > y.abs
			if    x > 0 && seDeplacer( Direction::GAUCHE )
			elsif x < 0 && seDeplacer( Direction::DROITE )
			elsif y > 0 && seDeplacer( Direction::HAUT )
			elsif y < 0 && seDeplacer( Direction::BAS )
			else  seDeplacer( rand( 1..4 ) )
			end
		else
			if    y > 0 && seDeplacer( Direction::HAUT )
			elsif y < 0 && seDeplacer( Direction::BAS )
			elsif x > 0 && seDeplacer( Direction::GAUCHE )
			elsif x < 0 && seDeplacer( Direction::DROITE )
			else  seDeplacer( rand( 1..4 ) )
			end
		end

		#Calcul des nouvelle coordonnées
		x = @position.coord.coordX - joueur.position.coord.coordX
		y = @position.coord.coordY - joueur.position.coord.coordY
		if x == 0 && y == 0
			attaquer(joueur)
		end
	end

	def to_s
		return "pisteur"
	end

end