# version: beta-0.0.1
#!/bin/bash

# 스크립트 정보
Version="beta-0.0.1"
echo "ADB Camera Shutter Sound Muter"
echo "Version: $Version"
echo "----------------------------------------"

# adb 명령어 존재 여부 확인 및 자동 설치
if ! command -v adb &> /dev/null; then
    echo "adb 명령어를 찾을 수 없습니다. android-tools를 설치하시겠습니까? (y/n)"
    read -p "> " install_adb
    if [[ "$install_adb" == "y" || "$install_adb" == "Y" ]]; then
        echo "android-tools 설치를 시작합니다..."
        apt install -y android-tools-adb android-tools-fastboot
        if ! command -v adb &> /dev/null; then
            echo "설치에 실패했습니다. 수동으로 'apt install android-tools-adb'를 실행해 주세요."
            exit 1
        fi
        echo "adb 설치 완료."
    else
        echo "adb가 필요하여 스크립트를 종료합니다."
        exit 1
    fi
fi

# 사용자로부터 IP 주소와 연결 포트를 입력받습니다.
echo "디바이스의 IP 주소를 입력하세요 (예: 192.168.1.10):"
read -p "IP Address: " ip

echo "연결 포트 번호를 입력하세요 (무선 디버깅 메뉴의 'IP 주소 및 포트' 아래에 표시된 5자리 숫자):"
read -p "Connect Port: " connect_port

# 이미 페어링된 기기인지 확인합니다.
read -p "새로운 기기를 페어링해야 합니까? (y/n): " needs_pairing

if [[ "$needs_pairing" == "y" || "$needs_pairing" == "Y" ]]; then
  echo "페어링 포트 번호를 입력하세요 (무선 디버깅 메뉴의 'IP 주소 및 포트' 옆에 표시된 숫자):"
  read -p "Pairing Port: " pair_port

  echo "페어링 코드를 입력하세요:"
  read -p "Pairing Code: " code

  # adb를 통해 디바이스와 페어링합니다.
  echo "페어링을 시도합니다..."
  adb pair $ip:$pair_port $code
fi

# adb를 통해 디바이스에 연결합니다.
echo "연결을 시도합니다..."
adb connect $ip:$connect_port

# 연결 상태 확인
sleep 2 # 연결 시간을 잠시 줍니다.
adb devices | grep -q "$ip:$connect_port"
if [ $? -eq 0 ]; then
  # 카메라 셔터음을 비활성화합니다.
  echo "카메라 셔터음 비활성화를 시도합니다..."
  adb shell settings put system csc_pref_camera_forced_shuttersound_key 0

  echo ""
  echo "모든 과정이 완료되었습니다."
  echo "카메라 셔터음 비활성화 설정이 적용되었습니다. 이제 휴대폰을 무음 또는 진동 모드로 설정하면 셔터음이 나지 않습니다."
else
  echo "연결에 실패했습니다. IP 주소와 포트를 확인하고, 필요한 경우 페어링을 다시 시도하세요."
fi

# 스크립트 종료 전 연결을 해제합니다.
echo "작업 완료. 기기와의 연결을 해제합니다..."
adb disconnect $ip:$connect_port
