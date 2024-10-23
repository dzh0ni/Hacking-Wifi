![logo](https://edteam-media.s3.amazonaws.com/blogs/big/2ab53939-9b50-47dd-b56e-38d4ba3cc0f0.png)

# Kali Linux - Drivers and Tools Checker

## :information_source: Descripción
El script Kali Linux - Drivers and Tools Checker está diseñado para automatizar la 
instalación y verificación de diversos controladores y herramientas esenciales para 
la auditoría de seguridad en Kali Linux. El objetivo principal es asegurar que todos 
los componentes necesarios estén instalados y configurados correctamente para 
realizar auditorías de red y pruebas de penetración.

## :computer: Instalación
```bash
cd /opt
sudo rm -rf Kali-linux_drivers_and_tools_checker
sudo git clone https://github.com/JennValentine/Kali-linux_drivers_and_tools_checker.git
sudo chmod +x Kali-linux_drivers_and_tools_checker/*
cd Kali-linux_drivers_and_tools_checker
ls -lthas
```

## :key: Acceso Directo
```bash
cd 
sudo echo "cd /opt/Kali-linux_drivers_and_tools_checker && sudo ./kalilinuxdrivertools.sh" > kalilinuxdrivertools
sudo chmod +x kalilinuxdrivertools
sudo rm -rf /usr/local/bin/kalilinuxdrivertools
sudo mv kalilinuxdrivertools /usr/local/bin/
cd
```

## :computer: Instalación en una Línea
```bash
wget https://raw.githubusercontent.com/JennValentine/Kali-linux_drivers_and_tools_checker/main/install.sh; sudo chmod +x install.sh; sudo ./install.sh; sudo rm -rf install.sh
```

## :rocket: Modo de Uso

Ejecutar el scrip:

```bash
sudo kalilinuxdrivertools
```
![logo](https://github.com/JennValentine/Kali-linux_drivers_and_tools_checker/blob/main/Imagenes/kalilinuxdrivertools.jpg)
:memo: Notas: Al ejecutar el script, se solicita la confirmación del usuario para cada paso crítico, 
como la actualización de repositorios y la instalación de herramientas opcionales. 
Esto proporciona control al usuario sobre las acciones que se van a realizar en el 
sistema.

## :star2: Características y Funcionalidades Principales

1 - Comprobación de Permisos de Root:

* El script verifica si se está ejecutando con permisos de superusuario (root) y, en caso contrario, solicita que se ejecute con sudo.

2 - Actualización de Repositorios y Paquetes:

* Opción para actualizar los repositorios (apt-get update).
* Opción para actualizar los paquetes instalados (apt-get upgrade).

3 - Instalación de Controladores de Red:

* Instalación de controladores específicos para adaptadores de red Realtek, como rtl8188eus, rtl8188fu, y opcionalmente rtl8814au-dkms.

4 - Configuración de Controladores de Audio:

* Intenta configurar y activar los controladores de audio, asegurando la correcta funcionalidad del sonido en el sistema.

5 - Instalación y Verificación de Herramientas Esenciales y Opcionales:

* Verificación e instalación de herramientas esenciales como git, aircrack-ng, wifite, hcxdumptool, pyrit, airgeddon, fluxion, entre otras.
* Instalación de herramientas adicionales como sparrow-wifi, feedingbottle, lazyaircrack, y Wifi-Hack.

6 - Configuración y Creación de Diccionarios de Contraseñas:

* Creación de un diccionario combinado a partir de múltiples fuentes de listas de contraseñas para usar en ataques de fuerza bruta.

7 - Mostrar Información del Sistema:

* Muestra la configuración de red, interfaces inalámbricas, dispositivos USB y capacidades inalámbricas del sistema.

## :hammer_and_wrench: Requisitos 
-  Sistema Operativo: Kali Linux/Unix

Este script es una herramienta poderosa para cualquier profesional de la seguridad 
informática que utilice Kali Linux, ya que simplifica y automatiza muchas de las 
tareas comunes de configuración y actualización necesarias para una auditoría de 
seguridad eficaz.

:bookmark_tabs: Disfruta utilizando el script y mantén tu sistema Kali Linux actualizado y listo para su uso en pruebas de seguridad en redes! 

## :email: Contacto
* :busts_in_silhouette: [Jenn Valentine](https://t.me/JennValentine) - Update Contributor :octocat:
