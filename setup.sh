#!/data/data/com.termux/files/usr/bin/bash

# 패키지 업데이트 & 패키지 설치
echo "패키지를 업데이트합니다.."
if pkg update && pkg upgrade -y; then
    echo "업데이트 완료"
else
    echo "pkg에서 오류가 발생하여 apt로 대체하여 실행합니다."
    if apt-get update && apt-get upgrade -y; then
        echo "업데이트 완료"
    else
        echo "오류가 발생했습니다. 자세한 사항은 로그를 확인하세요"
        exit 1
    fi
fi

echo "1. 필수 패키지 설치하기"
echo "2. 끝내기"
read choice

if ["$choice" = "1"]; then
    echo "필수 패키지들을 설치합니다"
    pkg install wget vim git -y
else
    echo "종료합니다"
    exit 1
fi
