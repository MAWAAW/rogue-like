# encoding: utf-8

require "./carte/Carte"
require "./personnage/Personnage"
require "./personnage/NonPisteur"
require "./personnage/Pisteur"
require "./personnage/Guerisseur"
require "./personnage/Marchand"
require "./personnage/Joueur"
require "./sauvegarde/SauvegardeYAML"

#== Le Jeu est la classe qui gère tout les comportement du jeu
class Jeu
	@controleur
	@joueur
	@carte
	@difficulte
	@sauvegarde
	@sauvegardeYaml
	@nbTour

	attr_reader :joueur, :carte, :difficulte, :sauvegarde, :nbTour

	private_class_method :new

	def lierControleur( controleur )
		@controleur = controleur
	end

	#=== Calcul du tour suivant
	def tourSuivant( vue )
		@nbTour += 1
		listePNJ = Array.new
		vue.each do |y|
			y.each do |x|
				if x.pnj
					listePNJ.push(x.pnj)
				end
			end
		end
		listePNJ.each do |x|
			x.comportement( joueur )
		end
		if joueur.pointsDeVie <= 0
			@controleur.gameOver
		end
	end


	 # Création de la carte
	#=== Génération des pnj de manière aléatoire sur la carte
	def initialize (haut, larg, difficulte, nomJoueur)
		@difficulte = difficulte

		@carte = Carte.generer( haut, larg, difficulte )

		# On positionne le joueur de manière aléatoire sur la carte
		x = larg / 2
		y = haut / 2
		@joueur = Joueur.creer(nomJoueur, @carte.getCase(x,y))
		@joueur.inventaire.ajout( Consomable.creer("Pastèque",0,3,15,0) )
		@joueur.inventaire.ajout( Consomable.creer("Pastèque moisie",0,4,-8,0) )
		@joueur.inventaire.ajout( Consomable.creer("Pastèque moisie",0,4,-8,0) )
		@carte.carte.each do |i|
			i.each do |j|
				r = rand( 1024 )
				if r == 0
					j.pnj = Marchand.creer("Marchand",j)
				elsif r == 1
					j.pnj = Guerisseur.creer("Guerisseur",j)
				elsif r == 2
					j.objet = Consomable.creer("Petite potion",0,0,50,0)
				elsif r <= 10
					j.objet = Consomable.creer("Pastèque",0,0,15,0)
				elsif r <= (difficulte*5 + 50)
					j.pnj = Pisteur.creer(
						"Mechant",j,
						Arme.creer("pince",0,0.1,1),
						Protection.creer("chitine",0,0.8,2)
					)
				elsif r <= 100
					#j.pnj = NonPisteur.creer("passif",j,nil,nil)
				end
			end
		end

		# initialisation du nombre de tour à 0
		@nbTour =0

	end


	#=== Création d'une nouvelle partie
	def Jeu.nouveau(haut, larg, difficulter, nomJoueur)
		new(haut, larg, difficulter, nomJoueur)
	end


	#=== Sauvegarde d'une partie
	def sauvegarderJeu()
		# création de la sauvegarde
		@sauvegarde = Sauvegarde.creer( self.joueur,self.carte,self.nbTour )

    @sauvegardeYaml = SauvegardeYAML.creer(self.joueur.nom)
    @sauvegardeYaml.enregistrement( self.sauvegarde)

	end


	#=== Chargement d'une partie
	def chargementJeu(nomJoueur)
    @sauvegardeYaml = SauvegardeYAML.creer(nomJoueur)
    @sauvegarde = @sauvegardeYaml.chargement()
    @joueur = @sauvegarde.joueur
    nom=@joueur.nom.split(".")
    @joueur.nom = nom[0]
    print @joueur.nom
    @carte = @sauvegarde.carte
    @nbTour = @sauvegarde.nbTour
	end

	def gameOver
		@controleur.gameOver
	end

end