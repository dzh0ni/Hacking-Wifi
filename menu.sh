#!/bin/bash
#====================================================
#   SCRIPT:                   Kali linux - drivers and tools checker
#   DESARROLLADO POR:         Jony Rivera (Dzhoni)
#   FECHA DE ACTUALIZACIÓN:   07-05-2024  
#   CONTACTO POR TELEGRAMA:   https://t.me/Dzhoni_dev
#   GITHUB OFICIAL:           https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/xxxxxxxxxxxxxxxxxxx
#====================================================
x="ok"

# Paleta de colores
reset="\033[0m"       # Restablecer todos los estilos y colores
bold="\033[1m"        # Texto en negrita
italic="\033[3m"      # Texto en cursiva
underline="\033[4m"   # Texto subrayado
blink="\033[5m"       # Texto parpadeante
reverse="\033[7m"     # Invertir colores de fondo y texto
hidden="\033[8m"      # Texto oculto (generalmente invisible)

# Colores de texto
black="\033[0;30m"     # Negro
red="\033[0;31m"       # Rojo
green="\033[0;32m"     # Verde
yellow="\033[0;33m"    # Amarillo
blue="\033[0;34m"      # Azul
magenta="\033[0;35m"   # Magenta
cyan="\033[0;36m"      # Cian
white="\033[0;37m"     # Blanco

# Colores de fondo
bg_black="\033[0;40m"     # Fondo Negro
bg_red="\033[0;41m"       # Fondo Rojo
bg_green="\033[0;42m"     # Fondo Verde
bg_yellow="\033[0;43m"    # Fondo Amarillo
bg_blue="\033[0;44m"      # Fondo Azul
bg_magenta="\033[0;45m"   # Fondo Magenta
bg_cyan="\033[0;46m"      # Fondo Cian
bg_white="\033[0;47m"     # Fondo Blanco

# Iconos v3
checkmark="${white}[${green}+${white}]${green}"
error="${white}[${red}-${white}]${red}"
info="${white}[${yellow}*${white}]${yellow}"
unknown="${white}[${blue}!${white}]${blue}"
process="${white}[${magenta}>>${white}]${magenta}"
indicator="${red}==>${cyan}"

# Barra de separación
barra="${blue}|--------------------------------------------|${reset}"
bar="${yellow}----------------------------------------------${reset}"

# Comprobación de permisos de root
[[ "$(whoami)" != "root" ]] && {
    echo -e "\n${error} ${white}- ${yellow}Necesitas ejecutar esto como administrador ${white}(${red}root${yellow}${white})${yellow}. ${reset}"
    echo -e "\n${info} ${green}sudo $0 ${reset}"
    exit 0
}

# menú de interfaz de usuario
user_interface_menu() {

# Mostrar segundo banner
fun_banner() {
    echo -e "\n${green}           .-  _           _  -. "
    echo -e "          /   /             \   \ "
    echo -e "         (   (  (\` (-o-) \`)  )   ) "
    echo -e "          \   \_ \`  -+-  \` _/   / "
    echo -e "           \`-       -+-       -\` "
    echo -e "                    -+-   ${cyan}Kali linux - drivers  y herramientas para hacking Wifi${reset}"
    echo -e "                          ${green}Version codificada por: Jony Rivera (Dzhoni)${reset}"
    echo ""
}

# Función para comprobar y, si es necesario, instalar la presencia de una herramienta
check_and_install_tool() {
    tool=$1
    if command -v $tool &> /dev/null; then
        echo -e "${checkmark} ${white}$tool .... ${green}Ok${reset}"
    else
        echo -e "\n${error} ${white}$tool ${yellow}no está instalado. Instalando automáticamente...${reset}\n"
        #--- sudo apt-get update
        sudo apt-get install -y $tool

        # Verificar si la instalación fue exitosa
        if command -v $tool &> /dev/null; then
            echo -e "\n${checkmark} ${white}$tool ${yellow}se ha instalado correctamente.${reset}"
        else
            echo -e "\n${error} ${yellow}No se pudo instalar ${white}$tool ${yellow}Por favor, instálalo manualmente.${reset}"
        fi
    fi
}

function repositorios() {
    # Actualizar repositorios
    echo -e "\n${info} Actualizar repositorios (update)......${reset}\n"
    sudo apt-get -y update
    echo -e "\n${info} ${blue}Sistema actualizado.${reset}"
}

function paquetes() {
    # Actualizar paquetes instalados
    echo -e "\n${info} Actualizar paquetes instalados (full-upgrade)......${reset}\n"
    sudo apt-get -y full-upgrade
    echo -e "\n${info} ${blue}Full-upgrade completado.${reset}"
}

# Funciones para los controladores
function driver_rtl8188eus() {
    echo -e "\n${info} Instalar realtek-rtl8188eus-dkms.......${reset}\n"
    sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)
    sudo apt install -y realtek-rtl8188eus-dkms
    echo -e "\n${info} ${blue}Driver rtl8188eus ${reset}"
}

