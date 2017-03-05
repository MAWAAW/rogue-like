require 'gtk2'
include Gtk

TAILLE=12
FONT="\"Times New Roman #{TAILLE}\""

#== Classe représentant le menu principale du jeu
class MenuMain
	@controleur
	@fMenu
	@fnew
	@fScore
	@fLangues
	@fCredits
	@tabScore

	@bSauvegarde
	@bQuitter
	@bCharger
	@bRevenir
	@bOptions


	private_class_method :new
  #=== redéfinition de initialize
	def initialize( controleur )
			@controleur = controleur

		  #Fenetre principale du menu
		  fMenu = Window.new()
		  fMenu.set_title("Xplore")
		  fMenu.set_window_position(Window::POS_CENTER_ALWAYS)
		  fMenu.set_default_size(1034,736)
		  fMenu.resizable= true
		  fMenu.signal_connect('destroy') {
			  Gtk.main_quit
		  }

		  iMenu = Gtk::Image.new("image/main.png")

		  generalVB = VBox.new(false,5)

		  #fMenu.modify_bg(Gtk::STATE_NORMAL, Gdk::Color.new(3200,3200,3200))


		  titreHB = HBox.new(false,5)
		  menuHB = HBox.new(false,5)


		  gaucheVB=VBox.new(false,5)
		  mainVB=VBox.new(false,5)
		  droiteVB=VBox.new(false,5)



		  lTitre = Label.new("Xplore")

		  bNew=Button.new("Nouvelle Partie") # ref to .txt 1
		  bNew.relief=(Gtk::RELIEF_NONE)
		  bCharger=Button.new("Charger") # ref to .txt 2
		  bCharger.relief=(Gtk::RELIEF_NONE)
		  bScore=Button.new("Score") # ref to .txt 3
		  bScore.relief=(Gtk::RELIEF_NONE)
		  bOptions=Button.new("Options") # ref to .txt 4
		  bOptions.relief=(Gtk::RELIEF_NONE)
		  bCredits=Button.new("Credits") # ref to .txt 5
		  bCredits.relief=(Gtk::RELIEF_NONE)
		  bQuitter=Button.new("Quitter") # ref to .txt 5
		  bQuitter.relief=(Gtk::RELIEF_NONE)

		  # Création du Héros pour nouvelle partie
		  bNew.signal_connect('clicked') {
			 @fnew = Window.new()
			 @fnew.set_title("Creation du Heros") # ref to .txt 6
			 @fnew.set_window_position(Window::POS_CENTER_ALWAYS)
			 @fnew.resizable=true
			 @fnew.set_default_size(250,50)

			 herosMainVB = VBox.new(false,5)
			 herosHB = HBox.new(false,5)
			 lHeros = Label.new("Nom du heros : ") # ref to .txt 7
			 eHeros = Entry.new()
			 cbHeros = ComboBox.new(true)
			 cbHeros.append_text("1")
			 cbHeros.append_text("2")
			 cbHeros.append_text("3")
       cbHeros.append_text("4")
       cbHeros.append_text("5")

			 bHeros = Button.new("Valider") # ref to .txt 8

			 herosHB.add(lHeros)
			 herosHB.add(eHeros)
			 herosMainVB.add(herosHB)
			 herosMainVB.add(cbHeros)
			 herosMainVB.add(bHeros)


			 @fnew.add(herosMainVB)
			 @fnew.show_all

			 # bouton pour lancer la nouvelle partie
			 bHeros.signal_connect('clicked') {
				nomHeros = eHeros.text()
				if(nomHeros == "")
				  nomHeros = "Player"
			  end
				difficulte = cbHeros.active_text()
				@controleur.lancerJeu( nomHeros, difficulte.to_i() )

				fMenu.destroy
				@fnew.destroy

				interface  = Interface.nouveau( 11, "FR", nomHeros )
				@controleur.ajouterInterface( interface )
			 }

		  }
		  bCharger.signal_connect('clicked') {
			 @fcharge = Window.new()
			 @fcharge.set_title("Chargement d'une partie : ")  # ref to .txt 9
			 @fcharge.set_window_position(Window::POS_CENTER_ALWAYS)
			 @fcharge.resizable=true
			 @fcharge.set_default_size(350,100)

			 cbSave=ComboBox.new(true)
			 lSave = Label.new("Choisissez la sauvegarde a charger ") # ref to .txt 10
			 saveVB = VBox.new(false,5)
			 bSave = Button.new("Charger") # ref to .txt 11

			 Dir.foreach("."){ |fichier|
				if(File.extname(fichier) == ".yml")
				  cbSave.append_text("#{fichier}")
				end
			 }
			 cbSave.set_active(0)
			 
			 saveVB.add(lSave)
			 saveVB.add(cbSave)
			 saveVB.add(bSave)

			 @fcharge.add(saveVB)
			 @fcharge.show_all
			 
       bSave.signal_connect('clicked') {
        nomFichier = cbSave.active_text()
        nomHeros = nomFichier.split(".")
        nomHeros = nomHeros[0]
        @controleur.charger(nomHeros)

        fMenu.destroy
        @fcharge.destroy

        interface  = Interface.nouveau( 11, "FR", nomHeros )
        @controleur.ajouterInterface( interface )
       }
			 
		  }

			# Bouton Score
			bScore.signal_connect('clicked') {
				@fScores = Window.new()
				@fScores.set_title("Hall of Fame")  # ref to .txt 12
				@fScores.set_window_position(Window::POS_CENTER_ALWAYS)
				@fScores.resizable=true
				@fScores.set_default_size(250,100)

				scoreVB = VBox.new(false, 5)

				tabFile = File.open("./score/score.txt",'r')
				tabFile.each_line{ |ligne|
					tab = ligne.split(";")
					nom = tab[0]
					num = tab[1]
					lne  = HBox.new(false, 5)
					lne.add(Gtk::Label.new(nom))
					lne.add(Gtk::Label.new(num))
					scoreVB.add(lne)
				}
				@fScores.add(scoreVB)
				@fScores.show_all
			}
		  # Menu Option
		  bOptions.signal_connect('clicked') {
			 @fLangues = Window.new()
			 @fLangues.set_title("Choix de langues")
			 @fLangues.set_window_position(Window::POS_CENTER_ALWAYS)
			 @fLangues.resizable=true
			 @fLangues.set_default_size(250,100)

			 vBoxLan = VBox.new(false, 10)
			 hBoxLanH = HBox.new(false, 10)
			 hBoxLanB = HBox.new(false, 10)

			 # Le texte d'explication

			 cBoxLan=ComboBox.new(true)
			 cBoxLan.append_text("Anglais")
			 cBoxLan.append_text("Francais")
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
			 # pour recuperer la valeur du combobox il faut utiliser la fonction cBoxLan.active_iter.get_value(0)
			 hBoxLanH.add(label)
			 hBoxLanB.add(cBoxLan)
			 vBoxLan.add(hBoxLanH)
			 vBoxLan.add(hBoxLanB)
			 @fLangues.add(vBoxLan)
			 @fLangues.show_all
		  }
		  bCredits.signal_connect('clicked') {
			 @fCredits = Window.new()
			 @fCredits.set_title("Credits")
			 @fCredits.set_window_position(Window::POS_CENTER_ALWAYS)
			 @fCredits.resizable=false
			 # @fCredits.set_default_size(1034,736)
			 iCredits = Gtk::Image.new("./image/credit-ruby.png")

			 @fCredits.add(iCredits)
			 @fCredits.show_all
		  }
		  bQuitter.signal_connect('clicked') {
					 Gtk.main_quit
		  }

		titreHB.add(iMenu)

		mainVB.add(bNew)
		mainVB.add(bCharger)
		mainVB.add(bScore)
		mainVB.add(bOptions)
		mainVB.add(bCredits)
		mainVB.add(bQuitter)

		menuHB.add(gaucheVB)
		menuHB.add(mainVB)
		menuHB.add(droiteVB)

		generalVB.add(titreHB)
		generalVB.add(menuHB)

		#mainVB.add(iMenu)



		fMenu.add(generalVB)
		fMenu.show_all

		Gtk.main
	end

	def MenuMain.nouveau( controleur )
		new( controleur )
	end

	#=== Chargement d'un fichier (ici pour la lecture du score)
	def loadFile()
	@tabScore = Array.new;
	fic = File.open("../score/score.txt",'r')
	fic.each_line{ |ligne|
		tab = ligne.split(";")
		@tabScore.push(tab)
	}
	#self.debugAfficherTab
	return self
	end

	#=== recupération du texte avec sa clef dans un fichier
	def getTexte(cle,id)
		@tabScore.each { |l|
			if(l[0] == cle)
				return l[id].chomp;
			end
		}
		#return "ERROR "+cle+" NON DEFINIE";
	end

end
#mm = MenuMain.nouveau()