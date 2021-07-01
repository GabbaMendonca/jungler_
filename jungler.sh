#!/bin/bash
# O Jungler é um mini-gerenciador para o Django
# ----------------------------------
# Variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd

# Color
BRED='\033[0;41;30m'
STD_BRED='\033[0;0;39m'

GREEN='\033[0;32m'
STD_GREEN='\033[0m'

BGREEN='\033[42;1;37m'
STD_BGREEN='\033[0m'

# patch
FILE=venv


VIRTUALENV=0
SERVEUP=0
APP_PID=0

# ----------------------------------
# Function
# ----------------------------------

help_create_app(){

    echo ""
    echo -e "Em ${BGREEN}setting.py${STD_BGREEN}"
    echo ""
    echo -e "${GREEN}Passo 1 : Regirtra o App${STD_GREEN}"
    echo ""
    echo -e "No arquivo ${BGREEN}setting.py${STD_BGREEN} registrar o app"
    echo ""
    echo ""
    echo "  INSTALLED_APPS = [  "
    echo -e "    '${GREEN}${nome_do_projeto}.apps.${nome_do_projeto}Config${STD_GREEN}',"
    echo "]"
    echo ""
    echo ""
    echo "O nome deve estar igual o da"
    echo -e "classe que esta no arquivo ${BGREEN}apps.py${STD_BGREEN}"
    echo "Não esquecer que o nome da deve ter a primeira letra maiuscula"
    echo ""

    pause
    
    echo ""
    echo -e "Em ${BGREEN}url.py${STD_BGREEN}"
    echo ""
    echo -e "${GREEN}Passo 2 : Configurar a rota${STD_GREEN}"
    echo ""
    echo -e "No arquivo ${BGREEN}url.py${STD_BGREEN} adicionar o include"
    echo ""
    echo ""
    echo -e "    ${GREEN}from django.urls import path, ${BGREEN}include${STD_BGREEN}${STD_GREEN}"
    echo ""
    echo ""
    echo "Configurar a URL"
    echo ""
    echo ""
    echo -e "    ${GREEN}path('${nome_do_projeto}/', include('${nome_do_projeto}.urls')),${STD_GREEN}"
    echo ""

    pause

    echo ""
    echo -e "Em ${BGREEN} ${nome_do_projeto} ${STD_BGREEN}"
    echo ""
    echo -e "${GREEN}Passo 3 : Criando o arquivo url.py${STD_GREEN}"
    echo ""
    echo -e "No app criado ${BGREEN}${nome_do_projeto}${STD_BGREEN} adicionar o arquivo ${BGREEN}urls.py${STD_BGREEN}"
    echo ""
    echo "Inserir os import's"
    echo ""
    echo -e "${GREEN}from django.urls import path${STD_GREEN}"
    echo -e "${GREEN}from . import views${STD_GREEN}"
    echo ""
    echo -e "${GREEN}urlpatterns = [${STD_GREEN}"
    echo -e "    ${GREEN}path('', views.index)${STD_GREEN}"
    echo -e "${GREEN}]${STD_GREEN}"
    echo ""
    echo "  Path('nome_da_url_filha', direciona_para_ a_view.py)"
    echo ""

    pause

    echo ""
    echo -e "Em ${BGREEN} ${nome_do_projeto}/views.py${STD_BGREEN}"
    echo ""
    echo -e "${GREEN}Passo 4 : Configurando a view${STD_GREEN}"
    echo ""
    echo -e "Alterar o arquivo ${BGREEN}views.py${STD_BGREEN}"
    echo ""
    echo -e "${GREEN}def index(request):${STD_GREEN}"
    echo -e "    ${GREEN}return render(request, '${nome_do_projeto}/index.html')${STD_GREEN}"
    echo ""

    pause

    echo ""
    echo -e "Em ${BGREEN}${nome_do_projeto}${STD_BGREEN}"
    echo ""
    echo -e "${GREEN}Passo 5 : Criando o template${STD_GREEN}"
    echo ""
    echo -e "Criar uma pasta chamada : ${BGREEN}templates${STD_BGREEN}"
    echo -e "Dentro de ${BGREEN}templates${STD_BGREEN} criar uma pasta com o nome do app ${nome_do_projeto}"
    echo "Dentro dela criar a pagina html. (index)"
    echo ""
    echo "|app"
    echo "├── templates"
    echo "│   └── ${nome_do_projeto}"
    echo "│       └── index.html "
    echo ""

}

# ----------------------------------
# Function
# ----------------------------------

pause(){
    read -p "Pressione [Enter] para continuar..." fackEnterKey
}

exit_(){

    stop_runserver
    stop_venv

    exit 0
}

# ----------------------------------
# Func : Virtualenv
# ----------------------------------

create_venv() {
    
    if [ -e !"$FILE" ] ;
    then

        python3 -m virtualenv venv

    fi
    
}

start_venv(){
    
    if [ -e !"$FILE" ] ;
    then

        echo -e "${BRED}Não existe um Virtualenv aqui ...${STD_BRED}"
        return

    fi

    if [ $VIRTUALENV == 0 ];
    then

        source venv/bin/activate

        sleep 1

        VIRTUALENV=1
        echo -e "${GREEN}Vitualenv Ativado ...${STD_GREEN}"

    fi
}

