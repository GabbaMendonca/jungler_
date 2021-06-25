#!/bin/bash
# O Jungler é um mini-gerenciador para o Django
# ----------------------------------
# Variables
# ----------------------------------
EDITOR=vim
PASSWD=/etc/passwd
BRED='\033[0;41;30m'
STD_BRED='\033[0;0;39m'


GREEN='\033[0;32m'
STD_GREEN='\033[0m'

BGREEN='\033[42;1;37m'
STD_BGREEN='\033[0m'


VIRTUALENV=0
SERVEUP=0
APP_PID

# ----------------------------------
# Function
# ----------------------------------
pause(){
  read -p "Pressione [Enter] para continuar..." fackEnterKey
}

# ----------------------------------
# Func : Virtualenv
# ----------------------------------

init_venv(){

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
# Func : Server
# ----------------------------------

runserver(){
    
    init_venv

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

exit_(){

    stop_runserver
    stop_venv

    exit 0
}


# ----------------------------------
# Func : Contem as iniciais padrão para inicialiazar o Django
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

            *) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
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
        exit_

}

create_app(){

    while true
    do

        echo ""	
        echo -e "  === ${GREEN}QUAL O NOME DO NOVO APP DJANGO ?${STD_GREEN} ==="
        echo ""	

        local nome_do_projeto
        read -p "Insira o nome do app : " nome_do_projeto

        echo ""

        local opc_confirma
        read -p "Criar App [Y/n] : " opc_confirma
 
        case $opc_confirma in
            'Y')
                python3 manage.py startapp $nome_do_projeto
                break
            ;;
            'n') break ;;

            *) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
        esac
	
    done

    echo "" 
    echo -e "${GREEN}Pronto ...${STD_GREEN}"

    pause

    read -p "Deseja ver as orientações de ajuda para instalar o app ? [Y/n] : " opc_confirma

    case $opc_confirma in
        'Y')
            
            echo ""
            echo -e "${GREEN}Regirtra o App${STD_GREEN}"
            echo ""
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
            echo ""

            pause
            
            echo ""
            echo -e "${GREEN}Configura a rota${STD_GREEN}"
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
            echo -e "No app criado ${nome_do_projeto} ${BGREEN}adicionar ${STD_BGREEN}o arquivo ${BGREEN}urls.py${STD_BGREEN}"
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
            echo "  Path('nome_da_url_filha', arquivo_para _onde_ser_direcionado_a_chamada)"
            echo ""

            pause

            echo ""
            echo -e "Alterar o arquivo ${BGREEN}views.py${STD_BGREEN}"
            echo ""
            echo -e "${GREEN}def index(request):${STD_GREEN}"
            echo -e "    ${GREEN}return render(request, '${nome_do_projeto}/index.html')${STD_GREEN}"
            echo ""

            pause

            echo ""
            echo -e "Criar uma pasta chamada : ${BGREEN}templates${STD_BGREEN}"
            echo -e "Dentro de ${BGREEN}templates${STD_BGREEN} criar uma pasta com o nome do app ${nome_do_projeto}"
            echo "Dentro dela criar a pagina html. (index)"
            echo ""
            echo "|app"
            echo "├── templates"
            echo "│   └── page/app "
            echo "│       └── index.html "
            echo ""

        ;;
        'n') ;;

        *) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
    esac

    pause

}
 

# ----------------------------------
# Func One : Contem as iniciais padrão para inicialiazar o Django
# ----------------------------------

create_project(){
	
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

            *) echo -e "${BRED}Error...${STD_BRED}" && sleep 2
        esac
	
    done    
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
	echo "  1. Instalando e iniciando um projeto Django"
	echo "  2. Criar um app"
    echo "" 
	echo "  5. Subir/Reload Servidor de teste"
	echo "  6. Parar Servidor de teste"
    echo "" 
	echo "  8. Ativa o VirtualEnv"
	echo "  9. Desativa o VirtualEnv"
    echo "" 
	echo "  0. Exit"
}

read_options(){
	local choice
	read -p "Enter choice [ 1 - 3 ] " choice
	case $choice in
		0) exit_ ;;
        
        1) init ;;
		2) create_app ;;

		# Server
        5) 
            runserver
            pause 
        ;;
        6)
            stop_runserver
            pause
        ;;

        # Venv
        8) 
            init_venv
            pause
        ;;
        9) 
            stop_venv
            pause
        ;;


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