
require './carte/Case.rb'
require './carte/Coord.rb'
require './carte/TypeCase.rb'
#== Génération de la carte 
class Carte
	@carte
	@hauteur
	@largeur
	@difficulte
	@listeType

	attr_reader :hauteur, :largeur, :difficulte, :carte

	private_class_method :new
	def Carte.generer( haut, larg, difficulte )
		new( haut, larg, difficulte )
	end

	def initialize( haut, larg, difficulte )
		@hauteur   = haut
		@largeur   = larg
		@nbCases   = @hauteur * @largeur
		@listeType = [
			TypeCase.nouveau( "herbe",    4, 1, 0.00,  0 ),
			TypeCase.nouveau( "eau",      1, 9, 0.20, 64 ),
			TypeCase.nouveau( "desert",   1, 4, 0.30, 99 ),
			TypeCase.nouveau( "montagne", 3, 4, 0.20,  8 )
		]
		@carte     = Array.new(@hauteur) do |i|
			Array.new(@largeur) do |j|
				Case.creerVide( @listeType[0], rand(4), i, j, self )
			end
		end

		#=== methode récursive pour l'expansion d'une zone
		def recExpand( pos, type, nb )
			if pos.type == @listeType[0] && nb < type.aggMax
				pos.type       = type
				pos.variation  = rand(type.variation)
				nb+= 1
				1.upto(4) do |x|
					nb = recExpand( pos.voisine( rand 4 ), type, nb )
				end
			end
			return nb
		end

		@listeType.each do |x|
			nb = 0
			while nb < x.pourcent * @nbCases do
				nb+=recExpand( @carte[rand(@largeur)][rand(@hauteur)],x,0 )
			end
		end

	end

	#=== Renvoie une matrice de la taille voulue correspondant à la vue du joueur
	def vueJoueur(caseJoueur,taille)

		#Calcul des coordonn�es � afficher
		depX = caseJoueur.coord.coordX - taille/2
		depY = caseJoueur.coord.coordY - taille/2

		#Remplissage de la variable de sortie
		return Array.new(taille) do |x|
			Array.new(taille) do |y|
				getCase( depX+x, depY+y )
			end
		end

	end
  #=== Accesseur en lecture d'une case
	def getCase(x,y)
		x += @largeur if( x < 0 )
		x -= @largeur if( x >= @largeur )
		y += @hauteur if( y < 0 )
		y -= @hauteur if( y >= @hauteur )
		return @carte[x][y]
	end

end