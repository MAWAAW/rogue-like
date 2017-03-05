#== classe mère de tous les objets
class Objet
	@nom
	@prix
	@poids
	private_class_method :new
	def Objet.creer(unNom,unPrix,unPoids)
		new(unNom,unPrix,unPoids)
	end

	def initialize(unNom,unPrix,unPoids)
		@nom=unNom
		@prix=unPrix
		@poids=unPoids
  	end
  #=== Accesseur en lecture à la variables correspondantes
	def getNom()
		return @nom
	end
	
  #=== Accesseur en lecture à la variables correspondantes
	def getPrix()
		return @prix
	end

  #=== Accesseur en lecture à la variables correspondantes
	def getPoids()
		return @poids
	end

  #=== Accesseur en écriture à la variables correspondantes
	def setNom(unNom)
		@nom=unNom
	end

  #=== Accesseur en écriture à la variables correspondantes
	def setPrix(unPrix)
		@prix=unPrix
	end

  #=== Accesseur en écriture à la variables correspondantes
	def setPoids(unPoids)
		@poids=unPoids
	end

  #=== utiliser l'objet ici abstraite car redéfini en fonction de l'obj
	def utiliser(unJoueur)
		#ABSTRAIT
	end

  #=== demande si l'objet est un consomable
	def estConsomable()
		return false
	end

  #=== demande si l'objet est un équipement
	def estEquipement()
		return false
	end

	def to_s
		">>> Nom: #{@nom} Prix: #{@prix} Poids: #{@poids} "
	end
end




