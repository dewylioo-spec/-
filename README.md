# Border Desk Prototype

`Papers, Please` 느낌을 참고한 **미니 국경 심사 게임 틀**입니다.

## 제공 버전

- 웹 프로토타입: `index.html`, `styles.css`, `script.js`
- GameMaker용 GML 스캐폴드: `gamemaker/` 폴더

## 웹 실행 방법

```bash
python3 -m http.server 8000
# 브라우저에서 http://localhost:8000 접속
```

## GameMaker 적용 방법

`gamemaker/README_GAMEMAKER.md`를 따라 Script/Object 이벤트에 코드를 붙여 넣으면 바로 플레이 가능한 기본 틀이 동작합니다.

## 핵심 구조 (웹)

- `index.html`: UI 골격
- `styles.css`: 레트로/다크 톤 스타일
- `script.js`: 게임 상태, 규정 검사, 판정 로직
