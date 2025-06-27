#!/bin/bash
#====================================================
#   SCRIPT:                   Hacking-Wifi | Kali linux - drivers y herramientas para hacking Wifi
#   DESARROLLADO POR:         Jony Rivera (dZh0ni)
#   FECHA DE ACTUALIZACIÓN:   07-05-2024  
#   CONTACTO POR TELEGRAMA:   https://t.me/dZh0ni_Dev
#   GITHUB OFICIAL:           https://github.com/dzh0ni/Hacking-Wifi
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

# Iconos v0  
checkmark="${white}[${green}+${white}]${green}"     # Acción exitosa o algo encontrado
error="${white}[${red}-${white}]${red}"             # Error o acción fallida
info="${white}[${yellow}*${white}]${yellow}"        # nformación o proceso en curso
warning="${white}[${blue}!${white}]${blue}"         # Advertencia o estado desconocido
loading="${white}[${magenta}~${white}]${magenta}"   # Indicador de proceso en ejecución
indicator="${white}[${cyan}>${white}]${cyan}"       # Indicador general

# Iconos v0 Especial
fast_process="${magenta}>>${green}"   # Para mostrar procesos rápidos o en ejecución inmediata
action_indicator="${red}==>${cyan}"   # Para indicar una acción o cambio en progreso

# Barra de separación
bar="${yellow}----------------------------------------------${reset}"
bar2="${blue}----------------------------------------------${reset}"
barra="${blue}|--------------------------------------------|${reset}"

# Función para manejar la salida eficiente
trap ctrl_c INT
ctrl_c() {
  echo -e "\n\n${error} Interrupción detectada. Saliendo...${reset}"
  exit 1
}

# Comprobación de permisos de root v1
[[ "$(whoami)" != "root" ]] && {
    echo -e "\n${error} ${yellow}Necesitas ejecutar este script como administrador ${white}(${red}root${white})${reset}."
    echo -e "\n${info} ${green}Intenta: sudo $0${reset}"
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
    echo -e "                          ${green}Version codificada por: Jony Rivera (dZh0ni)${reset}"
    echo ""
}

# Función de actualización
P_SERVER="https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Hacking-Wifi/refs/heads/main/Install/"
v1=$(curl -sSL "${P_SERVER}/versionact")
v2=$(cat /opt/Hacking-Wifi/Install/versionact)

txt01="Tu versión está actualizada"
txt02="¡Hay una actualización disponible!"

# Compara las versiones y define el mensaje
if [[ $v1 = $v2 ]]; then
    versionSCT="${green}${txt01} ${cyan}$v2${reset}"
else
    versionSCT="${red}${txt02} ${cyan}$v1${reset}"
fi

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

# Función para crear el diccionario
crear_diccionario() {
    # Ruta del archivo de salida donde se almacenará el diccionario final
    local output_file="/usr/share/wordlists/defaultWordList.txt"

    # Verificar si el diccionario ya existe para evitar sobrescribirlo
    if [[ ! -f "$output_file" ]]; then
        echo -e "\n${info} Creando diccionario.....${reset}\n"

        # Descomprimir el archivo rockyou.txt.gz si aún no ha sido descomprimido
        sudo apt install -y wordlists
        if [[ ! -f "/usr/share/wordlists/rockyou.txt" ]]; then
            sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
        fi

        # Combinar varias listas de palabras en un solo archivo temporal
        cat /usr/share/set/src/fasttrack/wordlist.txt \
            /usr/share/john/password.lst \
            /usr/share/nmap/nselib/data/passwords.lst \
            /usr/share/wordlists/rockyou.txt \
            /usr/share/sqlmap/data/txt/wordlist.txt \
            /usr/share/dict/wordlist-probable.txt > diccionario_combinado.txt

        # Ordenar las palabras en el archivo combinado y eliminar duplicados
        sort diccionario_combinado.txt | uniq > diccionario_sin_duplicados.txt

        # Filtrar las palabras con 8 caracteres o más y guardarlas en el archivo final
        grep -E '\b\w{8,}\b' diccionario_sin_duplicados.txt > "$output_file"

        # Asignar permisos de ejecución al diccionario final (aunque no es estrictamente necesario)
        sudo chmod +x "$output_file"
        
        # Eliminar los archivos temporales utilizados en el proceso
        sudo rm -rf diccionario_combinado.txt diccionario_sin_duplicados.txt

        # Contar y mostrar el número total de palabras en el diccionario final
        wc -l "$output_file"

        echo -e "\n${info} Diccionario creado en ${output_file}${reset}\n"
    else
        # Si el diccionario ya existe, se muestra un mensaje de advertencia
        echo -e "\n${error} El archivo ${output_file} ya existe.${reset}\n"
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
    echo -e "\n${info} ${blue}Sistema actualizado.${reset}"
}

