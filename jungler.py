# commands terminal
def clear():
    ...

def pause():
    input("Pressione [Enter] para continuar...")

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
    6. Server - Parar

    7. VirtualEnv - Criar"
    8. VirtualEnv - Ativar"
    9. VirtualEnv - Desativar"

    10. Ajuda"switch

    0. Exit
    """)

def read_options():
    
    choice = input("Digite uma opção : ")
    
    if choice == 0:
        ...
    
    elif choice == 1:
        ...
    
    elif choice == 2:
        ...
    
    else:
        print("Error ...")
        pause()


if __name__ == '__main__':
    while True:
        show_menu()
        read_options()
