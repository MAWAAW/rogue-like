#== Classe utilisé pour contenir les données de sauvegarde
class Sauvegarde
  @joueur
  @carte
  @nbTour
  
  attr_reader :joueur, :carte, :nbTour
  
  private_class_method :new
  
  #=== Redéfinition de initialize
  def initialize(joueur,carte,nbT)
    @joueur, @carte, @nbTour = joueur,carte,nbT
  end
  
  #=== Constructeur qui prend les 3 attributs de la classe
  def Sauvegarde.creer(joueur,carte,nbT)
    new(joueur,carte,nbT)
  end

end