![logo](https://github.com/dzh0ni/evilTrust/blob/master/Imagenes/inicio.png)

# EvilTrust by s4v1tar :octocat: 

## :information_source: Descripción 
EvilTrust 🕵️‍♂️ es un script avanzado de Bash diseñado para convertir un dispositivo Linux en un punto de acceso malicioso (*rogue AP*), ideal para pruebas de penetración y auditorías de seguridad WiFi. Este script permite capturar credenciales, interceptar tráfico, y realizar ataques de ingeniería social mediante la creación de redes falsas y portales cautivos.  

EvilTrust ideal para el despliegue automatizado de un Rogue AP con capacidad de selección de plantilla + 2FA.

Esta herramienta dispone de varias plantillas a utilizar, incluyendo una opción de plantilla personalizada, donde el atacante es capaz de desplegar su propia plantilla.

IMPORTANTE: No es necesario contar con una conexión cableada, por lo que es posible desplegar el ataque desde cualquier lado en cualquier momento.

La herramienta soporta dos modos de ejecución.

- 🔧 Modo Terminal (CLI)
- 🖥️ Modo Gráfico (GUI)

## :computer: Instalación
```bash
cd /opt
sudo rm -rf evilTrust
sudo git clone https://github.com/s4vitar/evilTrust.git
cd evilTrust
sudo chmod +x evilTrust.sh
cd
```

## :key: Acceso Directo
```bash
cd 
sudo echo "cd && cd /opt/evilTrust && sudo ./evilTrust.sh -m terminal" > eviltrust
sudo echo "cd && cd /opt/evilTrust && sudo ./evilTrust.sh -m gui" > eviltrustg
sudo chmod +x eviltrust
sudo chmod +x eviltrustg
sudo rm -rf /usr/local/bin/eviltrust
sudo rm -rf /usr/local/bin/eviltrustg
sudo mv eviltrust /usr/local/bin/
sudo mv eviltrustg /usr/local/bin/
cd
```

## :package: Paquete
```bash
sudo apt-get -y update
sudo apt-get install -y php
sudo apt-get install -y dnsmasq
sudo apt-get install -y hostapd
```

## :computer: Crear Desktop
```bash
sudo mkdir -p /usr/local/share/evilTrust/images
sudo cp /opt/evilTrust/images/evil.png /usr/local/share/evilTrust/images/
sudo chmod 644 /usr/local/share/evilTrust/images/evil.png
```
```bash
sudo wget https://raw.githubusercontent.com/dzh0ni/evilTrust/master/Install/crear_evilTrust_desktop.sh -O - | sudo bash && sudo rm -rf wget-log*
```

## :computer: Instalación en una Línea
```bash
sudo wget https://raw.githubusercontent.com/dzh0ni/evilTrust/refs/heads/main/install.sh -O - | sudo bash && sudo rm -rf wget-log*
```

## :rocket: Modo de Uso
  
Ejecuta el script fácilmente ingresando el siguiente comando `eviltrust` o `eviltrustg` en tu terminal y presionando Enter.

**Modo por Terminal**
```bash
eviltrust
```

**Modo por Gui**
```bash
eviltrustg
```

# 🛠️ Demos y Ejemplos

Aquí tienes algunos ejemplos de uso del script EvilTrust en acción:  

### 1️⃣ **Tutorial detallado para el uso del script.
Captura de credenciales mediante un entorno controlado.  
![Github - s4vitar](https://github.com/dzh0ni/evilTrust/blob/master/Tutorial.md/)  

> 🌐 **Nota**: Este script debe ser utilizado únicamente con fines éticos y en entornos donde tengas autorización explícita.

## :bookmark_tabs: Notas
  
El script es ideal para:  
- Auditorías de seguridad en redes WiFi.  
- Simulación de ataques de ingeniería social.  
- Captura de tráfico en entornos controlados.  

## :star2: Características 

- Automatización total para pruebas de seguridad WiFi.  
- Soporte para terminal e interfaz.  
- Herramienta liviana y personalizable.  

## :hammer_and_wrench: Requisitos
 
- **Sistema Operativo**: Linux (Kali Linux, ParotOS, Raspberry Pi OS, etc.)  
- **Hardware**: Tarjeta WiFi compatible con modo monitor y AP. [Cards and Chipsets](https://github.com/v1s1t0r1sh3r3/airgeddon/wiki/Cards%20and%20Chipsets)  
- **Dependencias**: 
  - `php` 
  - `hostapd`  
  - `dnsmasq`  
  - `iptables`  

## 📂 Estructura del Repositorio

| Icono            | Nombre              | Descripción                               |
|------------------|---------------------|-------------------------------------------|
| :file_folder:    | Imagenes            | Carpeta que contiene imágenes del script en ejecución |
| :package:        | install.sh          | Script de instalación automatizada |
| :file_folder:    | all_in_one          | Plantilla Todo en Uno y mejoras generales. |
| :file_folder:    | cliqq-payload       | Plantilla para payload APK malicioso.     |
| :file_folder:    | facebook-login      | Plantilla de Facebook con 2FA operativo. |
| :file_folder:    | google-login        | Segundo factor de autenticación para Google. |
| :file_folder:    | images              | Modificaciones e imágenes del proyecto.   |
| :file_folder:    | optimumwifi         | Plantillas de redes de optimumwifi.       |
| :file_folder:    | starbucks-login     | Portal de Starbucks con 2FA operativo.    |
| :file_folder:    | twitter-login       | Plantilla de Twitter con autenticación de dos factores. |
| :file_folder:    | utilities           | Herramientas de conteo de víctimas conectadas. |
| :file_folder:    | yahoo-login         | Plantilla de Yahoo con 2FA operativo.     |
| :page_facing_up: | README.md           | Documentación principal del proyecto.     |
| :page_facing_up: | Tutorial.md         | Tutorial detallado para el uso del script.|
| :page_facing_up: | evilTrust.sh        | Script principal con mejoras recientes.   |

## :star2: Contribuciones

Las contribuciones son bienvenidas. Si tienes ideas para mejorar este script o encuentras algún problema, siéntete libre de abrir un *pull request* o *issue*.

## :warning: Advertencias

- Uso Responsable: Este script está diseñado para ser utilizado en dispositivos y redes que te pertenecen o para las que tienes permiso de uso. No lo utilices para actividades no autorizadas.

## :email: **Contacto** 
Si tienes preguntas o sugerencias:  
* :busts_in_silhouette: Contacta a ![s4vitar](https://github.com/s4vitar) - Desarrollador evilTrust
* :busts_in_silhouette: **Dzh0ni**: [Telegram](https://t.me/Dzh0ni_Dev) - Adaptacion README.md 

🌐 **Repositorio oficial**  
![EvilTrust GitHub](https://github.com/s4vitar/evilTrust)
