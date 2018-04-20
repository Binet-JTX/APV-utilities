#! /bin/bash

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

welcome_message() {
    clear
    echo "\
=========================================================
======= Patch ADD pour l' APV 2013 : v1.0 -> v1.1 =======
=========================================================
Afin de mettre à jour les fichiers de ton APV, indique
l'emplacement où est montée ta clé USB (ou l'emplacement)
du dossier de l'APV sur ton disque dur.
Le patch de l'APV nécessite 7,2 Go d'espace supplémentaire
sur la clé USB ou le disque dur où est stocké l'APV, vérifie
la place restante avant de lancer le patch. Appuie sur Ctrl+C
pour quitter le patch.
Pour connaître l'emplacement, rends-toi dans le dossier
de l'APV avec ton explorateur de fichiers (là où est le
fichier 'APV_2013.html'). Appuie ensuite sur CTRL+L pour
que l'emplacement s'affiche et copie-colle le ci-dessous.
"
    choose_apv_dir
}

choose_apv_dir() {
    read -p "Emplacement : " apv_dir
    echo ""
    if [ -e $apv_dir/APV_2013.html ]
    then
        copy_files $apv_dir
        end_message
    else
        wrong_location_APV
    fi
}

wrong_location_APV() {
    echo "\
L'emplacement que tu as choisi ne contient pas l'APV.
Cela devrait ressembler à '/media/utilisateur/APV2013' si
tu utilises la clé USB.
"
choose_apv_dir
}

copy_files() {
    apv_dir=$1

	printf "Début de la mise à jour...\n\n"

    printf "Correction du son sur les interviews...\n"
    rsync -azhr --info=progress2 "$script_dir/contents/Interviews/" "$apv_dir/04-Interviews/"
    tput cuu 2
    tput ed
    printf "Correction du son sur les interviews...     [OK]\n"

    printf "Copie des vidéos de l'ADD...\n"
    rsync -azhr --info=progress2 "$script_dir/contents/ADD/" "$apv_dir/08-ADD/"
    tput cuu 2
    tput ed
    printf "Copie des vidéos de l'ADD...                [OK]\n"

    printf "Copie des bonus supplémentaires...\n"
    rsync -azhr --info=progress2 "$script_dir/contents/Bonus-officiel/" "$apv_dir/07-Bonus/Bonus-JTX/"
    rsync -azhr "$script_dir/contents/Bonus-cache/" "$apv_dir/source/js/utils/" > /dev/null
    tput cuu 2
    tput ed
    printf "Copie des bonus supplémentaire...           [OK]\n"

    printf "Copie des vidéos des écoles d'officiers...\n"
    rsync -azhr --info=progress2 "$script_dir/contents/Proj_gendarmerie/" "$apv_dir/02-Vie_de_promo/2013-11_Ecole_officiers/2013-11_EOGN/"
    rsync -azhr --info=progress2 "$script_dir/contents/Theatre_Coet/" "$apv_dir/02-Vie_de_promo/2013-11_Ecole_officiers/2013-11_Coet/"
    rsync -azhr --info=progress2 "$script_dir/contents/Vaneau_navale/" "$apv_dir/02-Vie_de_promo/2013-11_Ecole_officiers/2013-11_Navale/"
    tput cuu 5
    tput ed
    printf "Copie des vidéos des écoles d'officiers...  [OK]\n"

    printf "Copie des nouveaux clips binets...\n"
    rsync -azhr --info=progress2 "$script_dir/contents/Binets/" "$apv_dir/05-Binets/"
    tput cuu 2
    tput ed
    printf "Copie des nouveaux clips binets...          [OK]\n"

    printf "Copie de la campagne Kès des 2014...\n"
    rsync -azhr --info=progress2 "$script_dir/contents/Campagne_Kes_X2014/" "$apv_dir/02-Vie_de_promo/2015-11_Campagne_Kes_X2014/"
	tput cuu 2
    tput ed
    printf "Copie de la campagne Kès des 2014...        [OK]\n"

    printf "Copie des nouveaux menus de présentation...\n"
    rsync -azhr --info=progress2 "$script_dir/contents/source/" "$apv_dir/source/"
    tput cuu 2
    tput ed
    printf "Copie des nouveaux menus de présentation... [OK]\n"
}

end_message () {
    echo "\
La mise à jour de l'APV est terminée !"
}

#Main execution
welcome_message
