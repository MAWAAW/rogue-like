#== classe pour la gestion de l'externalisation de la langue
class Texte

	@langue
	@tabTexte

	private_class_method :new
	def Texte.nouveau( langue )
		new( langue )
	end
	def initialize( langue )
		@langue = langue
		loadFile();
	end
	
	#=== Accesseur en écriture de la variable correspondante
  def setLangue(langue)
    @langue = langue
    self.loadFile();
    return self
  end

  #=== Charger un fichier Langue
	def loadFile()
		@tabTexte = Array.new;
		fic = File.open("langue/"+@langue+".txt",'r')
		fic.each_line{ |ligne|
			tab = ligne.split(";")
			@tabTexte.push(tab)
		}
		#self.debugAfficherTab
		return self;
	end

  #=== Récupérer une chaine de caractère avec la clef
	def getTexte(cle)
		@tabTexte.each { |l|
			if(l[0] == cle)
				return l[1].chomp;
			end
		}
		return "ERROR "+cle+" NON DEFINIE";
	end

	def debugAfficherTab
		@tabTexte.each { |l|
			puts (l[0] + " -- " + l[1])
		}
	end

end