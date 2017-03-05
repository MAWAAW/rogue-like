require "./sauvegarde/Sauvegarde"
require "./carte/Carte"
require "./personnage/Joueur"

require 'yaml'
require 'psych'

#== classe pour la gestion de la sauvegarde avec le module YAML et Psych 
class SauvegardeYAML
  @nomFichier
    
   #=== redéfinition de initialize
  def initialize(nomJoueur)
    @nomFichier = nomJoueur.concat('.yml')
  end
  
  private_class_method :new
  #=== Constructeur requiert le nom du joueur en paramètre
  def SauvegardeYAML.creer(nomJoueur)
    new(nomJoueur)
  end
  
  #=== enregistrement des données dans le fichier de sauvegarde
  def enregistrement(save)
    fichier = File.open(@nomFichier,'w+') do  |out|
      Psych.dump([save.joueur,save.carte,save.nbTour], out)
    end
  end
  
  #=== Chargement d'une partie depuis le fichier de sauvegarde
  def chargement()
    tableau = Psych.load_file(@nomFichier)
    save = Sauvegarde.creer(tableau[0],tableau[1],tableau[2])
    return save 
  end

end



