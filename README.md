# APV-utilities
Scripts divers utiles à l'APV d'une année à l'autre, mis en place par l'APV2013, mis à jour par l'APV2014.

## APV-Encoder

Le script `encoder/APV-Encoder.sh` nécessite d'avoir installé `ffmpeg` et `ffprobe` (version supérieure à 2.7.2). Le principe de l'encodage est décrit [ici](http://wikix.polytechnique.org/APV/Dossier_de_passation/Encodage). Le script s'utilise de la manière suivante :

    ./APV-Encoder.sh <chemin vers le dossier à encoder> <taille finale désirée en Mo>

À noter que le script n'encode que les vidéos déjà au format `.mp4`.

## APV-PosterExtractor

Une des tâches les plus chronophages est de générer les menus des projections car il faut donner un titre et un poster à chaque vidéo. Un script permet de semi-automatiser le travail, c'est `posters/APV-PosterExtractor.sh` qui nécessite d'avoir installé VLC, `ffmpeg` et ImageMagick (commande `convert`). Il s'utilise par la commande suivante sur un dossier contenant la projection dont on veut générer le menu :

    ./APV-PosterExtractor.sh <nom du dossier de la projection>

Le script parcoure toutes les vidéos `.mp4` do dossier et pour chacune :
* lance sa lecture dans VLC ;
* demande sur un prompt le timestamp (au format `mm:ss`) de la frame que l'on veut utiliser comme poster ;
* demande sur un prompt le titre de la vidéo telle qu'il apparaîtra dans le menu.

À partir de cela, le script génère dans le dossier de la projection un dossier `posters` contenant les images extraites redimensionnées et un fichier `.json` contenant pour chaque vidéo l'objet :

    {
      "poster": "<nom du fichier du poster>",
      "src": "<nom du fichier de la vidéo>",
      "title": "<titre de la vidéo>"
    };

Les valeurs des champs `poster` et `src` sont les mêmes à la différence de l'extension : `.mp4` pour `src`, `.png` pour `poster`.

Une fois le dossier de vidéos terminé, il ne reste plus qu'à copier-coller le dossier de posters dans `source/images/posters/<nom de la projection>/` et inclure le contenu du fichier `.json` dans la propriété `video` de l'objet projection désiré dans `source/data/videos.js`.

### APV-Copy

Le dossier `copy` contient tous les scripts nécessaires à la mise en place d'une copie massive de l'APV sur des clés USB branchées sur les 150 ordis des salles infos de l'X. Se référer à  pour plus de détails,

#### copy_rsync_2013
Contient les scripts utilisés par l'APV 2013. Ils utilisent `rsync` pour la copie ainsi qu'un script de diffusion logarithmique du contenu. La copie prend plusieurs jours sur les ordinateurs des salles info. Les auteurs sont Augustin Lenormand et Guillaume Boisseau.

#### copy_dd_
Contient les scripts utilisés par l'APV 2014 (`/bin`) ainsi que divers fichiers de logs et tests qui peuvent valoir le coup d'être lus. La copie utilise `dd` au lieu de `rsync`, et est beaucoup plus rapide mais aussi un peu plus délicate à utiliser. Les scripts à regaredr en priorité sont les `prepare*.sh` et `copy.sh`. L'auteur est Guillaume Didier.
