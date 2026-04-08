# GameMaker 버전 적용 가이드

이 저장소에는 GameMaker 대응이 두 가지로 준비되어 있습니다.

1. **코드 복붙형 스캐폴드**: 현재 폴더(`gamemaker/`)
2. **바로 열기용 프로젝트**: `../gamemaker-project/BorderDesk/BorderDesk.yyp`

## 바로 실행(권장)

1. GameMaker Studio 2.3+에서 `gamemaker-project/BorderDesk/BorderDesk.yyp` 열기
2. Room `rm_main` 실행
3. 입력:
   - `A` 승인
   - `D` 거부
   - `R` 리셋

## 복붙형 적용이 필요한 경우

기존 프로젝트에 수동 적용하려면 아래 파일을 사용하세요.

- `scripts/scr_border_data_init.gml`
- `scripts/scr_border_flow.gml`
- `objects/obj_border_controller/Create_0.gml`
- `objects/obj_border_controller/Step_0.gml`
- `objects/obj_border_controller/Draw_GUI_0.gml`
