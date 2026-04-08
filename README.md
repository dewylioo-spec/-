# Border Desk Prototype

`Papers, Please` 느낌을 참고한 **미니 국경 심사 게임 틀**입니다.

## 실행 방법

아무 정적 서버로 열면 됩니다.

```bash
python3 -m http.server 8000
# 브라우저에서 http://localhost:8000 접속
```

## 핵심 구조

- `index.html`: UI 골격
- `styles.css`: 레트로/다크 톤 스타일
- `script.js`: 게임 상태, 규정 검사, 판정 로직

## 확장 아이디어

- 랜덤 입국자 생성기
- 위조 문서/오탈자 검출 미니게임
- 하루 수입/가족 생계 같은 메타 자원
- 스토리 이벤트(뇌물, 테러 경보, VIP 심사)
