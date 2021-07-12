# #!/usr/bin/env python
# # Desenvolvimento Aberto
# # shell.py
 
# # Importar modulo do sistema operacional
# import os
 
# # Usa o comando do shell ls
# #Apaga a tela
# os.system("pip list")


# print(os.path.exists("venv"))

import shutil, tempfile


encontrado = False

with open('gabba/settings.py', 'r+') as arquivo, \
    tempfile.NamedTemporaryFile('w', delete=False) as out:
    
    for linha in arquivo:

        if linha.find("INSTALLED_APPS") >= 0:

            encontrado = True

            out.write(str(linha))

        else:
            
            if encontrado:

                if linha.find("]") >= 0:

                    out.write("    'gabba',\n" )
                    out.write("]\n")
                    
                    encontrado = False

                else:

                    out.write(str(linha))

            else:


                out.write(str(linha))


shutil.move(out.name, 'gabba/testando.py')