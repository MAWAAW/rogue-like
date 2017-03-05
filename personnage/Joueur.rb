
require "./personnage/Personnage"

require "./carte/Carte"
require "./carte/Case"
require "./carte/Coord"

require "./inventaire/Inventaire"
require "./inventaire/Objet"
require "./inventaire/Consomable"
require "./inventaire/Equipement"
require "./inventaire/Arme"
require "./inventaire/Protection"
require "./inventaire/Botte"

#== Représentation d'une Joueur héritant de la classe Personnage
class Joueur < Personnage
	@inventaire
	@arme
	@protection
	@botte
	@endurance
	@enduranceMax
	@score

	attr_accessor :inventaire, :arme, :protection, :botte, :endurance
	attr_reader   :score, :enduranceMax

  #=== methode pour augmenter le score du joueur
	def incScore( val )
		@score+= val
	end

  #=== methode pour augmenter l'endurance du joueur
	def incEndurance( val )
		if @endurance + val > @enduranceMax
			@endurance = @enduranceMax
		else
			@endurance+= val
		end
		if @endurance < 0
			incPointsDeVie( @endurance )
			@endurance = 0
		end
	end
	def incPointsDeVie( val )
		if @pointsDeVie + val > @pointsDeVieMax
			@pointsDeVie = @pointsDeVieMax
		else
			@pointsDeVie+= val
		end
		if @pointsDeVie == 0
			@pointsDeVie = 0
		end
	end

	 #=== Redéfinition de initialize
	def initialize(nom,position)
		super(nom,position)
		@inventaire=Inventaire.creer(150) # 150 -> poids max de l'inventaire

		# Equipement de départ
		@arme=Arme.creer("Poings",0,1,15)
		@protection=Protection.creer("t-shirt",0,1,1)
		@botte=Botte.creer("Tong",0,1,2)

		@endurance    = 100
		@enduranceMax = 100
		@score=0

	end

	private_class_method :new
	#=== Constructeur du Joueur
	def Joueur.creer(nom,position)
		new(nom,position)
	end

	#=== affichage de Joueur
	def to_s
		super()+"Inventaire: #{@Inventaire} Arme: #{@arme} Protection: #{@protection} Bottes: #{@botte} Endurance: #{@endurance} Score: #{@score}\n"
	end

	#=== Déplacement du joueur
	def seDeplacer( direction )
		cible = @position.voisine( direction )
		if direction == Direction::REPOS
			incPointsDeVie( -1 )
			incEndurance( 5 )
		elsif @endurance >= cible.type.endurance
			@endurance-= cible.type.endurance
			@position  = cible
		end
	end


	#=== Définit l'action spéciale d'un joueur :
	#* rammasser un objet si un objet est présent sur la case
	#* se faire aider par un guérisseur si un allié est présent sur la case
	def actionSpe()
		#Il faut déterminé se qui se trouve sur la case du joueur
		if @position.objet != nil
			self.inventaire.ajout(@position.objet) # ramasser un objet c'est le mettre dans son inventaire
		else @position.pnj != nil
			self.position.pnj.aider() # sur une case il ne peut y avoir qu'un allié car si c'était un enemis, il y aurait automatiquement un combat
		end
	end

  #=== utilise un objet 
	def utiliserObjet(unObjet)
		taille = @inventaire.tailleInventaire();
		j=0;
		listeO = @inventaire.getListe()
		listeO.each { |i|
			if (i.eql?(unObjet) )
				unObjet.utiliser(self)
				@inventaire.jeter(unObjet)
			end
		}
	end

  #=== Accesseur en écriture de la variables correspondante
	def setProtection( protection )
		@protection = protection
	end
	
  #=== Accesseur en écriture de la variable correspondante
	def setArme( arme )
		@arme = arme
	end

  #=== Accesseur en écriture de la variables correspondantes
	def setBotte( botte )
		@botte = botte
	end

end