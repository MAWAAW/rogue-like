# encoding: utf-8

require "gtk2"
require "./Controleur"
require "./interface/Interface"
require "./sauvegarde/Sauvegarde"
require "./Jeu"
include Gtk

#== Classe représentant le menu "in game" du jeu
class MenuInterne
	@controleur
	@interface

	@fMenu
	@fLangues

	@bSauvegarde
	@bQuitter
	@bCharger
	@bOptions
	@bValider

	@bQuit

	private_class_method :new
  #=== Constructeur
  def MenuInterne.nouveau(controleur)
    new(controleur)
  end
	
  #=== redéfinition de initialize
	def initialize( controleur )
		Gtk.init
		@fMenu = Window.new()
		@fMenu.set_title("Menu interne du jeu")
		@fMenu.set_window_position(Window::POS_CENTER_ALWAYS)
		@fMenu.resizable=false
		@fMenu.signal_connect('destroy') do
		  Gtk.main_quit
		end

		#==Boittes
		# 	     vBoxG
		#hBoxH|			|
		#hBoxB| vBoxBG | vBoxBD |
		#
		#
		vBoxG=VBox.new(false,5)
		hBoxH=HBox.new(false, 5)
		hBoxB=HBox.new(false, 5)
		vBoxBG=VBox.new(false,5)
		vBoxBD=VBox.new(false,5)

		iMenu = Gtk::Image.new("image/pause.jpg")

		lGerer = Label.new("C'est un menu pour gérer votre jeu")

		@bSauvegarder=Button.new("Sauvegarder")
		
		@bOptions=Button.new("Options")
		@bQuitter=Button.new("Quitter")

		@controleur = controleur

		@bSauvegarder.signal_connect('clicked') do

			@controleur.jeu.sauvegarderJeu()
			fSauv = Window.new()
			fSauv.set_title("Sauvegarde")
			fSauv.set_window_position(Window::POS_CENTER_ALWAYS)
			fSauv.resizable=false
			texte="    Sauvegarde effectuée.   "
			label=Label.new()
			label.set_markup(texte)
			fSauv.add(label)
			fSauv.show_all

		end



		@bOptions.signal_connect('clicked') {
		@fLangues = Window.new()
		@fLangues.set_title("Choix de langues")
		@fLangues.set_window_position(Window::POS_CENTER_ALWAYS)
		@fLangues.resizable=false

		vBoxLan = VBox.new(false, 10)
		hBoxLanH = HBox.new(false, 10)
		hBoxLanB = HBox.new(false, 10)

		# Le texte d'explication

		cBoxLan=ComboBox.new(true)
		cBoxLan.append_text("Anglais")
		cBoxLan.append_text("Français")
		cBoxLan.append_text("Russe")


		# L'élément actif est celui à la position 0
		cBoxLan.active=0
		texte="<span> Element selectionne : <b>#{cBoxLan.active_iter.get_value(0)}</b></span>"
		label=Label.new()
		label.set_markup(texte)

		#Quand on change de sélection on change le label
		cBoxLan.signal_connect('changed') {
		texte="<span> Element selectionne : <b>#{cBoxLan.active_iter.get_value(0)}</b></span>"
		label.set_markup(texte)

		}
		#pour recuperer la valeur du combobox il faut utiliser la fonction cBoxLan.active_iter.get_value(0)
		hBoxLanH.add(label)


		hBoxLanB.add(cBoxLan)
		vBoxLan.add(hBoxLanH)
		vBoxLan.add(hBoxLanB)
		@fLangues.add(vBoxLan)
		@fLangues.show_all

		}

=begin
		choixLangue = cBoxLan.active_iter.get_value(0)
		if(choixLangue == "Anglais")
				 @controleur.getInterface().setTxt("EN")
		end

		if(choixLangue == "Français")
				@controleur.getInterface().setTxt("FR")
		end

=end


		@bQuitter.signal_connect('clicked') do
			Gtk.main_quit

		end





		vBoxBG.add(@bSauvegarder)
		vBoxBG.add(@bOptions)
		vBoxBG.add(@bQuitter)

		vBoxBD.add(iMenu)

		hBoxH.add(lGerer)
		vBoxG.add(hBoxH)
		vBoxG.add(hBoxB)
		hBoxB.add(vBoxBG)
		hBoxB.add(vBoxBD)

		@fMenu.add(vBoxG)
		@fMenu.show_all

		Gtk.main

	end

end