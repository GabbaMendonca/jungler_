#!/bin/bash
# O Jungler é um mini-gerenciador para o Django
# ----------------------------------
# Variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD_RED='\033[0;0;39m'

GREEN='\033[0;32m'
STD_GREEN='\033[0m'

BGREEN='\033[42;1;37m'
STD_BGREEN='\033[0m'


VIRTUALENV=0
APP_PID

# ----------------------------------
# Function
# ----------------------------------
pause(){
  read -p "Pressione [Enter] para continuar..." fackEnterKey
}

# ----------------------------------
# Func One : Contem as iniciais padrão para inicialiazar o Django
# ----------------------------------

init(){
        
    echo ""
	echo -e "  === ${GREEN}CRIANDO UM VIRTUAL VENV -> python3 -m virtualenv venv${STD_GREEN} ==="
    echo ""

	python3 -m virtualenv venv

    echo ""	
	echo -e "  === ${GREEN}ACESSANDO O VENV -> source venv/bin/activate${STD_GREEN} ==="
    echo ""

    source venv/bin/activate

    echo ""
	echo -e "  === ${GREEN}INSTALANDO O DJANGO -> pip install django${STD_GREEN} ==="
    echo ""

    pip install django

    echo ""
	echo -e "  === ${GREEN}INSTALADOS -> pip list${STD_GREEN} ==="
	echo ""

    pip list

    while true
    do

        echo ""	
        echo -e "  === ${GREEN}QUAL O NOME DO PROJETO DJANGO ?${STD_GREEN} ==="
        echo ""	

        local nome_do_projeto
        read -p "Insira o nome do projeto : " nome_do_projeto

        echo ""

        local opc_confirma
        read -p "Confirmar nome do projeto [Y/n] : " opc_confirma
 
        case $opc_confirma in
            'Y') 
                django-admin startproject $nome_do_projeto .
                break
            ;;
            'n') ;;

            *) echo -e "${RED}Error...${STD_RED}" && sleep 2
        esac
	
    done

    echo ""
	echo -e "  === ${GREEN}TUDO PRONTO ! VAMOS TESTAR ? -> python manage.py runserver${STD_GREEN} ==="
    echo ""

    python3 manage.py runserver &

    sleep 1

    echo ""
    echo -e "${GREEN}Detalhes :${STD_GREEN}"
    echo ""

    jobs
    echo "PID do processo : " $!
    
    export APP_PID=$!


    echo "" 
    echo -e "${BGREEN}Verifique se o Django esta funcionando no navegador ...${STD_BGREEN}"
    read -p "Depois pressione [Enter] para continuar..." fackEnterKey

    echo "" 
    echo -e "${GREEN}Interropendo o Django, por favor aguarde ...${STD_GREEN}"

    kill -s SIGTERM $APP_PID
    sleep 3

    echo ""

    jobs

    echo "" 
    echo -e "${GREEN}Pronto ...${STD_GREEN}"

        pause
        exit 0

}
 

# ----------------------------------
# Func One : Contem as iniciais padrão para inicialiazar o Django
# ----------------------------------

two(){
	
    while true
    do

        echo "  Insira o nome do projeto "

        local nome_do_projeto
        read nome_do_projeto

        local opc_confirma
        read -p "Confirmar nome do projeto [Y/n]" opc_confirma
 
        case $opc_confirma in
            'Y') 
                django-admin startproject $nome_do_projeto.
                break
            ;;
            'n') ;;

            *) echo -e "${RED}Error...${STD}" && sleep 2
        esac
	
    done    
        pause
}

tree(){
    python3 manage.py runserver &

    sleep 2

    jobs
    echo $!
    export APP_PID=$!
    echo $APP_PID
        pause
}

four(){

    jobs
    echo $APP_PID
    kill -s SIGTERM $APP_PID
    sleep 3
    jobs
    pause
}



nine(){
    source venv/bin/activate

    VIRTUALENV=1
    
    echo -e "${RED}ENV${STD}"
        pause
}
 
# function to display menus
show_menus() {
	clear
    

    echo "========================="	
	echo "  BEM - VINDO AO JUNGLER"
	echo "========================="
    
    if [ $VIRTUALENV == 1 ];
    then
        echo -e "     ${RED}VIRTUALENV${STD_RED}     "
    else
        echo ""     
    fi
	
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo "       - M E N U -       "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "  1. Instalando e iniciando um projeto Django"
    echo "" 
	echo "  2. Criar um projeto"
	echo "  9. Entar no VirtualEnv"
    echo "" 
	echo "  0. Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3 ] " choice
	case $choice in
		0) exit 0;;
        
        1) init ;;
		2) two ;;
		3) tree ;;
		4) four ;;
        9) nine ;;
		*) echo -e "${RED}Error...${STD_RED}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
# trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
    
	show_menus
	read_options
done