#! /bin/sh

install_proot_Ubuntu() {
    apt install proot-distro -y
    proot-distro login ubuntu
    curl -fsSL https://code-server.dev/install.sh | sh
}
install_gimp() {
    apt install x11-repo -y
    apt install termux-x11-nightly xfwm4 gimp -y

    cat > "startgimp.sh" << 'EOF'
    #! /bin/bash

    # 디스플레이 지정
    export DISPLAY=:0
    echo "지정된 디스플레이 : $DISPLAY"
    
    # X 서버 실행
    termux-x11 :0 &
    sleep 2

    # X 윈도우 관리자 실행
    xfwm4 --display=:0 &
    sleep 2

    #GIMP 실행
    gimp --display=:0
EOF
    
    chmod +x startgimp.sh

    echo "./startgimp.sh 를 입력하여 GIMP를 실행하세요"    
}

# 패키지 업데이트
echo "패키지를 업데이트합니다.."
if apt update && apt upgrade -y; then
    echo "업데이트 완료"
else
    echo "apt에서 오류가 발생했습니다."
    exit 1
fi

# 저장소 권한 부여
# termux-setup-storage (Ubuntu에서는 불필요하거나 다른 방식 사용)

# 패키지 설치

echo "필수 패키지들을 설치합니다"
apt install wget vim git -y

install_gimp
install_proot_Ubuntu

