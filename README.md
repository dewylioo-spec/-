# Border Desk Prototype

`Papers, Please` 느낌을 참고한 **미니 국경 심사 게임 틀**입니다.

이 저장소는 같은 게임 루프를 두 방식으로 제공합니다.

1. **웹 프로토타입(즉시 실행)**: `index.html`, `styles.css`, `script.js`
2. **GameMaker 프로젝트(즉시 열기)**: `gamemaker-project/BorderDesk/BorderDesk.yyp`
3. **GameMaker 복붙형 스캐폴드**: `gamemaker/`

---

## 1) 웹 버전 상세 가이드

### 실행

```bash
python3 -m http.server 8000
# 브라우저에서 http://localhost:8000 접속
```

### 플레이 흐름

- 화면에 입국자 정보/서류가 표시됩니다.
- **승인** 또는 **거부**를 누르면 판정됩니다.
- 판정 후 **다음 입국자** 버튼으로 진행합니다.
- 3명 심사할 때마다 Day가 올라가고 규정이 추가됩니다.
- 실수 3회 누적 시 게임 오버입니다.

### 웹 로직 핵심 파일

- `index.html`: 패널 레이아웃(입국자, 서류, 규정, 로그, 버튼)
- `styles.css`: 다크 테마, 카드 UI, 버튼 상태
- `script.js`:
  - `state`: day, score, mistakes, queueIndex
  - `dayRules`: 날짜별 규정 + checker 함수
  - `evaluateDecision()`: 승인/거부 정오 판정
  - `renderRules()`, `renderEntrant()`: 화면 갱신

---

## 2) GameMaker 즉시 실행 버전 상세 가이드

### 열기

1. GameMaker Studio 2.3+ 실행
2. `gamemaker-project/BorderDesk/BorderDesk.yyp` 열기
3. `rm_main` 실행(F5)

### 조작

- `A`: 승인
- `D`: 거부
- `R`: 게임 리셋

### 리소스 구성

- Scripts
  - `scr_border_data_init`: 전역 상태/규정/입국자 데이터 초기화
  - `scr_border_flow`: 현재 입국자 세팅, 로그, 판정 처리
- Object
  - `obj_border_controller`
    - Create: 초기화
    - Step: 입력 처리(A/D/R)
    - Draw GUI: 상태/규정/문서/로그 렌더링
- Room
  - `rm_main`: `obj_border_controller` 인스턴스 포함

---

## 3) GameMaker 복붙형 스캐폴드 사용법

기존 GameMaker 프로젝트에 기능만 이식하려면 `gamemaker/README_GAMEMAKER.md`를 참고해 아래를 붙여넣으면 됩니다.

- `scripts/scr_border_data_init.gml`
- `scripts/scr_border_flow.gml`
- `objects/obj_border_controller/Create_0.gml`
- `objects/obj_border_controller/Step_0.gml`
- `objects/obj_border_controller/Draw_GUI_0.gml`

---

## 4) 커스터마이징 포인트 (빠른 확장)

### A. 규정 추가

- 웹: `script.js`의 `dayRules`에 Day 4+ 규정 추가
- GML: `scr_border_data_init`의 `global.bd_rules`에 규정 struct 추가

예: “Arstotzka 국민만 입국 가능”, “transit은 최대 2일” 등.

### B. 데이터 랜덤화

- 현재는 고정 배열 샘플입니다.
- 랜덤 이름/국적/목적 생성기로 교체하면 리플레이성이 좋아집니다.

### C. 검문 깊이 확장

- 현재: 여권 유효 + 금지 국가 + 취업허가서
- 확장: 만료일 비교, 성명 오탈자, 지문/사진 대조, 위조 마킹

### D. 메타 게임

- 하루 수입/벌금, 가족 생계비, 난방비
- 벌금 누적 시 난이도 상승/엔딩 분기

---

## 5) 트러블슈팅

### GameMaker에서 프로젝트가 안 열릴 때

- GameMaker 버전을 **2.3+**로 확인
- 프로젝트를 다른 경로로 복사 후 다시 열기
- `BorderDesk.yyp`를 직접 더블클릭하지 말고 IDE에서 Open Project로 열기

### 한글 텍스트가 깨질 때

- Draw GUI에서 쓰는 폰트를 한글 지원 폰트로 교체
- 필요 시 Font 리소스를 생성하고 `draw_set_font()` 적용

### 입력이 안 먹을 때

- `obj_border_controller`가 `rm_main`에 배치됐는지 확인
- Step 이벤트 코드가 비어있지 않은지 확인

---

## 6) 다음 단계 제안

원하시면 다음 작업까지 이어서 해드릴 수 있습니다.

1. **실제 문서 대조 UI**(드래그/확대/하이라이트)
2. **랜덤 케이스 생성기**(난이도 곡선 포함)
3. **저장/불러오기**(day, score, penalties)
4. **사운드/연출**(스탬프, 경고음, UI 전환 효과)
