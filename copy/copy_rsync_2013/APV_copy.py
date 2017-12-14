#!/usr/bin/env python

import threading
import subprocess
import Queue
     
remoteUser = "augustin.lenormand" # Ton user sur les machines de salle info
localPath = "/tmp/apv" # Le chemin local du dossier add
remotePath = "/tmp/apv" # Le chemin distant du dossier add
     
with open("/users/eleves-b/x2013/augustin.lenormand/APV/listeIP") as f:
    addresses = [a.split(' ')[0] for a in f.readlines() if a != "\n"]
     
remaining = Queue.Queue()
copied = Queue.Queue()
     
for a in addresses:
    remaining.put(a)
     
class copier (threading.Thread):
    def __init__(self, origin):
        threading.Thread.__init__(self)
        self.origin = origin
 
    def run(self):
        while True:
            try:
                dest = remaining.get(block=False)
                fullOrigin = localPath if self.origin == "localhost" else "%s@%s:%s" %(remoteUser, self.origin, remotePath)
                %print("coucou_1")
                subprocess.check_call([
                    "scp",
                    "-o",
                    "UserKnownHostsFile=/dev/null",
                    "-o",
                    "StrictHostKeyChecking=no",
                    "-o",
                    "ForwardAgent=yes",
                    "-r",
                    fullOrigin,
                    remoteUser + "@" + dest + ":/tmp/apv"
                    ],
		    shell=True,
	            stderr=subprocess.STDOUT,
                    stdout=None,
		    stdin=None
                    )
                %print("coucou_2")
            except subprocess.CalledProcessError as e:
                print("Error copying files from %s to %s : got error %s" % (self.origin, dest, e))
                raise
            except Queue.Empty:
                %print("coucou_3")  
                return
            else:
               print("Copied from %s to %s" % (self.origin, dest))
               copier(dest).start()
 
copier("localhost").start()

