# encoding: utf-8

require "./Jeu"
require "./interface/Interface"
require "./interface/MenuInterne"

#== Classe contrôleur qui sert d'intermédiaire entre la vue et le jeu
class Controleur
	@interface
	@jeu

  attr_reader :jeu

	private_class_method :new
	def Controleur.nouveau()
		new()
	end


  #=== Ordonne au jeu lancer le chargement d'une partie
  def charger(nomHeros)
    heros = Joueur.creer(nomHeros,1)
    self.lancerJeu(heros,1)
    @jeu.chargementJeu(nomHeros)
  end
  
  #=== methode ppur lier un interface au controleur
	def ajouterInterface( interface )
		@interface = interface
		@interface.lierControleur( self )
	end
	
  #=== lier un Jeu au controleur
	def ajouterJeu( jeu )
		@jeu = jeu
		@jeu.lierControleur( self )
	end
	
	#=== Lance un nouveau jeu 
	def lancerJeu( hero, niveau )
		@jeu = Jeu.nouveau( 100, 100, niveau, hero )
		@jeu.lierControleur( self )
	end

	#=== Ordonner le rafraichissement de la vue
	def rafraichir
		j = @jeu.joueur
		pos = j.position

		@jeu.tourSuivant( @jeu.carte.vueJoueur(pos,15) )
		@interface.setVue( @jeu.carte.vueJoueur(pos,@interface.taille) )
		@interface.setPV( j.pointsDeVie, j.pointsDeVieMax )
		@interface.setED( j.endurance,   j.enduranceMax )
		@interface.setScore( j.score )
		@interface.setNbTour( @jeu.nbTour )
		@interface.setOr( j.or )
		if j.position.objet
			@interface.setAction( "Ramasser #{j.position.objet.getNom}" )
		elsif j.position.pnj
			@interface.setAction( j.position.pnj.actionNom )
		elsif j.position.type.nom == "herbe"
			@interface.setAction( "Regarder l'herbe pousser" )
		elsif j.position.type.nom == "desert"
			@interface.setAction( "Compter les grains de sable" )
		elsif j.position.type.nom == "eau"
			@interface.setAction( "Faire la planche" )
		else
			@interface.setAction( "Rien à faire" )
		end
	end

	#=== methode de déplacement (repos) du joueur
	def repos
		@jeu.joueur.seDeplacer( Direction::REPOS )
		rafraichir
	end
	
	#=== methode de déplacement (haut) du joueur
	def haut
		@jeu.joueur.seDeplacer( Direction::HAUT )
		rafraichir
	end
	
	#=== methode de déplacement (droit) du joueur
	def droite
		@jeu.joueur.seDeplacer( Direction::DROITE )
		rafraichir
	end
	
	#=== methode de déplacement (gauche) du joueur
	def gauche
		@jeu.joueur.seDeplacer( Direction::GAUCHE )
		rafraichir
	end
	
	#=== methode de déplacement (bas) du joueur
	def bas
		@jeu.joueur.seDeplacer( Direction::BAS )
		rafraichir
	end
	
	#=== lie l'inventaire du joueur à son équivallent dans l'interface
	def inventaire
		@interface.inventaire( @jeu.joueur.inventaire.getListe )
	end
	
	#=== methode pour utiliser un obj
	def utiliser( objet )
		@jeu.joueur.utiliserObjet( objet )
		rafraichir
	end
	
	#=== methode pour jeter un obj
	def jeter( objet )
		@jeu.joueur.inventaire.jeter( objet )
	end
	
	#=== Création du menu interne
	def menu
		plop = MenuInterne.nouveau( self )
	end
	
	#=== Methode pour lancer l'action spéciale sur une case
	def actionSpe
		@jeu.joueur.position.action( @jeu.joueur )
		rafraichir
	end

	#=== Methode activé lors de la mort du Joueur
	def gameOver
		@interface.gameOver
	end
end