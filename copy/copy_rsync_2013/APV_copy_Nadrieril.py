    #!/usr/bin/env python3
    import threading
    import subprocess
    import queue
    import socket
     
    remoteUser = "guillaume.boisseau" # Ton user sur les machines de salle info
    localPatha = "/users/misc-a/PX2K13/" # Le chemin local du dossier add
    localPathb = "/users/misc-b/PX2K13/"
    remotePath = "/tmp/apv/" # Ou copier le dossier ADD sur chaque machine
     
    with open("ordis.txt") as f: # recupere la list des hostnames des machines
       addresses = [a.strip() for a in f.readlines() if a != "\n"]
     
    # addresses = ["niva", "lada", "maserati", "mazda"]
    # addresses = ["niva"]
     
     
    remaining = queue.Queue()
    copied = queue.Queue()
     
    for a in addresses:
       remaining.put(a)
     
     
    def exec_dist_command(host, cmd):
       fullhost = "%s@%s" % (remoteUser, host)
       subprocess.check_call([
           "ssh",
           "-o UserKnownHostsFile=known_hosts",
           "-o StrictHostKeyChecking=no",
           "-o ForwardAgent=yes",
           fullhost,
           "sh",
           "-c '"+cmd+"'"
           ],
           shell=False,
           stderr=subprocess.STDOUT,
           stdout=subprocess.PIPE,
           stdin=subprocess.PIPE
       )
     
    def exec_dist_rsync(host, src, target):
       exec_dist_command(host, "~/rsync -ah --partial --info=progress2 "+src+" "+target+" 2>&1 >> /tmp/apv/progress.log")
     
     
    # A lancer depuis n'importe quel ordi. Le script va ssh sur les machines de salle info en tant que l'utilisateur spécifié
    # Si host1 est le nom d'une machine qui a déjà en local les fichiers de l'add,
    # copier(host1).start() va lancer un thread qui va choisir un host2 qui n'a pas encore les fichiers et va rsync les fichiers de host1 à host2.
    # Il va ensuite lancer copier(host2).start(), pour que host2 propage les fichiers à son tour, et host1 va recommencer jusqu'à ce que toutes les machines aient les fichiers
    # Vu qu'on utilise rsync, stopper le script au milieu et le relancer ne pose pas de problèmes.
    # "locala" et "localb" sont des noms d'host spéciaux, qui au lieu de copier les fichiers depuis le /tmp/apv/ d'une machine,
    # va copier les fichiers depuis localPatha ou localPathb, qui sont normalement des dossiers réseau accessibles à toutes les machines de salle info.
    class copier(threading.Thread):
       def __init__(self, origin):
           threading.Thread.__init__(self)
           self.origin = origin
     
       def run(self):
           while True:
               try:
                   host = remaining.get(block=False)
                   print("Started copy from %s to %s" % (self.origin, host))
     
                   if self.origin == "locala":
                       exec_dist_rsync(host, localPatha, remotePath)
                   elif self.origin == "localb":
                       exec_dist_rsync(host, localPathb, remotePath)
                   else:
                       exec_dist_rsync(self.origin, remotePath, "%s@%s:%s" % (remoteUser, host, remotePath))
                   exec_dist_command(host, "chmod -R o+rx "+remotePath)
     
               except subprocess.CalledProcessError as e:
                   print("Error copying files from %s to %s : got error %s" % (self.origin, dest, e))
                   raise
               except queue.Empty:
                   return
               else:
                  print("Copied from %s to %s" % (self.origin, host))
                  copier(host).start()
     
    copier("locala").start()
    copier("localb").start()
