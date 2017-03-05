#== définition du typeCase pour avoir des cases différentes (montage/désert/eau/...)
class TypeCase
	@@lastId = 0
	@id        #un numero d'identification
	@nom       #le nom du type
	@endurance #la quantité d'énergie pour traverser
	@variation #le nombre de variation existante
	@pourcent  #la part recouverte par ce type
	@aggMax    #nombre maximum de bloc par aggregat

	attr_reader :id, :nom, :endurance, :variation, :pourcent, :aggMax

	private_class_method :new
	#=== Constructeur
	def TypeCase.nouveau( nom, nbVar, cout, prc, aMx )
		new( nom, nbVar, cout, prc, aMx )
	end

	def initialize( nom, nbVar, cout, prc, aMx )
		@id        = @@lastId
		@nom       = nom
		@endurance = cout
		@variation = nbVar
		@pourcent  = prc
		@aggMax    = aMx
		@@lastId+= 1
	end

  #=== retourne l'id du type de la case
	def to_i
		return @id
	end
end
