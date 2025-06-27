![logo](https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/Hacking-Wifi/blob/main/Imagenes/hacking-wifi.png)

# Hacking-Wifi
**Kali linux - drivers y herramientas para hacking Wifi**

## :information_source: Descripción
Kali linux - drivers y herramientas para hacking Wifi está diseñado para automatizar la 
instalación y verificación de diversos controladores y herramientas esenciales para 
la auditoría de seguridad de redes wifi. El objetivo principal es asegurar que todos 
los componentes necesarios estén instalados y configurados correctamente para 
realizar auditorías de redes wifi y pruebas de penetración.

## :computer: Instalación
```bash
cd /opt
sudo rm -rf Hacking-Wifi
sudo git clone https://github.com/dzh0ni/Hacking-Wifi.git
sudo chmod +x Hacking-Wifi/*
cd Hacking-Wifi
ls -ltha
```

## :key: Acceso Directo
```bash
cd 
sudo echo "cd /opt/Hacking-Wifi && sudo ./menu.sh" > hackingwifi
sudo chmod +x hackingwifi
sudo mv hackingwifi /usr/local/bin/
cd
```

## :computer: Instalación en una Línea (Solo script)
```bash
sudo wget https://raw.githubusercontent.com/dzh0ni/Hacking-Wifi/refs/heads/main/install.sh -O - | sudo bash && sudo rm -rf wget-log*
```

## :rocket: Modo de Uso

Ejecutar el scrip:

```bash
hackingwifi
```

## :star2: Características 

1 - Comprobación de Permisos de Root:

* El script verifica si se está ejecutando con permisos de superusuario (root) y, en caso contrario, solicita que se ejecute con sudo.

2 - Actualización de Repositorios y Paquetes:

* Opción para actualizar los repositorios (apt-get update).
* Opción para actualizar los paquetes instalados (apt-get full-upgrade).

3 - Instalación de Controladores de Red:

* Instalación de controladores específicos para adaptadores de red Realtek, como rtl8188eus, rtl8188fu, y opcionalmente rtl8814au-dkms.

4 - Configuración de Controladores de Audio:

* Intenta configurar y activar los controladores de audio, asegurando la correcta funcionalidad del sonido en el sistema.

5 - Instalación y Verificación de Herramientas Esenciales y Opcionales:

* Verificación e instalación de herramientas esenciales como git, aircrack-ng, wifite, hcxdumptool, pyrit, airgeddon, fluxion, entre otras.
* Instalación de herramientas adicionales como sparrow-wifi, feedingbottle, lazyaircrack, y Wifi-Hack, entre otras.

6 - Configuración y Creación de Diccionarios de Contraseñas:

* Creación de un diccionario combinado a partir de múltiples fuentes de listas de contraseñas para usar en ataques de fuerza bruta.

7 - Mostrar Información del Sistema:

* Muestra la configuración de red, interfaces inalámbricas, dispositivos USB y capacidades inalámbricas del sistema.

## :hammer_and_wrench: Requisitos

-  Sistema Operativo: Kali Linux/Unix

Este script es una herramienta poderosa para cualquier profesional de la seguridad 
informática que utilice Kali Linux, ya que simplifica y automatiza muchas de las 
tareas comunes de configuración y actualización necesarias para una auditorías de redes wifi y pruebas de penetración.

## :open_file_folder: Estructura del Repositorio

| Icono            | Nombre              | Descripción                               |
|------------------|---------------------|-------------------------------------------|
| :file_folder:    | Herramientas        | Carpeta de herramientas extras            |
| :file_folder:    | Imágenes            | Carpeta para imágenes del proyecto        |
| :file_folder:    | Install             | Carpeta para scripts de instalación       |
| :page_facing_up: | .gitattributes      | Archivo para configuración de Git         |
| :page_facing_up: | LICENSE             | Archivo de licencia del proyecto          |
| :book:           | README.md           | Archivo de documentación principal        |
| :package:        | install.sh          | Script de instalación automatizada        |
| :page_facing_up: | menu.sh             | Herramienta de utilidades                 |

## :star2: Contribuciones

Las contribuciones son bienvenidas. Si tienes ideas para mejorar este script o encuentras algún problema, siéntete libre de abrir un *pull request* o *issue*.

## :warning: Advertencias

- Uso Responsable: Este script está diseñado para ser utilizado en dispositivos y redes que te pertenecen o para las que tienes permiso de uso. No lo utilices para actividades no autorizadas.

## :email: **Contacto** 
Si tienes preguntas o sugerencias:  
* :busts_in_silhouette: **dZh0ni**: [Telegram](https://t.me/dZh0ni_Dev) - Desarrollador Hacking-Wifi
