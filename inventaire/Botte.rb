
require "./inventaire/Equipement"
#== Classe définissant les bottes (hérite de Equipement)
class Botte < Equipement

	def initialize(unNom,unPrix,unPoids,unePuissance)
		super(unNom,unPrix,unPoids,unePuissance)
 	end

 	private_class_method :new
 	 #=== Constructeur
	def Botte.creer(unNom,unPrix,unPoids,unePuissance)
		new(unNom,unPrix,unPoids,unePuissance)
	end
  
  #=== Utiliser les bottes (ici équiper)
	def utiliser(unJoueur)
		unJoueur.setBotte(self)
	end

end