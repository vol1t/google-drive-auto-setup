# Google Drive Auto Setup (Linux)

Automatic Google Drive synchronization setup for Linux using Rclone + CDSync.

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Linux](https://img.shields.io/badge/platform-linux-blue)]()
[![Shell Script](https://img.shields.io/badge/script-bash-orange)]()

🇺🇸 English | 🇧🇷 Português

---

# 🇺🇸 English

Automatically sync your Google Drive on Linux using Rclone + CDSync.

This project creates an experience similar to the official Google Drive client available on Windows/macOS using free and open source tools.

---

# ✨ Features

- Automatic dependency installation
- Automatic Rclone configuration
- Simplified Google login
- Automatic CDSync configuration
- Real-time synchronization
- Automatic `~/Drive` folder creation
- Automatic file manager sidebar shortcut
- Compatible with:
  - Arch Linux
  - CachyOS
  - EndeavourOS
  - Fedora
  - Ubuntu
  - Debian
  - Linux Mint
  - Pop!_OS

---

# 📦 What this script installs

## Rclone

Tool responsible for connecting Linux to Google Drive.

Official project:

[Rclone Official Website](https://rclone.org)

---

## CDSync

Tool responsible for automatic synchronization.

Official project:

[CDSync GitHub Repository](https://github.com/muller-front/cdsync)

---

# 📁 Created structure

The script automatically creates:

```text
~/Drive
```

Your synchronized Google Drive folder.

And also:

```text
~/GoogleDrive
```

Where CDSync will be installed.

---

# 🚀 Installation

## 1 — Clone the repository

```bash
git clone https://github.com/vol1t/google-drive-auto-setup.git
cd google-drive-auto-setup
```

---

## 2 — Make the script executable

```bash
chmod +x google-drive-autoinstall.sh
```

---

## 3 — Run the installer

```bash
./google-drive-autoinstall.sh
```

---

# 🔐 Google Login

During installation:

- your browser will open automatically
- sign in with your Google account
- authorize Rclone access

After that the setup continues automatically.

---

# 📂 Automatic file manager shortcut

The script automatically creates a sidebar shortcut called:

```text
Google Drive
```

for file managers such as:

- Dolphin
- Nautilus
- Nemo
- Caja
- Thunar

---

# 🔄 How synchronization works

Everything placed inside:

```text
~/Drive
```

will automatically sync with Google Drive.

Changes made in the cloud will also be downloaded automatically.

---

# ✅ Checking service status

```bash
systemctl --user status cdsync
```

If you see:

```text
active (running)
```

then synchronization is working correctly.

---

# 🧪 Testing

Create a file:

```bash
touch ~/Drive/test.txt
```

After a few seconds it should appear in Google Drive.

---

# 🔧 Useful commands

## Restart the service

```bash
systemctl --user restart cdsync
```

## Stop synchronization

```bash
systemctl --user stop cdsync
```

## Start synchronization again

```bash
systemctl --user start cdsync
```

## View live logs

```bash
journalctl --user -u cdsync -f
```

---

# ⚠️ Important notes

## Disk space usage

Files are stored locally on your computer.

This means:
- Google Drive files use local disk space
- deleting local files may also delete cloud files depending on sync behavior

---

## First synchronization

The first synchronization may take some time depending on:
- number of files
- internet speed
- SSD/HDD speed

---

## Google Workspace accounts

This script is configured for personal Google accounts.

If you use Shared Drives/Team Drives, additional Rclone adjustments may be required.

---

# 🐧 Wayland/X11 compatibility

Works normally on:
- Wayland
- X11

Including:
- KDE Plasma
- GNOME
- Cinnamon
- XFCE
- MATE

---

# 🛠️ Common problems

## Browser did not open automatically

Open the link shown in the terminal manually.

---

## Service does not start

Run:

```bash
systemctl --user daemon-reload
systemctl --user restart cdsync
```

---

## Sidebar shortcut did not appear

Log out/log in again or restart your file manager.

KDE example:

```bash
killall dolphin && dolphin &
```

---

# 🔒 Security and privacy

This project:
- does not collect data
- does not send information to third parties
- uses official Google APIs through Rclone

All synchronization control remains local on the user's computer.

---

# 📜 License

Distributed under the MIT license.

---

---

# 🇧🇷 Português

Sincronize automaticamente seu Google Drive no Linux usando Rclone + CDSync.

Este projeto cria uma experiência parecida com o cliente oficial do Google Drive disponível no Windows/macOS, utilizando ferramentas open source e totalmente gratuitas.

---

# ✨ Recursos

- Instalação automática de dependências
- Configuração automática do Rclone
- Login simplificado com Google
- Configuração automática do CDSync
- Sincronização automática em tempo real
- Criação automática da pasta `~/Drive`
- Criação automática de atalho no gerenciador de arquivos
- Compatível com:
  - Arch Linux
  - CachyOS
  - EndeavourOS
  - Fedora
  - Ubuntu
  - Debian
  - Linux Mint
  - Pop!_OS

---

# 📦 O que este script instala

## Rclone

Ferramenta responsável por conectar o Linux ao Google Drive.

Projeto oficial:

[Rclone Official Website](https://rclone.org)

---

## CDSync

Ferramenta responsável pela sincronização automática.

Projeto oficial:

[CDSync GitHub Repository](https://github.com/muller-front/cdsync)

---

# 📁 Estrutura criada

O script cria automaticamente:

```text
~/Drive
```

Pasta sincronizada com o Google Drive.

E também:

```text
~/GoogleDrive
```

Onde o CDSync será instalado.

---

# 🚀 Instalação

## 1 — Clone o repositório

```bash
git clone https://github.com/vol1t/google-drive-auto-setup.git
cd google-drive-auto-setup
```

---

## 2 — Dê permissão de execução

```bash
chmod +x google-drive-autoinstall.sh
```

---

## 3 — Execute o script

```bash
./google-drive-autoinstall.sh
```

---

# 🔐 Login do Google

Durante a instalação:

- o navegador abrirá automaticamente
- faça login na sua conta Google
- autorize o acesso do Rclone

Após isso a configuração continuará automaticamente.

---

# 📂 Atalho automático no gerenciador de arquivos

O script adiciona automaticamente um atalho chamado:

```text
Google Drive
```

na barra lateral de gerenciadores como:

- Dolphin
- Nautilus
- Nemo
- Caja
- Thunar

---

# 🔄 Como funciona a sincronização

Tudo que for colocado em:

```text
~/Drive
```

será sincronizado automaticamente com o Google Drive.

Alterações feitas na nuvem também serão baixadas automaticamente para o computador.

---

# ✅ Verificando se o serviço está funcionando

```bash
systemctl --user status cdsync
```

Se aparecer:

```text
active (running)
```

significa que a sincronização está funcionando corretamente.

---

# 🧪 Testando

Crie um arquivo:

```bash
touch ~/Drive/teste.txt
```

Após alguns segundos ele deverá aparecer no Google Drive.

---

# 🔧 Comandos úteis

## Reiniciar o serviço

```bash
systemctl --user restart cdsync
```

## Parar a sincronização

```bash
systemctl --user stop cdsync
```

## Iniciar novamente

```bash
systemctl --user start cdsync
```

## Ver logs em tempo real

```bash
journalctl --user -u cdsync -f
```

---

# ⚠️ Observações importantes

## Espaço em disco

Os arquivos ficam armazenados localmente no computador.

Isso significa que:
- arquivos do Google Drive ocupam espaço no disco
- apagar arquivos localmente pode apagar na nuvem dependendo da sincronização

---

## Primeira sincronização

A primeira sincronização pode demorar dependendo:
- da quantidade de arquivos
- da velocidade da internet
- da velocidade do SSD/HD

---

## Contas Google Workspace

O script foi configurado para contas Google pessoais.

Caso utilize Shared Drives/Team Drives, ajustes adicionais podem ser necessários.

---

# 🐧 Compatibilidade Wayland/X11

Funciona normalmente tanto em:
- Wayland
- X11

Incluindo:
- KDE Plasma
- GNOME
- Cinnamon
- XFCE
- MATE

---

# 🛠️ Problemas comuns

## O navegador não abriu automaticamente

Abra manualmente o link exibido no terminal.

---

## O serviço não inicia

Execute:

```bash
systemctl --user daemon-reload
systemctl --user restart cdsync
```

---

## O atalho não apareceu no gerenciador de arquivos

Faça logout/login ou reinicie o gerenciador de arquivos.

Exemplo no KDE:

```bash
killall dolphin && dolphin &
```

---

# 🔒 Segurança e privacidade

Este projeto:
- não coleta dados
- não envia informações para terceiros
- utiliza APIs oficiais do Google via Rclone

Todo o controle permanece localmente no computador do usuário.

---

# 📜 Licença

Distribuído sob a licença MIT.
