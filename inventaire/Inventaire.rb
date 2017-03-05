
require "./inventaire/Objet"
require "./inventaire/Consomable"
require "./inventaire/Equipement"
require "./inventaire/Arme"
require "./inventaire/Protection"
require "./inventaire/Botte"

#== Représentation d'un Inventaire
class Inventaire
	@listObjet
	@poidsMax

	#=== Création d'une liste d'objets
	def initialize(unPoids)
		@listObjet = Array.new()
		@poidsMax = unPoids
	end

	private_class_method :new
	#=== Constructeur
	def Inventaire.creer(unPoids)
		new(unPoids)
	end

  #=== Accesseur en lecture (poidsMax)
	def getPoidsMax()
		return @poidsMax
	end
  #=== Accesseur en lecture (listObjet)
	def getListe()
		return @listObjet
	end

	#=== Ajoute un objet dans la liste et renvoit un boolean indiquant si l'ajout s'est effectué
	def ajout(unObjet)
		if (verifierPoidsTotal(unObjet))
			@listObjet.push(unObjet)
			return true
		else
			#print "L'objet ",unObjet.getNom()," possède un poids qui, une fois ajouté à l'inventaire dépasse le poids total accepté."
			return false
		end
	end

	#=== Jeter un objet revient à le supprimer
	def jeter(unObjet)

		self.getListe().each { |i|
			if ( i.eql?(unObjet) )
				self.getListe().delete(unObjet) # la fonction delete seule fonctionne bien
				#print "L'objet ",unObjet.getNom()," a été jeté/supprimé de l'inventaire."
				return
			end
		}
		#print "L'objet ",unObjet.getNom()," n'est pas présent dans l'inventaire."

	end


	######### Méthode interne à la classe #############

	#=== Retourne la taille de l'inventaire
	def tailleInventaire()
		return @listObjet.size()
	end

	#=== Donne le poids total de tous les objets de l'inventaire
	def donnePoidsTotal()
		poidsTotal=0
		@listObjet.each { |i|
			element = i
			poids_element = element.getPoids() # récupère le poids de l'élément
			poidsTotal = poidsTotal+poids_element
		}
		return poidsTotal
	end

	#=== Verifie que le poids total de l'inventaire permet d'ajouter un objet, renvoit un boolean
	def verifierPoidsTotal(unObjet)
		poidsTotal = donnePoidsTotal()
		if( poidsTotal+unObjet.getPoids() <= self.getPoidsMax() )
			return true
		else
			return false
		end
	end

	#=== Affichage tous les objets de l'inventaire
	def to_s
		"#{@listObjet}"
	end
end
