# encoding: utf-8

require "gtk2"
require "./Controleur"
require "./Texte"

class Interface
	@controleur #Lien vers le controleur
	@windows

	#Lien vers les éléments de l'interface
	@haut; @droite; @gauche; @bas  #direction
	@repos; @objet; @menu          #action
	@vue; @score; @tour; @or       #information
	@arme; @protection; @botte     #equipdement
	@action                        #action contextuelle
	@pv; @ed                       #jauge vie et endurance
	@console                       #

	@t   #taille de la vue
	@txt #TEXTE pour recuperer les valeurs des chaines

	def taille
		return @t
	end

	private_class_method :new
	#=== Constructeur
	def Interface.nouveau( taille, txt, nom )
		new( taille, txt, nom )
	end
	def initialize( taille , txt, nom )
		@t = taille
		@txt = txt = Texte.nouveau( txt )

		Gtk.init
		@window = Gtk::Window.new("RPG")
		vue     = Gtk::Table.new(@t, @t+3)
		cadre   = Gtk::VBox.new
		info    = Gtk::HBox.new

		@score      = Gtk::Label.new(@txt.getTexte("4_score"))
		@tour       = Gtk::Label.new(@txt.getTexte("6_nbTours"))
		@nom        = Gtk::Label.new(nom)
		@or         = Gtk::Label.new(@txt.getTexte("8_or"))
		@arme       = Gtk::Button.new(@txt.getTexte("0_arme"))
		@protection = Gtk::Button.new(@txt.getTexte("1_protection"))
		@botte      = Gtk::Button.new(@txt.getTexte("2_bottes"))
		@action     = Gtk::Button.new(@txt.getTexte("3_action"))
		@console    = Gtk::Label.new(@txt.getTexte("10_ennemiTue"))
		@pv         = Gtk::ProgressBar.new
		@ed         = Gtk::ProgressBar.new
		@haut   = Gtk::EventBox.new.add(Gtk::Image.new("image/iu/haut.png"))
		@droite = Gtk::EventBox.new.add(Gtk::Image.new("image/iu/droite.png"))
		@repos  = Gtk::EventBox.new.add(Gtk::Image.new("image/iu/stop.png"))
		@gauche = Gtk::EventBox.new.add(Gtk::Image.new("image/iu/gauche.png"))
		@objet  = Gtk::EventBox.new.add(Gtk::Image.new("image/iu/sac.png"))
		@bas    = Gtk::EventBox.new.add(Gtk::Image.new("image/iu/bas.png"))
		@menu   = Gtk::EventBox.new.add(Gtk::Image.new("image/iu/menu.png"))
		@vue = Array.new( @t ) do |y|
			Array.new( @t ) do |x|
				Gtk::Image.new("image/joueur/herbe.png")
			end
		end

		#Assemblage de la vue
		@t.downto(1) do |y|
			@t.downto(1) do |x|
				vue.attach(
					@vue[x-1][y-1],
					x-1, x, y-1, y,
					Gtk::SHRINK, Gtk::SHRINK,
					0, -8
				)
			end
		end
		vue.attach(@haut,       @t+1, @t+2, 0, 1 )
		vue.attach(@gauche,       @t, @t+1, 1, 2 )
		vue.attach(@repos,      @t+1, @t+2, 1, 2 )
		vue.attach(@droite,     @t+2, @t+3, 1, 2 )
		vue.attach(@objet,        @t, @t+1, 2, 3 )
		vue.attach(@bas,        @t+1, @t+2, 2, 3 )
		vue.attach(@menu,       @t+2, @t+3, 2, 3 )
		vue.attach(@arme, 		  @t, @t+1, 3, 4 )
		vue.attach(@protection, @t+1, @t+2, 3, 4 )
		vue.attach(@botte, 		@t+2, @t+3, 3, 4 )
		vue.attach(@action, 		  @t, @t+3, 4, 5 )
		vue.attach(@pv,           @t, @t+3, 5, 6 )
		vue.attach(@ed,           @t, @t+3, 6, 7 )
		vue.border_width = 7

		#Assemblage de reste
		info.add( @nom )
		info.add( @score )
		info.add( @tour )
		info.add( @or )
		cadre.add( info )
		cadre.add( vue )
		cadre.add( @console )
		@window.add( cadre )

		@window.signal_connect('destroy') do Gtk.main_quit end
		@window.resizable = false
	end

	#
	def lierControleur( controleur )
		@controleur = controleur
		@arme.signal_connect('clicked') do
			print(@txt.getTexte("0_arme"))
		end
		@protection.signal_connect('clicked') do
			print(@txt.getTexte("1_protection"))
		end
		@botte.signal_connect('clicked') do
			print(@txt.getTexte("2_bottes"))
		end
		@action.signal_connect('clicked') do
			@controleur.actionSpe
		end
		@haut.signal_connect('button_press_event') do
			@controleur.haut
		end
		@droite.signal_connect('button_press_event') do
			@controleur.droite
		end
		@repos.signal_connect('button_press_event') do
			@controleur.repos
		end
		@gauche.signal_connect('button_press_event') do
			@controleur.gauche
		end
		@objet.signal_connect('button_press_event') do
			@controleur.inventaire
		end
		@bas.signal_connect('button_press_event') do
			@controleur.bas
		end
		@menu.signal_connect('button_press_event') do
			@controleur.menu
		end
		@controleur.rafraichir
		@window.show_all
		Gtk.main
	end

	def setScore( val )
		@score.text = @txt.getTexte("4_score") + " : #{val}"
	end
	def setNbTour( val )
		@tour.text = @txt.getTexte("6_nbTours") + " : #{val}"
	end
	def setOr( val )
		@or.text = @txt.getTexte("8_or") + " : #{val}"
	end

	def setVue( val )
		(@t-1).downto(0) do |y|
			(@t-1).downto(0) do |x|
				if x == @t/2 && y == @t/2
					@vue[x][y].file = "image/joueur/#{val[x][y]}.png"
				elsif val[x][y].pnj
					@vue[x][y].file = "image/#{val[x][y].pnj}/#{val[x][y]}.png"
				elsif val[x][y].objet
					@vue[x][y].file = "image/objet/#{val[x][y]}.png"
				else
					@vue[x][y].file = "image/#{val[x][y]}#{val[x][y].variation}.png"
				end
			end
		end
	end
	def setArme( val )
		@arme.label = val
	end
	def setProtection( val )
		@protection.label = val
	end
	def setBotte( val )
		@botte.label = val
	end
	def setAction( val )
		@action.label = val
	end
	def setPV( val, max )
		if( val > max )
			val = max
		end
		@pv.fraction = val / max.to_f
		@pv.text = @txt.getTexte("5_pv") + " : (#{val}/#{max})"
	end
	def setED( val, max )
		if( val > max )
			val = max
		end
		@ed.fraction = val / max.to_f
		@ed.text = @txt.getTexte("9_endurance") + " : (#{val}/#{max})"
	end
	def setConsole( val )
		#@console.text = val
		@console.text = @txt.getTexte("10_ennemiTue")
	end

	def menu
		Gtk.main_quit
	end
	def inventaire( liste )
		choix = Gtk::Menu.new
		utiliser = Gtk::MenuItem.new("Utilise")
		jeter    = Gtk::MenuItem.new("Jeter")

		choix.append(utiliser)
		choix.append(jeter)
		choix.show_all

		sacado = Gtk::Menu.new
		if liste.length == 0
			objet = Gtk::MenuItem.new("Vide")
			objet.signal_connect("button_press_event") do
				objet.destroy
			end
			sacado.append(objet)
		else
			liste.each do |o|
				objet = Gtk::MenuItem.new(o.getNom)
				objet.signal_connect("button_press_event") do
					choix.popup(nil, nil, 0, 0)
					utiliser.signal_connect("button_press_event") do
						@controleur.utiliser( o )
						sacado.hide
					end
					jeter.signal_connect("button_press_event") do
						@controleur.jeter( o )
						sacado.hide
					end
				end
				sacado.append(objet)
			end
		end

		sacado.show_all
		sacado.popup(nil, nil, 0, 0)
	end
	
	#=== Methode pour afficher l'écran de game over
	def gameOver
    fGaOver = Window.new()
    fGaOver.set_title("Game Over")
    fGaOver.set_window_position(Window::POS_CENTER_ALWAYS)
    fGaOver.resizable=false
    vBoxG=VBox.new(false,4)
    iMenu = Gtk::Image.new("image/gameover.png")
    bGameOver=Button.new("Game Over")
  
    bGameOver.signal_connect('clicked') do
            Gtk.main_quit
    end
  
    vBoxG.add(iMenu)
    vBoxG.add(bGameOver)
  
    fGaOver.add(vBoxG)
    fGaOver.show_all
  end 
end