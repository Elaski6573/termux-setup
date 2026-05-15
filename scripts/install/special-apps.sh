#!/bin/bash

# scripts/install/special-apps.sh - Apps requiring special environment variables

echo "--- Installing Special Apps ---"

install_gimp() {
    echo "Installing GIMP and X11 environment..."
    apt install x11-repo -y
    apt install termux-x11-nightly xfwm4 gimp -y

    # Create start script
    START_SCRIPT="$HOME/startgimp.sh"
    cat > "$START_SCRIPT" << 'EOF'
#!/bin/bash
# 디스플레이 지정
export DISPLAY=:0
echo "지정된 디스플레이 : $DISPLAY"

# X 서버 실행
termux-x11 :0 &
sleep 2

# X 윈도우 관리자 실행
xfwm4 --display=:0 &
sleep 2

# GIMP 실행
gimp --display=:0
EOF
    
    chmod +x "$START_SCRIPT"
    echo "GIMP installation complete. Run './startgimp.sh' to start."
}

echo "Would you like to install GIMP (GUI)? "
read -p "Install GIMP? [y/N] " gimp_choice

case "$gimp_choice" in
    [yY][eE][sS]|[yY])
        install_gimp
        ;;
    *)
        echo "Skipping GIMP installation."
        ;;
esac
