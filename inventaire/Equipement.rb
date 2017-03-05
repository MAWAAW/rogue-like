
require "./inventaire/Objet"
#== Classe définissant les équipements (hérite de Objet) qui s'opposent aux consomables
class Equipement < Objet
	@puissance

	attr_reader :puissance

	def initialize(unNom,unPrix,unPoids,unePuissance)
		super(unNom,unPrix,unPoids)
		@puissance = unePuissance
	end

	private_class_method :new
	 #=== Constructeur
	def Equipement.creer(unNom,unPrix,unPoids,unePuissance)
	  new(unNom,unPrix,unPoids,unePuissance)
	end
  	
   #=== Permet de savoir si l'objet est un Equipement
	def estEquipement()
		return true
	end

	def to_s
		super()+"Puissance: #{@puissance}\n"
	end
end

