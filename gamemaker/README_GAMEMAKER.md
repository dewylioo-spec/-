# GameMaker 버전 적용 가이드 (상세)

이 폴더는 기존 프로젝트에 **기능만 이식**하려는 경우를 위한 복붙형 스캐폴드입니다.

> 바로 실행형이 필요하면: `../gamemaker-project/BorderDesk/BorderDesk.yyp`

## 적용 순서 (정확히)

1. Script 생성
   - `scr_border_data_init`
   - `scr_border_flow`
2. 각 Script에 아래 파일 내용을 복사
   - `scripts/scr_border_data_init.gml`
   - `scripts/scr_border_flow.gml`
3. Object 생성
   - 이름: `obj_border_controller`
4. Object 이벤트 추가
   - Create → `objects/obj_border_controller/Create_0.gml`
   - Step → `objects/obj_border_controller/Step_0.gml`
   - Draw GUI → `objects/obj_border_controller/Draw_GUI_0.gml`
5. Room에 `obj_border_controller` 인스턴스 1개 배치
6. 실행 후 `A/D/R` 입력 확인

## 기능 매핑

- `scr_border_data_init`
  - `global.bd_state`: day/score/mistakes/current 등 상태
  - `global.bd_rules`: 날짜별 규정 + checker 함수
  - `global.bd_entrants`: 샘플 입국자 목록
  - `global.bd_log`: 최근 로그 배열
- `scr_border_flow`
  - `scr_border_set_current()`: 현재 입국자 로드
  - `scr_border_push_log()`: 로그 누적(최대 12개)
  - `scr_border_evaluate(approve)`: 판정/점수/실수/Day 증가

## 입력/출력 규칙

- 입력
  - `A`: 승인
  - `D`: 거부
  - `R`: 상태 초기화
- 출력
  - Draw GUI에서 Day/Score/Mistakes, 규정, 입국자 데이터, 최근 결과, 로그 표시

## 자주 하는 수정

1. 난이도 올리기
   - `scr_border_data_init`의 `global.bd_rules`에 규정 추가
2. 케이스 늘리기
   - `global.bd_entrants` 배열에 struct 추가
3. UI 분리
   - Draw GUI 코드를 `scr_ui_draw_border_desk()` 함수로 분리

## 주의사항

- 현재 구현은 빠른 프로토타입 목적입니다.
- 게임패드/마우스 입력, 저장 시스템, 폰트 리소스는 포함하지 않았습니다.
- 한글 폰트 깨짐이 있으면 Font 리소스를 생성 후 `draw_set_font()`를 지정하세요.
