
require "./carte/Case.rb"
require "./carte/Direction.rb"
require "./carte/TypeCase.rb"

#== classe mere de tous les personnages (Joueur et PNJ): abstract class
class Personnage
	@pointsDeVie
	@pointsDeVieMax
	@position
	@nom
	@or

	attr_accessor :pointsDeVie, :pointsDeVieMax, :position, :nom, :or

	#=== redéfinition de initialize(String,Case)
	def initialize(nom,position)
		@nom            = nom
		@pointsDeVie    = 100
		@pointsDeVieMax = 100
		@position       = position
		@or             = 100
	end

	#=== Constructeur d'un personnage
	private_class_method :new
	def Personnage.creer(nom,position)
		new(nom,position)
	end

	def seDeplacer( direction )
		tmp = @position.voisine( direction )
		unless tmp.pnj || tmp.type != @position.type
			tmp.pnj = @position.pnj
			@position.pnj = nil
			@position = tmp
			return true
		end
		return false
	end

	#=== affichage d'un personnage
	def to_s
		"Nom: #{@nom} Pv: #{@pointsDeVie} Or: #{@argent} Position: #{@position} "
	end
end



