# Termux Setup

모듈화된 스크립트를 통해 Termux 환경을 쉽고 빠르게 초기화하고 관리할 수 있는 도구입니다.

## 🚀 빠른 시작 (Quick Start)

Termux를 처음 설치했거나 초기화한 후, 아래 명령어를 복사하여 붙여넣으세요:

```bash
curl -fsSL https://raw.githubusercontent.com/Elaski6573/termux-setup/main/init.sh | bash
```

## 🛠 작동 원리

이 프로젝트는 다음과 같은 단계로 자동 실행됩니다:

1.  **`init.sh` (부트스트랩)**: `git`을 선제적으로 설치하고 리포지토리를 `~/.termux-setup-env` 폴더에 클론합니다.
2.  **`termux-manager.sh` (자동 실행)**: 클론이 완료되면 `init.sh`에 의해 자동으로 실행되어 전체 설치 프로세스를 관리합니다.
3.  **모듈별 스크립트 실행**:
    *   시스템 초기화 (저장소 권한, 한글 입력 설정 등)
    *   핵심 패키지 설치 (Vim, Python, Clang 등 개발 도구 선택 가능)
    *   Gemini CLI 설치 (에러 방지를 위한 환경 변수 자동 설정 포함)
    *   특수 앱 설치 (GIMP 및 GUI 환경 설정)

## 📂 구조 (Structure)

*   `init.sh`: 원격 진입점 스크립트
*   `termux-manager.sh`: 메인 관리자 스크립트
*   `scripts/system-init.sh`: 시스템 환경 및 스토리지 설정
*   `scripts/install/core-packages.sh`: 필수 유틸리티 및 개발 도구
*   `scripts/install/gemini-cli.sh`: Gemini CLI 전용 설치 모듈
*   `scripts/install/special-apps.sh`: GUI 앱(GIMP 등) 설치 및 설정

## 📝 참고 사항

*   설치 과정 중 저장소 권한 획득을 위한 안드로이드 팝업이 나타나면 '허용'을 눌러주세요.
*   설치가 완료된 후 `~/.termux-setup-env` 폴더를 유지하면 나중에 다시 설정을 변경할 때 유용합니다.
