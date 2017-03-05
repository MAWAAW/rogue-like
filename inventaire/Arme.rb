
require "./inventaire/Equipement"
#== Classe définissant les armes (hérite de Equipement)
class Arme < Equipement
  #=== reféfinition de initialize
	def initialize(unNom,unPrix,unPoids,unePuissance)
		super(unNom,unPrix,unPoids,unePuissance)
 	end

	private_class_method :new
	#=== Constructeur
	def Arme.creer(unNom,unPrix,unPoids,unePuissance)
		new(unNom,unPrix,unPoids,unePuissance)
	end
  
  #=== utiliser (ici équiper) l'arme
	def utiliser(unJoueur)
		unJoueur.setArme(self)
	end

end