stop_venv() {

    if [ $VIRTUALENV == 1 ];
    then

        echo ""
        echo -e "${GREEN}Interropendo o Virtualenv, por favor aguarde ...${STD_GREEN}"
        
        deactivate
        VIRTUALENV=0
        
        echo "" 
        echo -e "${GREEN}Pronto ...${STD_GREEN}"

    fi
}

# ----------------------------------
# Func : Virtualenv
# ----------------------------------

# ----------------------------------
# Func : Server
# ----------------------------------

start_runserver(){
    
    start_venv

    if [ $SERVEUP == 1 ];
    then

        stop_runserver
        
    fi

    if [ $SERVEUP == 0 ];
    then

        echo ""
        echo -e "${GREEN}Subindo o Server, por favor aguarde ...${STD_GREEN}"
        python3 manage.py runserver &

        sleep 1

        echo ""
        echo -e "${GREEN}Detalhes :${STD_GREEN}"
        echo ""

        jobs
        echo "PID do processo : " $!
        
        export APP_PID=$!

        SERVEUP=1

    fi
    
}

stop_runserver(){

    if [ $SERVEUP == 1 ];
    then

        echo ""
        echo -e "${GREEN}Parando o Server, por favor aguarde ...${STD_GREEN}"

        kill -s SIGTERM $APP_PID
            sleep 3

        echo ""

        jobs

        echo "" 
        echo -e "${GREEN}Pronto ...${STD_GREEN}"

        SERVEUP=0

    fi

}

# ----------------------------------
# Func : Server
# ----------------------------------

# ----------------------------------
# Func : Contem as iniciais padrão para inicialiazar o Django
# ----------------------------------

init(){
        
    echo ""
	echo -e "  === ${GREEN}CRIANDO UM VIRTUAL VENV -> python3 -m virtualenv venv${STD_GREEN} ==="
    echo ""
    
    create_venv

    echo ""	
	echo -e "  === ${GREEN}ACESSANDO O VENV -> source venv/bin/activate${STD_GREEN} ==="
    echo ""

    start_venv

    echo ""
	echo -e "  === ${GREEN}INSTALANDO O DJANGO -> pip install django${STD_GREEN} ==="
    echo ""

    pip install django

    echo ""
	echo -e "  === ${GREEN}INSTALADOS -> pip list${STD_GREEN} ==="
	echo ""

    pip list


    echo ""	
    echo -e "  === ${GREEN}QUAL O NOME DO PROJETO DJANGO ?${STD_GREEN} ==="
    echo ""	

    create_project

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
        exit_

}

# ----------------------------------
# Func : App
# ----------------------------------

create_app(){

    start_venv

    while true
    do

        echo ""	
        echo -e "  === ${GREEN}QUAL O NOME DO NOVO APP DJANGO ?${STD_GREEN} ==="
        echo ""	

        local nome_do_projeto
        read -p "Insira o nome do app : " nome_do_projeto

        echo ""

        local opc_confirma
        read -p "Criar App [Y/n/Q - Quit] : " opc_confirma
 
        case $opc_confirma in
            'Y')
                python3 manage.py startapp $nome_do_projeto
                break
            ;;
            'n') ;;
            
            'Q') return ;;

            *) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
        esac
	
    done

    echo "" 
    echo -e "${GREEN}Pronto ...${STD_GREEN}"

    pause
    
    case $opc_confirma in
        'Y')
            
            help_create_app

        ;;
        'n') ;;

        *) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
    esac

    pause

}

# ----------------------------------
# Func : App
# ----------------------------------

# ----------------------------------
# Func : Project
# ----------------------------------
 
create_project(){
	
    while true
    do

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

            *) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
        esac
	
    done

}

# ----------------------------------
# Func : Project
# ----------------------------------


testando(){
    python3 script.py

    FILE=venv
    
    if [ -e !"$FILE" ] ; then
        echo "o arquivo bbb existe"
    else
        echo "o arquivo bbb não existe"
    fi

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
        echo -e "     ${BGREEN}VIRTUALENV UP${STD_BGREEN}     "
    else
        echo -e "     ${BRED}VIRTUALENV DONW${STD_BRED}     "
    fi
	
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo "       - M E N U -       "
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "  1. Django - Instalando e iniciando um projeto"
	echo "  2. Django - Criar um app"
    echo "" 
	echo "  5. Server - Iniciar/Reload"
	echo "  6. Server - Parar"
    echo "" 
	echo "  7. VirtualEnv - Criar"
	echo "  8. VirtualEnv - Ativar"
	echo "  9. VirtualEnv - Desativar"
    echo "" 
	echo "  10. Ajuda"
    echo "" 
	echo "  0. Exit"
}

read_options(){
	local choice
	read -p "Digite uma opção : " choice
	case $choice in
		0) exit_ ;;
        
        1) init ;;
		2) create_app ;;
		3) testando ;;

		# Server
        5) 
            start_runserver
            pause 
        ;;
        6)
            stop_runserver
            pause
        ;;

        # Venv
        7) 
            create_venv
            pause
        ;;
        8) 
            start_venv
            pause
        ;;
        9) 
            stop_venv
            pause
        ;;

        10) help_create_app ;;


		*) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 
# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
    
	show_menus
	read_options
done