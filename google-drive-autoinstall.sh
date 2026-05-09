#!/usr/bin/env bash

set -e

# ==================================================
# Google Drive Auto Setup
# Rclone + CDSync
# ==================================================

REMOTE_NAME="gdrive"
SYNC_DIR="$HOME/Drive"
CDSYNC_DIR="$HOME/GoogleDrive"

# ==================================================
# CORES
# ==================================================

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
RESET="\e[0m"

msg() {
    echo -e "${GREEN}[+]${RESET} $1"
}

warn() {
    echo -e "${YELLOW}[!]${RESET} $1"
}

err() {
    echo -e "${RED}[-]${RESET} $1"
}

title() {
    echo
    echo -e "${BLUE}==================================================${RESET}"
    echo -e "${BLUE}$1${RESET}"
    echo -e "${BLUE}==================================================${RESET}"
    echo
}

# ==================================================
# DETECTAR DISTRO
# ==================================================

detect_distro() {

    if command -v pacman &>/dev/null; then
        DISTRO="arch"

    elif command -v dnf &>/dev/null; then
        DISTRO="fedora"

    elif command -v apt &>/dev/null; then
        DISTRO="debian"

    else
        err "Distribuição não suportada."
        exit 1
    fi
}

# ==================================================
# INSTALAR DEPENDÊNCIAS
# ==================================================

install_packages() {

    title "Instalando dependências"

    case "$DISTRO" in

        arch)

            sudo pacman -Sy --needed --noconfirm \
                rclone \
                inotify-tools \
                python-gobject \
                libappindicator-gtk3 \
                git

            ;;

        fedora)

            sudo dnf install -y \
                rclone \
                inotify-tools \
                python3-gobject \
                libappindicator-gtk3 \
                git

            ;;

        debian)

            sudo apt update

            sudo apt install -y \
                rclone \
                inotify-tools \
                python3-gi \
                gir1.2-appindicator3-0.1 \
                git

            ;;

    esac

    msg "Dependências instaladas."
}

# ==================================================
# VERIFICAR RCLONE
# ==================================================

check_rclone() {

    title "Verificando Rclone"

    if ! command -v rclone &>/dev/null; then
        err "Rclone não encontrado."
        exit 1
    fi

    rclone version | head -n 1
}

# ==================================================
# CONFIGURAR RCLONE
# ==================================================

configure_rclone() {

    title "Configurando Google Drive"

    if ! rclone listremotes | grep -q "^${REMOTE_NAME}:$"; then

        msg "Criando remote '${REMOTE_NAME}'..."

        rclone config create \
            "${REMOTE_NAME}" \
            drive \
            scope=drive \
            root_folder_id= \
            team_drive=

        echo
        warn "Será aberto o login do Google no navegador."
        warn "Faça login e autorize o acesso."
        echo

        rclone config reconnect "${REMOTE_NAME}:"

    else

        warn "Remote '${REMOTE_NAME}' já existe."

    fi

    echo
    msg "Testando conexão..."

    if rclone lsd "${REMOTE_NAME}:" &>/dev/null; then

        msg "Google Drive conectado com sucesso."

    else

        err "Falha ao acessar o Google Drive."
        exit 1

    fi
}

# ==================================================
# BAIXAR CDSYNC
# ==================================================

install_cdsync() {

    title "Baixando CDSync"

    cd "$HOME"

    if [ ! -d "$CDSYNC_DIR" ]; then

        git clone https://github.com/muller-front/cdsync.git "$CDSYNC_DIR"

    else

        warn "Pasta '$CDSYNC_DIR' já existe."

    fi

    cd "$CDSYNC_DIR"
}

# ==================================================
# CONFIGURAR CDSYNC
# ==================================================

configure_cdsync() {

    title "Configurando CDSync"

    mkdir -p "$SYNC_DIR"

    if [ ! -f config.env ]; then

        cp config.env.example config.env

    fi

    sed -i \
        "s|^RCLONE_REMOTE=.*|RCLONE_REMOTE=${REMOTE_NAME}:|g" \
        config.env

    sed -i \
        "s|^LOCAL_SYNC_DIR=.*|LOCAL_SYNC_DIR=${SYNC_DIR}|g" \
        config.env

    msg "Arquivo config.env configurado."
}

# ==================================================
# ADICIONAR ATALHO NO GERENCIADOR DE ARQUIVOS
# ==================================================

add_sidebar_shortcut() {

    title "Criando atalho no gerenciador de arquivos"

    GTK_BOOKMARKS="$HOME/.config/gtk-3.0/bookmarks"

    mkdir -p "$(dirname "$GTK_BOOKMARKS")"

    BOOKMARK_ENTRY="file://$SYNC_DIR Google Drive"

    if [ -f "$GTK_BOOKMARKS" ]; then

        if ! grep -Fxq "$BOOKMARK_ENTRY" "$GTK_BOOKMARKS"; then
            echo "$BOOKMARK_ENTRY" >> "$GTK_BOOKMARKS"
        fi

    else

        echo "$BOOKMARK_ENTRY" > "$GTK_BOOKMARKS"

    fi

    msg "Atalho criado."
}

# ==================================================
# INSTALAR SERVIÇOS
# ==================================================

install_services() {

    title "Instalando CDSync"

    chmod +x install.sh

    printf "Y\n" | ./install.sh

    sleep 3

    systemctl --user daemon-reload

    if systemctl --user is-active --quiet cdsync; then

        msg "CDSync iniciado com sucesso."

    else

        warn "Tentando iniciar serviço..."

        systemctl --user enable --now cdsync

    fi
}

# ==================================================
# TESTE FINAL
# ==================================================

final_test() {

    title "Teste de sincronização"

    TEST_FILE="$SYNC_DIR/teste-sync.txt"

    touch "$TEST_FILE"

    msg "Arquivo de teste criado:"
    echo "$TEST_FILE"

    echo
    warn "Verifique se o arquivo apareceu no Google Drive."
    echo
}

# ==================================================
# MAIN
# ==================================================

main() {

    clear

    echo
    echo "=================================================="
    echo " Google Drive Auto Setup"
    echo " Rclone + CDSync"
    echo "=================================================="
    echo

    detect_distro

    msg "Distribuição detectada: $DISTRO"

    install_packages
    check_rclone
    configure_rclone
    install_cdsync
    configure_cdsync
    add_sidebar_shortcut
    install_services
    final_test

    title "Tudo pronto"

    echo "Pasta sincronizada:"
    echo "  $SYNC_DIR"
    echo

    echo "Pasta do CDSync:"
    echo "  $CDSYNC_DIR"
    echo

    echo "Status do serviço:"
    echo "  systemctl --user status cdsync"
    echo
}

main
