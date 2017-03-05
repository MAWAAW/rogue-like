#== Définition de la classe coord pour la gestion des cases dans une matrice
class Coord
  @coordX
  @coordY
    
  attr_accessor :coordX, :coordY
  
  private_class_method :new
    
  #=== redéfinition de initialize
  def initialize(x,y)
    @coordX,@coordY = x,y    
  end
  
  #=== Constructeur de coord
  def Coord.creer(x,y)
    new(x,y)
  end
  
  #=== affichage de coordonnée
  def affiche()
	print("x=",coordX,"\ny=",coordY,"\n")
  end
end
