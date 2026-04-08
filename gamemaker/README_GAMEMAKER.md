# GameMaker 버전 적용 가이드

이 폴더는 기존 웹 프로토타입 로직을 **GameMaker Studio 2.3+ (GML)** 에서 바로 옮겨 쓸 수 있도록 만든 스캐폴드입니다.

## 구성

- `scripts/scr_border_data_init.gml`
  - 상태값, 규정, 입국자 샘플 데이터 초기화
- `scripts/scr_border_flow.gml`
  - 현재 입국자 로딩, 로그 추가, 승인/거부 판정 처리
- `objects/obj_border_controller/Create_0.gml`
  - 초기화 진입점
- `objects/obj_border_controller/Step_0.gml`
  - 입력 처리 (`A` 승인 / `D` 거부 / `R` 리셋)
- `objects/obj_border_controller/Draw_GUI_0.gml`
  - GUI 출력

## 적용 순서

1. GameMaker 프로젝트에서 Script 2개 생성 후 각 파일 내용 붙여넣기
   - `scr_border_data_init`
   - `scr_border_flow`
2. Object `obj_border_controller` 생성
3. 아래 이벤트 코드 붙여넣기
   - Create: `Create_0.gml`
   - Step: `Step_0.gml`
   - Draw GUI: `Draw_GUI_0.gml`
4. Room에 `obj_border_controller` 인스턴스 배치 후 실행

## 다음 확장 추천

- 문서 위조 검출: 텍스트 오탈자/만료일 비교 시스템
- 랜덤 생성: 국적/목적/위반 케이스 조합기
- 경제 시스템: 일당, 벌금, 가족 생계 비용
- 스토리 분기: 이벤트 카드 및 NPC 관계도
