#!/bin/bash
#!/usr/bin/python

import os
import time

# ----------------------------------
# Variables
# ----------------------------------

#Colors
BRED='\033[0;41;30m'
BRED_='\033[0;0;39m'

RED='\033[0;31m'
RED_='\033[0;0m'

GREEN='\033[0;32m'
GREEN_='\033[0m'

BGREEN='\033[42;1;37m'
BGREEN_='\033[0m'


FILE="venv"


VARIABLES = {
    "serverup" : False,
    "pid_server" : 0
}

# ----------------------------------
# Variables
# ----------------------------------

# ----------------------------------
# Execute commands shell -> https://wiki.python.org.br/PythonNoLugarDeShellScript
# ----------------------------------
class Cammand(object):
    def __init__(self, cmd):
        self.cmd = cmd
    def __call__(self, *args):
        return os.system("%s %s" % (self.cmd, " ".join(args)))

class Shell(object):
    def __getattr__(self, attribute):
        return Cammand(attribute)

    def sys(self, cmd):
        self.cmd = str(cmd)
        return os.system(f"{self.cmd}")

sh = Shell()

# ----------------------------------
# Execute commands shell
# ----------------------------------

# ----------------------------------
# Func : Assistants
# ----------------------------------

def clear():
    sh.clear()

def pause():
    input("Pressione [Enter] para continuar...")

def exit_():
    
    exit()

def error():
    print(f"{BRED}Error ...{BRED_}")

# ----------------------------------
# Func : Assistants
# ----------------------------------

# ----------------------------------
# Func : Virtualenv
# ----------------------------------

def create_venv():
    
    if not os.path.isdir(FILE):
        print(f"\n   === CRIANDO UM VIRTUALENV -> python3 -m virtualenv {FILE} ===\n")
        print(sh.python3(f"-m virtualenv {FILE}"))

def start_venv():

    if not os.path.isdir(FILE):
        print("Não existe um Virtualenv aqui ...")
        return

    if not VARIABLES["VIRTUALVENV"]:
        print(f"\n   === ACESSANDO O VIRTUALENV -> source {FILE}/bin/activate ===\n")
        
        print(sh.sys(" ./venv/bin/activate"))
        print(sh.python3("-m pip list"))

        time.sleep(1)
        
        VARIABLES["VIRTUALVENV"] = False
        print("Vitualenv Ativado ...")

def stop_venv():
    
    if VIRTUALVENV:
        print("Interropendo o Virtualenv, por favor aguarde ...")
        
        sh.deactivate()
        VIRTUALVENV=False
        
        print("Pronto ...")

# ----------------------------------
# Func : Virtualenv
# ----------------------------------

# ----------------------------------
# Func : Server
# ----------------------------------

def start_runserver():
    
    # start_venv()

    # if VARIABLES["serverup"]:
    #     stop_runserver()

    if not VARIABLES["serverup"]:
        print("Subindo o Server, por favor aguarde ...")
        sh.python3("manage.py runserver")

        SERVERUP=True

        # time.sleep(1)

        # print(f"{GREEN}Detalhes :{GREEN_}")

        # print(sh.jobs())
        # print(sh.sys("$!"))

        # VARIABLES['pid_server'] = sh.sys("$!")
        # print(f"PID do processo : {VARIABLES['pid_server']}")


def stop_runserver():
    
    if SERVERUP:
        print("Parando o Server, por favor aguarde ...")

        sh.kill(f"-s SIGTERM {APP_PID}")

        time.sleep(3)

        print(sh.jobs())

        print("Pronto ...")

        SERVERUP=False

# ----------------------------------
# Func : Server
# ----------------------------------

# ----------------------------------
# Func : App
# ----------------------------------

def create_app():
    
    # start_venv()

    print( f"\n   {GREEN}=== QUAL O NOME DO NOVO APP DJANGO ? ==={GREEN_}\n")

    while True:

        app_name = input("Insira o nome do app : ")

        if app_name == "":

            print(f"\n    {RED}O nome do app não pode ser vazio ...{RED_}\n")
        
        else:
            choice = input("\nCriar App [Y/n/Q - Quit] : ")

            if choice == "Y":
                sh.python3(f"manage.py startapp {app_name}")
                break

            elif choice == "n":
                ...

            elif choice == "Q":
                return False

            else:
                error()

    print(f"\n   {GREEN}Pronto ...{GREEN_}\n")
    return True

# ----------------------------------
# Func : App
# ----------------------------------

# ----------------------------------
# Func : Project
# ----------------------------------

def create_project():
    
    print(f"\n    {GREEN}=== QUAL O NOME DO PROJETO DJANGO ? ==={GREEN_}\n")

    while True:

        project_name = input("Insira o nome do projeto : ")
        
        if project_name == "":
        
            print(f"\n    {RED}O nome do projeto não pode ser vazio ...{RED_}\n")

        else: 
            choice = input("\nCriar Projeto [Y/n/Q - Quit] : ")

            if choice == "Y":
                sh.sys(f"django-admin startproject {project_name} .")
                break

            elif choice == "n":
                ...

            elif choice == "Q":
                return False

            else:
                error()

    print(f"\n   {GREEN}Pronto ...{GREEN_}\n")
    return True

# ----------------------------------
# Func : Project
# ----------------------------------

# ----------------------------------
# Func : inicialize Django
# ----------------------------------

def inicialize_django():
    # create_venv()
    # start_venv()

    print(f"\n   {GREEN}=== INSTALANDO O DJANGO -> pip install django ==={GREEN_}\n")
    sh.python3("-m pip install django")

    print(f"\n   {GREEN}=== INSTALADOS -> pip list ==={GREEN_}\n")
    sh.python3("-m pip list")

    if not create_project():
        return
    
    start_runserver()
    pause()
    # stop_runserver()

# ----------------------------------
# Func : inicialize Django
# ----------------------------------

# ----------------------------------
# Function to display menus
# ----------------------------------

def show_menu():
    clear()

    print("""
    ==============================
        BEM - VINDO AO JUNGLER
    ==============================
    """)
    
    # if [ $VIRTUALENV == 1 ];
    # then
    #     print  -e "     ${BGREEN}VIRTUALENV UP${STD_BGREEN}     "
    # else
    #     print  -e "     ${BRED}VIRTUALENV DONW${STD_BRED}     "
    # fi
	
    print("""
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~
            - M E N U -       
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1. Django - Instalando e iniciando um projeto
    2. Django - Criar um app

    5. Server - Iniciar/Reload

    0. Exit
    """)

def read_options():
    
    choice = input("Digite uma opção : ")
    
    if choice == "0":
        exit_()
    
    elif choice == "1":
        inicialize_django()
        pause()
    
    elif choice == "2":
        create_app()
        pause()
    
    elif choice == "3":

        pause()
    
    elif choice == "4":
    
        pause()
    
    #SERVER
    elif choice == "5":
        start_runserver()
        pause()
    
    elif choice == "6":
        # stop_runserver()
        pause()
    
    # VENV
    elif choice == "7":
        # create_venv()
        pause()
    
    elif choice == "8":
        # start_venv()
        pause()
    
    elif choice == "9":
        # stop_venv()
        pause()
    
    else:
        error()
        pause()


if __name__ == '__main__':
    while True:
        show_menu()
        read_options()
