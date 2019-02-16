import system
import os
import re

let dirs = ["/usr/share/applications", "~/.local/share/applications"]
let namePattern = re("Name=(.*)")
let execPattern = re("Exec=(.*)")
let argPattern = re("%([a-z]|[A-Z])")

createDir("./execs")

for dir in dirs:
  if not dir.dirExists:
    continue
  
  for filePath in dir.walkDir():
    if not filePath.path.fileExists(): continue
    let file = filePath.path.open().readAll();
    var name, exec: string
    
    var matches: array[1, string]
    if file.find(namePattern, matches) == -1: continue
    name = matches[0]
    if name.len == 0: continue
    if file.find(execPattern, matches) == -1: continue
    exec = matches[0]
    if exec.len == 0: continue
    exec = exec.replace(argPattern, "")
    
    echo "Found app '", name, "' with exec '", exec, "'"
    var execFile = open("./execs/" & name, fmWrite)
    execFile.write(exec)
    execFile.close()



    
