#! /bin/bash
# Crédits à Denis Merigoux pour le script

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

welcome_message() {
    clear
    echo "\
=========================================================
======= Patch ADD pour l' APV 2014 : v1.0 -> v1.1 =======
=========================================================
Afin de mettre à jour les fichiers de ton APV, indique
l'emplacement où est montée ta clé USB (ou l'emplacement)
du dossier de l'APV sur ton disque dur.
Le patch de l'APV nécessite 9 Go d'espace supplémentaire
sur la clé USB ou le disque dur où est stocké l'APV, vérifie
la place restante avant de lancer le patch. Appuie sur Ctrl+C
pour quitter le patch.
Pour connaître l'emplacement, rends-toi dans le dossier
de l'APV avec ton explorateur de fichiers (là où est le
fichier 'APV_2014.html'). Appuie ensuite sur CTRL+L pour
que l'emplacement s'affiche et copie-colle le ci-dessous.
"
    choose_apv_dir
}

choose_apv_dir() {
    read -p "Emplacement : " apv_dir
    echo ""
    if [ -e $apv_dir/APV_2014.html ]
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
Cela devrait ressembler à '/media/utilisateur/APV2014' si
tu utilises la clé USB.
"
choose_apv_dir
}

copy_files() {
    apv_dir=$1

	printf "Début de la mise à jour...\n\n"

    printf "Correction de bugs mineurs...\n"
    rsync -azhr "$script_dir/contents/EOGN/" "$apv_dir/02_Vie_de_Promo/03_Ecoles_d_Officiers/EOGN/"
    rsync -azhr "$script_dir/contents/juin2013/" "$apv_dir/01_Projections_JTX/01_JTX2013_juin/"
    tput cuu 2
    tput ed
    printf "Correction de bugs mineurs...               [OK]\n"

    printf "Copie des bonus supplémentaires...\n"
    rsync -azhr "$script_dir/contents/bonusdivers/" "$apv_dir/07_Bonus/03_Divers/"
    rsync -azhr "$script_dir/contents/src/" "$apv_dir/source/js/utils/src" > /dev/null
    tput cuu 2
    tput ed
    printf "Copie des bonus supplémentaire...           [OK]\n"

    printf "Copie du TSGED 2017...\n"
    rsync -azhr "$script_dir/contents/TSGED/" "$apv_dir/02_Vie_de_Promo/19_TSGED_2017/"
    tput cuu 2
    tput ed
    printf "Copie du TSGED 2017...                      [OK]\n"

    printf "Copie des vidéos de l'ADD...\n"
    rsync -azhr "$script_dir/contents/ADD/" "$apv_dir/06_Amphi_de_Depart/"
    tput cuu 2
    tput ed
    printf "Copie des vidéos de l'ADD...                [OK]\n"

    printf "Copie des nouveaux spectacles et confs...\n"
    rsync -azhr "$script_dir/contents/spectacles/" "$apv_dir/03_Evenements/01_Spectacles"
    rsync -azhr "$script_dir/contents/concerts/" "$apv_dir/03_Evenements/02_Concerts"
    rsync -azhr "$script_dir/contents/confs/" "$apv_dir/03_Evenements/03_Conferences"
    tput cuu 2
    tput ed
    printf "Copie des nouveaux spectacles et confs...   [OK]\n"

    printf "Copie des nouveaux menus de présentation...\n"
    rsync -azhr "$script_dir/contents/source/" "$apv_dir/source/"
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
