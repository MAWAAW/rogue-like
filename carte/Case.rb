
require './carte/Coord.rb'
#== Définition d'une case
class Case
	@type
	@variation
	@coord
	@objet
	@pnj
	@carte

	attr_accessor :objet, :pnj, :type, :variation
	attr_reader   :coord, :carte

	private_class_method :new
	#== Constructeur de case
	def Case.creerVide( type, var, x, y, carte )
		new( type, var, x, y, carte )
	end
	#== redéfinition de initialize
	def initialize( type, var, x, y, carte )
		@type      = type
		@variation = var
		@objet     = nil
		@pnj       = nil
		@coord     = Coord.creer(x,y)
		@carte     = carte
	end
  #=== retourne la case d'arrivée du joueur en fonction de sa direction
	def voisine( d )
		case d
			when Direction::REPOS
				return self
			when Direction::HAUT
				return @carte.getCase( @coord.coordX, @coord.coordY-1 )
			when Direction::DROITE
				return @carte.getCase( @coord.coordX+1, @coord.coordY )
			when Direction::BAS
				return @carte.getCase( @coord.coordX, @coord.coordY+1 )
			when Direction::GAUCHE
				return @carte.getCase( @coord.coordX-1, @coord.coordY )
		end
	end
  #=== effectue une action (ramasser obj / parler à un allié)
	def action( joueur )
		if @objet
			joueur.inventaire.ajout( @objet )
			@objet = nil
		elsif @pnj
			@pnj.action( joueur )
		end
	end

	#== affichage de la case
	def to_s
		return @type.nom
	end

end