function driver_rtl8814au() {
    echo -e "\n${info} Instalar realtek-rtl8814au-dkms.......${reset}\n"
    sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)
    sudo apt install -y realtek-rtl8814au-dkms
    echo -e "\n${info} ${blue}Driver rtl8814au${reset}"
}

function driver_rtl8723cs() {
    echo -e "\n${info} Instalar realtek-rtl8723cs-dkms.......${reset}\n"
    sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)
    sudo apt install -y realtek-rtl8723cs-dkms
    echo -e "\n${info} ${blue}Driver rtl8723cs${reset}"
}

function driver_rtl88xxau() {
    echo -e "\n${info} Instalar realtek-rtl88xxau-dkms.......${reset}\n"
    sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)
    sudo apt install -y realtek-rtl88xxau-dkms
    echo -e "\n${info} ${blue}Driver rtl88xxau${reset}"
}

function driver_rtl8188fu() {
    echo -e "\n${info} Instalar ealtek-rtl8188fu-dkms........${reset}\n"
    cd /opt
    sudo rm -rf rtl8188fu
    sudo git clone https://github.com/kelebek333/rtl8188fu
    sudo chmod +x rtl8188fu/*
    sudo dkms add ./rtl8188fu
    sudo dkms build rtl8188fu/1.0
    sudo dkms install rtl8188fu/1.0
    sudo cp ./rtl8188fu/firmware/rtl8188fufw.bin /lib/firmware/rtlwifi/
    cd
    echo -e "\n${info} ${blue}Driver rtl8188fu${reset}"
}

#--- sudo apt install -y realtek-rtl8192eu-dkms | off
#--- sudo apt install -y realtek-rtl88XXa-dkms | off
#--- sudo apt install -y realtek-rtl88x2bu-dkms | off

# Funciones para las herramientas
function tool_wifite() {
    echo -e "\n${info} Instalando wifite.....${reset}\n"
    sudo apt install -y wifite

    # Lista de herramientas esenciales a comprobar
    essential_tools=("git")

    # sudo apt install -y git hcxdumptool hcxtools libpcap-dev python2.7-dev libssl-dev zlib1g-dev libpcap-dev
    sudo apt install git hcxdumptool hcxtools python2.7-dev python3-dev python3-pip libssl-dev libpcap-dev zlib1g-dev libsqlite3-dev
    sudo pip3 install scapy numpy

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done

    # Instalar git pyrit
    echo -e "\n${info} Instalar pyrit.........${reset}\n"
    echo -e "${green} Por defecto ${white}N ${green}= ${white}No Instalar${reset}"
    read -p "$(echo -e "${green} Desea instalar el pyrit ahora? [N/y]:${white}") " response
    if [[ "$response" = @(y|Y) ]]; then

        # Proceso de instalación
        echo -e "${reset}"
        # Lista de herramientas esenciales a comprobar
        essential_tools=("git")

        # Comprobar herramientas esenciales
        echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
        for tool in "${essential_tools[@]}"
        do
            check_and_install_tool $tool
        done

        echo -e "\n${process} Instalando.....${reset}\n"

        cd /opt
        sudo rm -rf Pyrit
        sudo git clone https://github.com/JPaulMora/Pyrit.git
        sudo chmod +x Pyrit/*
        cd Pyrit
        sudo python3 setup.py clean
        sudo python3 setup.py build
        sudo python3 setup.py install
        pyrit -h
        cd

    else
        sleep 1s
    fi
    echo -e "\n${info} ${blue}Tool Wifite${reset}"
}

function tool_airgeddon() {
    echo -e "\n${info} Instalando airgeddon.....${reset}\n"
    sudo apt install -y airgeddon

    # Lista de herramientas esenciales a comprobar
    essential_tools=("iw" "awk" "airmon-ng" "airodump-ng" "aircrack-ng" "xterm" "ip" "lspci" "ps")

    # Lista de herramientas opcionales a comprobar
    optional_tools=("bettercap" "ettercap" "dnsmasq" "hostapd-wpe" "beef-xss" "aireplay-ng" "bully" "nft" "pixiewps" "dhcpd" "asleap" "packetforge-ng" "hashcat" "wpaclean" "hostapd" "tcpdump" "etterlog" "tshark" "mdk4" "wash" "hcxdumptool" "reaver" "hcxpcapngtool" "john" "crunch" "lighttpd" "openssl")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done

    # Comprobar y, si es necesario, instalar herramientas opcionales
    echo -e "\n${info} Herramientas opcionales: ${magenta}comprobando...${reset}\n"
    for tool in "${optional_tools[@]}"
    do
        check_and_install_tool $tool
    done
    echo -e "\n${info} ${blue}Tool Airgeddon${reset}"
}

function tool_fluxion() {
    echo -e "\n${info} Instalando fluxion.....${reset}"

    # Lista de herramientas esenciales a comprobar
    essential_tools=("git")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done

    echo -e "\n${process} Instalando.....${reset}\n"

    cd /opt
    sudo rm -rf fluxion
    sudo git clone https://www.github.com/FluxionNetwork/fluxion.git
    sudo chmod +x fluxion/*
    cd fluxion
    sudo chmod +x fluxion.sh
    cd
    echo "cd /opt/fluxion && sudo ./fluxion.sh" > fluxion 
    sudo chmod +x fluxion
    sudo mv fluxion /usr/local/bin/fluxion
    cd

    # Lista de herramientas esenciales a comprobar
    essential_tools=("aircrack-ng" "bc" "awk" "curl" "cowpatty" "dhcpd" "7zr" "hostapd" "lighttpd" "iwconfig" "macchanger" "mdk4" "dsniff" "mdk3" "nmap" "openssl" "php-cgi" "xterm" "rfkill" "unzip" "route" "fuser" "killall")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done
    echo -e "\n${info} ${blue}Tool Fluxion${reset}"
}

function tool_sparrow_wifi() {
    echo -e "\n${info} Instalar sparrow-wifi......${reset}\n"
    sudo apt install -y sparrow-wifi
    echo -e "\n${info} ${blue}Tool Sparrow-wifi${reset}"
}

function tool_feedingbottle() {
    echo -e "\n${info} Instalar feedingbottle......${reset}"

    # Lista de herramientas esenciales a comprobar
    essential_tools=("git" "fluid")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done

    echo -e "\n${process} Instalando.....${reset}\n"

    cd /opt
    sudo rm -rf feedingbottle
    sudo git clone https://github.com/ChunshengZhao/feedingbottle.git
    sudo chmod +x feedingbottle/*
    cd feedingbottle 
    #--- sudo rm -rf feedingbottle
    #--- sudo apt-get install -y fluid
    sudo fluid -c feedingbottle.fl
    sudo fltk-config --compile feedingbottle.cxx
    sudo chmod +x feedingbottle
    #--- sudo wget -O feedingbottle https://github.com/JennValentine/Kali-linux_drivers_and_tools_checker/raw/main/Herramientas/feedingbottle/Install/feedingbottle
    #--- sudo ./feedingbottle
    cd
    echo "cd /opt/feedingbottle && sudo ./feedingbottle" > feedingbottle 
    sudo chmod +x feedingbottle
    sudo mv feedingbottle /usr/local/bin/feedingbottle
    cd
    echo -e "\n${info} ${blue}Tool Feedingbottle${reset}"
}

function tool_handshaker() {
    echo -e "\n${info} Instalando Handshaker.....${reset}"

    echo -e "\n${process} Instalando.....${reset}\n"

    cd /opt
    sudo rm -rf Handshaker
    sudo cp -r /opt/Kali-linux_drivers_and_tools_checker/Herramientas/Handshaker/ /opt/
    sudo chmod +x Handshaker/*
    cd Handshaker
    sudo mkdir handshake
    sudo mkdir redes
    sudo chmod +x handshaker.sh
    cd
    echo "cd /opt/Handshaker && sudo ./handshaker.sh" > handshaker
    sudo chmod +x handshaker
    sudo mv handshaker /usr/local/bin/handshaker
    cd
    echo -e "\n${info} ${blue}Tool Handshaker${reset}"
}

function tool_lazyaircrack() {
    echo -e "\n${info} Instalando lazyaircrack.....${reset}"

    # Lista de herramientas esenciales a comprobar
    essential_tools=("git")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done

    echo -e "\n${process} Instalando.....${reset}\n"

    cd /opt
    sudo rm -rf lazyaircrack
    sudo git clone https://github.com/3xploitGuy/lazyaircrack.git
    sudo chmod +x lazyaircrack/*
    cd lazyaircrack
    sudo chmod +x lazyaircrack.sh

    # Dictionario
    echo -e "\n${info} Creando diccionario.....${reset}\n"
    cd dictionary
    sudo rm -rf defaultWordList.txt
    sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
    # combinando diccionario
    # sudo cat /usr/share/set/src/fasttrack/wordlist.txt /usr/share/john/password.lst /usr/share/nmap/nselib/data/passwords.lst /usr/share/wordlists/rockyou.txt /usr/share/sqlmap/data/txt/wordlist.txt /usr/share/dict/wordlist-probable.txt > diccionario_combinado.txt
    cat /usr/share/set/src/fasttrack/wordlist.txt \
            /usr/share/john/password.lst \
            /usr/share/nmap/nselib/data/passwords.lst \
            /usr/share/wordlists/rockyou.txt \
            /usr/share/sqlmap/data/txt/wordlist.txt \
            /usr/share/dict/wordlist-probable.txt > diccionario_combinado.txt

    # Total de palabras
    wc -l diccionario_combinado.txt
    wc -l < diccionario_combinado.txt | cut -d' ' -f1
    # diccionario sin duplicados
    sort diccionario_combinado.txt | uniq > diccionario_sin_duplicados.txt
    # Total de palabras
    wc -l diccionario_sin_duplicados.txt
    # palabras de 8 o mas
    grep -E '\b\w{8,}\b' diccionario_sin_duplicados.txt > palabras_8_o_mas.txt
    # Total de palabras
    wc -l palabras_8_o_mas.txt 
    sudo mv palabras_8_o_mas.txt defaultWordList.txt
    
    cd
    echo "cd /opt/lazyaircrack && sudo ./lazyaircrack.sh" > lazyaircrack
    sudo chmod +x lazyaircrack
    sudo mv lazyaircrack /usr/local/bin/lazyaircrack
    cd
    echo -e "\n${info} ${blue}Tool lazyaircrack${reset}"
}

function forces_audio() {
    # Estos son pasos generales y pueden variar según la configuración 
    # específica de tu hardware. Se ejecutará una serie de pasos para intentar configurar y activar 
    # los controladores de audio de tu tarjeta de sonido. Ten en cuenta que algunos pasos pueden no 
    # ser necesarios o aplicables a tu configuración específica. Si encuentras 
    # problemas, asegúrate de investigar y consultar los foros de la comunidad de Kali Linux 
    # para obtener asistencia según tus necesidades y hardware específicos.
    echo -e "\n${info} Instalar driver de audio.......${reset}\n"

        lspci | grep -i audio
        lsmod | grep snd
        sudo modprobe snd_hda_intel
        #--- alsamixer
        sudo service alsamixer restart 2>/dev/null
        sudo apt-get -y update
        #--- sudo apt-get -y upgrade
        sudo apt-get install pavucontrol
        #--- pavucontrol
        #--- sudo reboot

}

function check_extras() {
   echo -e "\n${info} Check extras.......${reset}"

    essential_tools=("aircrack-ng" "airgeddon" "cowpatty" "mdk3" "pixiewps" "reaver" "sparrow-wifi" "fern-wifi-cracker" "wireshark" "kismet" "eaphammer" "wifi-honey" "routersploit" "wifite" "xterm")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done
}

data_system() {
    # Mostrar la configuración de red usando ifconfig
    echo -e "\n${info} Mostrando información de red con ifconfig...${reset}\n"
    ifconfig

    # Mostrar información sobre interfaces inalámbricas utilizando iwconfig
    echo -e "\n${info} Mostrando información de interfaces inalámbricas con iwconfig...${reset}\n"
    iwconfig

    # Mostrar la lista de dispositivos USB conectados usando lsusb
    echo -e "\n${info} Mostrando dispositivos USB conectados con lsusb...${reset}\n"
    lsusb

    # Mostrar información detallada sobre las capacidades inalámbricas del sistema usando iw list
    echo -e "\n${info} Mostrando capacidades inalámbricas con iw list...${reset}\n"
    iw list | grep -A 10 "Supported interface modes:" | grep "*"
}

# Menú de opciones
while true $x != "ok"
do

# Limpiar la pantalla y mostrar banner
clear
fun_banner

echo -e "\n${yellow}Seleccione una opción del menú:${reset}\n"
echo -e "${blue}-------------- ( update ) --------------${reset}"
echo -e "${green}r. ${white} Actualizar el sistema${reset}"
echo -e "${green}p. ${white} Full-upgrade del sistema${reset}"
echo -e "${blue}-------------- ( Driver ) --------------${reset}"
echo -e "${green}1. ${white} Driver rtl8188eus${reset}"
echo -e "${green}2. ${white} Driver rtl8814au${reset}"
echo -e "${green}3. ${white} Driver rtl8723cs${reset}"
echo -e "${green}4. ${white} Driver rtl88xxau${reset}"
echo -e "${green}5. ${white} Driver rtl8188fu${reset}"
echo -e "${blue}-------------- ( Tool ) --------------${reset}"
echo -e "${green}6. ${white} Tool Wifite${reset}"
echo -e "${green}7. ${white} Tool Airgeddon${reset}"
echo -e "${green}8. ${white} Tool Fluxion${reset}"
echo -e "${green}9. ${white} Tool Sparrow-wifi${reset}"
echo -e "${green}10.${white} Tool Feedingbottle${reset}"
echo -e "${green}11.${white} Tool Handshaker${reset}"
echo -e "${green}12.${white} Tool lazyaircrack${reset}"
echo -e "${blue}-------------- ( Audio ) --------------${reset}"
echo -e "${green}13.${white} Forces Audio${reset}"
echo -e "${blue}-------------- ( Check ) --------------${reset}"
echo -e "${green}14.${white} Check extras${reset}"
echo -e "${green}15.${white} Información del Sistema y Red${reset}"
echo -e "${green}0. ${white} Salir${reset}"
echo -e "\n${barra}"

echo -ne "\n${bold}${yellow} Elige una opción:${white} >> "; read x

case $x in
  r) 
    repositorios 
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  p) 
    paquetes
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  1) 
    driver_rtl8188eus 
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  2) 
    driver_rtl8814au
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  3) 
    driver_rtl8723cs
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  4) 
    driver_rtl88xxau
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  5) 
    driver_rtl8188fu
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  6) 
    tool_wifite
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  7) 
    tool_airgeddon
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  8) 
    tool_fluxion
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  9) 
    tool_sparrow_wifi
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  10) 
    tool_feedingbottle
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  11) 
    tool_handshaker
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  12) 
    tool_lazyaircrack
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  13) 
    forces_audio
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  14) 
    check_extras
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  15) 
    echo -e "\n${process} ${cyan}Información del Sistema y Red...${reset}"
    data_system 
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENÚ!${reset}"; read
    ;;
  0)
    echo -e "\n${info} ${cyan}Saliendo...${reset}"
    exit 0
    ;;
  *)
    echo -e "\n${error} ${red}Opción no válida, por favor intente de nuevo.${reset}"
    sleep 1
esac
done
}

# Ejecución del menú principal
user_interface_menu

# Fin del script
