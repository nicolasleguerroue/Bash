#!/bin/bash
source Colors
source Time

#Variables globales
source_directory="Softwares"   		#Emplacement relatif du code source du site
source_files="Softwares-install"
errors_output="fails.log"
standard_output="infos.log"

storage="$HOME/.Softwares-install"						#dossier où seront stockées les données du logiciel

#Vérification du dossier d'installation

if [[ ! -d $storage ]]; then #Si le dossier n'existe pas, on l'installe

	if [[ $(hostname -I) == "" ]]; then #Si réseau, on installe les programes

		echo -e "État du réseau : [ $red FAIL $default ]"	
		echo -e "Impossible d'installer les paquets sans réseau"	
		echo -e "Interruption du programme"	
		exit

	fi


	echo -e "Création du répertoire source [$storage]..."
	mkdir $storage
	echo -e "Création du répertoire source [$storage] : [ $green OK $default ]"

	
	echo -e "Création des commandes serveur [/bin/x]..."

	echo -e "Création des commandes locales [/bin/x]..."

	sudo cp Localhost/localhost_network /bin
	sudo chmod 777 /bin/localhost_network

	sudo cp Localhost/localhost_restart /bin
	sudo chmod 777 /bin/localhost_restart

	sudo cp Localhost/localhost_shutdown /bin
	sudo chmod 777 /bin/localhost_shutdown

	sudo cp Localhost/localhost_update /bin
	sudo chmod 777 /bin/localhost_update

	sudo cp Localhost/localhost_upgrade /bin
	sudo chmod 777 /bin/localhost_upgrade

	sudo cp Localhost/localhost_informations /bin
	sudo chmod 777 /bin/localhost_informations

	echo -e "Création des commandes serveur [/bin/x] : [ $green OK $default ]"

	echo -e "Création des bibliothèques [/bin/x]..."
	sudo cp Lib/Colors /bin
	sudo cp Lib/man/Colors.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/Colors.7
	sudo chmod 777 /bin/Colors

	sudo cp Lib/Time /bin
	sudo cp Lib/man/Time.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/Time.7
	sudo chmod 777 /bin/Time

	sudo cp Lib/Satellite /bin
	sudo cp Lib/man/Satellite.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/Satellite.7
	sudo chmod 777 /bin/Satellite

	sudo cp Lib/Files /bin
	sudo cp Lib/man/Files.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/Files.7
	sudo chmod 777 /bin/Files

	sudo cp Lib/Network /bin
	sudo cp Lib/man/Network.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/Network.7
	sudo chmod 777 /bin/Network

	sudo cp Lib/System /bin
	sudo cp Lib/man/System.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/System.7
	sudo chmod 777 /bin/System
	

	sudo cp Lib/Sound /bin
	sudo cp Lib/man/Sound.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/Sound.7
	sudo chmod 777 /bin/Sound

	sudo cp Lib/Zenity /bin
	sudo cp Lib/man/Zenity.7 /usr/share/man/man7
	sudo gzip /usr/share/man/man7/Zenity.7
	sudo chmod 777 /bin/Zenity


	sudo mandb

	echo -e "Création des bibliothèques [/bin/x] : [ $green OK $default ]"



	echo -e "Copie du code source vers $storage..."
	sudo cp -R ../$source_files/* /$storage #Copie du code source vers le dosssier de destination
	echo -e "Copie du code source vers $storage : [ $green OK $default ]"

	#Dons des droits
	echo -e "Mise à jour des droits..."
	sudo chmod 777 -R $storage
	echo -e "Mise à jour des droits : [ $green OK $default ]"

	#Si le fichier des logs n'existe pas, on le créer.
	echo -e "Création des fichiers système..."
	if [[ ! -f $storage/$standard_output ]]; then
		touch $storage/$standard_output
	fi

	#Si le fichier des erreurs n'existe pas, on le créer
	if [[ ! -f $storage/$errors_output ]]; then
		touch $storage/$errors_output
	fi
	echo -e "Création des fichiers système : [ $green OK $default ]"


	#Installation de Zenity
	#vérification réseau...
	echo -e "Vérification de l'état du réseau..."
	if [[ $(hostname -I) != "" ]]; then #Si réseau, on installe zenity

		echo -e "État du réseau : [ $green OK $default ]"

		echo -e "Installation de Zip..."
		apt-get install -y zip 2>> $storage/$errors_output >> $storage/$standard_output
		echo -e "Installation de Zip : [ $green OK $default ]"

		echo -e "Installation de Git..."
		apt-get install -y git 2>> $storage/$errors_output >> $storage/$standard_output
		echo -e "Installation de Git : [ $green OK $default ]"

		echo -e "Installation de Gcc..."
		apt-get install -y gcc 2>> $storage/$errors_output >> $storage/$standard_output
		echo -e "Installation de Gcc : [ $green OK $default ]"

		echo -e "Installation de G++..."
		apt-get install -y g++ 2>> $storage/$errors_output >> $storage/$standard_output
		echo -e "Installation de G++ : [ $green OK $default ]"

		echo -e "Installation de Make..."
		apt-get install -y make 2>> $storage/$errors_output >> $storage/$standard_output
		echo -e "Installation de Make : [ $green OK $default ]"

		echo -e "Les commandes de gestion de serveur ont bien été installées. \n Ces commandes sont les suivantes : \n
- server_connect
Initialise une connexion avec le serveur SSH distant\n
- server_restart
Redémarre le serveur SSH distant \n
- server_shutdown
Eteint le serveur SSH distant \n
- server_network
Analyse le réseau local du serveur SSH distant \n
- server_update
Met à jour les logiciels et paquets de la distribution installée sur le serveur SSH distant \n
- server_update
Met à jour la distribution installée sur le serveur SSH distant \n
- server_sync_web
Met à jour le contenu du serveur WEB installé sur le serveur SSH distant \n
- server_informations
Affiche les informations noyau du serveur, le temps de fonctionnement et la température du processeur \n

" 

echo -e "
Gestionnaire de bibliothèque \n
Les bibliothèques ont bien été installées. \n Ces bibliothèques sont les suivantes : \n
- Colors
Permet d'ajouter de la couleur en Bash \n
- Time
Permet de récuperer l'heure, la date et d'autres informations temporelles</i> \n
- Systeme
Eteint le serveur SSH distant\n
- File
Permet de vérifier le contenu d'un dossier \n
- Files
Met à jour les logiciels et paquets de la distribution installée sur le serveur SSH distant\n
- Network
Permet de scanner le réseau et/ou d'attendre une connexion Internet\n
- System
Permet de récuperer des informations sur l'ordinateur \n
" 

	else

		echo -e "État du réseau : [ $red FAIL $default ]"	
		
	fi


else	#Sinon on demande à désinstaller le logiciel

	echo "Le logiciel est déja installé, voulez-vous désisntaller les bibliothèques ? "


	if [[ $(Question "Le logiciel est déja installé, voulez-vous le désinstaller ? \n Cela supprimera l'intégralité des fichiers." 2>> $errors_output) == "1" ]]; then  2>> $errors_output >> $standard_output

		sudo rm -R $storage	#suppression du dossier

		sudo rm /bin/install-softwares 	#Suppression des fichiers de lancement
		sudo rm /bin/add-softwares 
		sudo rm /bin/get-softwares 

		sudo rm /bin/server_connect
		sudo rm /bin/server_network
		sudo rm /bin/server_restart
		sudo rm /bin/server_shutdown
		sudo rm /bin/server_update
		sudo rm /bin/server_upgrade
		sudo rm /bin/server_sync_web
		sudo rm /bin/server_sync_data
		sudo rm /bin/server_informations

		sudo rm /bin/localhost_network
		sudo rm /bin/localhost_restart
		sudo rm /bin/localhost_shutdown
		sudo rm /bin/localhost_update
		sudo rm /bin/localhost_upgrade
		sudo rm /bin/localhost_informations

		sudo rm /bin/createc
		sudo rm /bin/_createc
		sudo rm /bin/createc_filename

		sudo rm /usr/share/man/man7/Time.7.gz
		sudo rm /usr/share/man/man7/Colors.7.gz
		sudo rm /usr/share/man/man7/Satellite.7.gz
		sudo rm /usr/share/man/man7/Files.7.gz
		sudo rm /usr/share/man/man7/Network.7.gz
		sudo rm /usr/share/man/man7/System.7.gz
		sudo rm /usr/share/man/man7/Sound.7.gz
		sudo rm /usr/share/man/man7/Zenity.7.gz


				
		Print "Le logiciel et toute ses dépendances ont été supprimées." 2>> .errors_output

	else

		exit

	fi


fi