function linuxbuild() {
    echo -e "\n${info} Instalar build-essential dkms linux-headers-$(uname -r).......${reset}\n"
    sudo apt-get install -y build-essential dkms linux-headers-$(uname -r)
    echo -e "\n${info} ${blue}Sistema actualizado${reset}"
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
    #--- sudo wget -O feedingbottle https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Hacking-Wifi/raw/main/Herramientas/feedingbottle/Install/feedingbottle
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
    sudo cp -r /opt/Hacking-Wifi/Herramientas/Handshaker/ /opt/
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

    # essential_tools=("aircrack-ng" "airgeddon" "cewl" "cowpatty" "mdk3" "pixiewps" "reaver" "sparrow-wifi" "fern-wifi-cracker" "wireshark" "kismet" "eaphammer" "wifi-honey" "routersploit" "wifite" "xterm" "john" "hashcat")

    essential_tools=(
    "aircrack-ng" 
    "airgeddon" 
    "awk" 
    "bc" 
    "bettercap" 
    "bully" 
    "cewl"
    "cowpatty" 
    "curl" 
    "crunch" 
    "dhcpd" 
    "dnsmasq" 
    "dsniff" 
    "ettercap" 
    "etterlog" 
    "fern-wifi-cracker" 
    "fuser" 
    "hashcat" 
    "hcxdumptool" 
    "hostapd" 
    "hostapd-wpe" 
    "iw" 
    "iwconfig" 
    "killall" 
    "kismet" 
    "lighttpd" 
    "john"
    "mdk3" 
    "mdk4" 
    "nmap" 
    "nft" 
    "openssl" 
    "packetforge-ng" 
    "php-cgi" 
    "pixiewps" 
    "reaver" 
    "rfkill" 
    "route" 
    "sparrow-wifi" 
    "tcpdump" 
    "tshark" 
    "unzip" 
    "wireshark" 
    "wifite" 
    "xterm" 
    "eaphammer" 
    "wifi-honey" 
    "routersploit" 
)


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
echo -e "${green}R. ${white} Actualizar el sistema${reset}"
echo -e "${green}P. ${white} Full-upgrade del sistema${reset}"
echo -e "${blue}-------------- ( Diccionario ) --------------${reset}"
echo -e "${green}D. ${white} Crear Diccionario personalizado${reset}"
echo -e "${blue}-------------- ( Driver ) --------------${reset}"
echo -e "${green}C. ${white} Paquetes Esenciales para Compilación${reset}"
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
echo -e "${bar}"
echo -e "${green}16 $versionSCT${reset}"
echo -e "${bar}"
echo -e "${green}0  ${white}Salir${reset}"
echo -e "\n${barra}"

echo -ne "\n${bold}${yellow} Elige una opción:${white} >> "; read x

case $x in
  r | R) 
    repositorios 
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  p | P) 
    paquetes
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver a ${green}MENU!${reset}"; read
    ;;
  d | D)
    echo -e "\n${process} ${cyan}Creando diccionario personalizado...${reset}"
    crear_diccionario
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
    ;;
  c | C) 
    linuxbuild
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
  16)
    echo -e "\n${process} ${cyan}Actualizando Script...${reset}\n"
    sudo wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/Hacking-Wifi/refs/heads/main/install.sh -O - | sudo bash
    sudo rm -rf wget-log*
    echo -ne "\n${bold}${red}ENTER ${yellow}para volver al ${green}MENU!${reset}"; read
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
