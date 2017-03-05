
require "./inventaire/Equipement"
#== Classe définissant les protections (hérite de Equipement)
class Protection < Equipement

	def initialize(unNom,unPrix,unPoids,unePuissance)
		super(unNom,unPrix,unPoids,unePuissance)
 	end

	private_class_method :new
	def Protection.creer(unNom,unPrix,unPoids,unePuissance)
		new(unNom,unPrix,unPoids,unePuissance)
	end

  #=== Utiliser la protection (=équiper)
	def utiliser(unJoueur)
		unJoueur.setProtection(self)
	end

	def to_s
		@nom
  	end

end