
require "./inventaire/Objet"
#== Définition des items consomables (hérite de Objet)
class Consomable < Objet
	@valeurPV
	@valeurED

	private_class_method :new
	#=== Constructeur
	def Consomable.creer(unNomObjet,unPrix,unPoids,uneValeurPV,uneValeurED)
		new(unNomObjet,unPrix,unPoids,uneValeurPV,uneValeurED)
	end
	def initialize(unNomObjet,unPrix,unPoids,uneValeurPV,uneValeurED)
		super(unNomObjet,unPrix,unPoids)
		@valeurPV=uneValeurPV
		@valeurED=uneValeurED
	end
  #=== utiliser un consomable
	def utiliser(unJoueur)
		unJoueur.incEndurance(@valeurED)
		unJoueur.incPointsDeVie(@valeurPV)
	end

  #=== booléen permettant de savoir si c'est un consomable
	def estConsomable()
		return true
	end

	def to_s
		super()+"PV: #{@valeurPV} END: #{@valeurED}\n"
	end

end
