# 단계 본문

각 단계에 들어가기 전에 SKILL.md의 체크리스트 규칙을 따른다. 도구 이름은 [mcp-map.md](mcp-map.md).

## P0 사전 준비

**할 일**

- Figma MCP가 붙어 있는지 확인. `whoami`로 plan 목록을 보여 주고, 팀이 여럿이면 어디에 파일을 만들지 묻는다.
- `create_new_file` (`editorType: design`, 이름 `{서비스} — Product Design`).
- 페이지: `00 Cover`, `01 Wireframes`, `02 Theme`, `03 Components`, `04 Screens`.
- Cover에 제목, 플랫폼, 기준 프레임만 (예: iOS 390×844).
- `progress.md`에 `designFileKey`, URL, 플랫폼, 프레임을 적는다.

**하지 말 일:** 화면, 컬러, 컴포넌트, FigJam을 이 단계에서 만들지 않는다.

**종료:** 파일 URL + 페이지 목록. 사용자 제약이 비어 있으면 TODO로 남기고 P1에서 채운다.

## P1 서비스 개요

`brief.md`를 [templates.md](templates.md) 항목으로 채운다. 모르는 칸은 `TODO`.

이미 하던 것: 목적, 타겟, 사용자 시나리오.  
반드시 추가: 한 줄 문제, 하지 않을 일, 핵심 과업 3, 성공 기준, 레퍼런스 3~5개와 가져올 점/버릴 점.

레퍼런스는 테마 단계가 아니라 여기에 적는다. 다이어그램·와이어는 그리지 않는다.

## P2 IA · 다이어그램

`brief.md`만 근거로 `generate_diagram`을 호출한다.

1. 사이트맵 — Mermaid `flowchart`, 깊이 3단. 마인드맵·저니·C4는 도구가 거절한다.
2. 핵심 시나리오 1개 — `sequenceDiagram`. `Note`는 렌더러가 버린다.
3. 로그인·권한 등 분기 — `stateDiagram-v2`.
4. 데이터 모델이 핵심일 때만 `erDiagram`.

제약: 이모지, 라벨 HTML, `\n` 이스케이프 금지. brief에 없는 노드는 창작하지 않고 빈칸으로 표시.

같은 보드에 이을 때는 `fileKey`를 넘긴다. `progress.md`에 `figjamFileKey`를 적는다. 두 번 그려도 부족하면 사람에게 FigJam 편집을 맡긴다.

## P3 화면 인벤토리

`screens.md` 표: ID, 이름, 진입, 핵심 과업, 우선순위(P0/P1/P2), 상태(Default / Empty / Loading / Error / Success / Permission). 없으면 `N/A`.

이번 작업 범위는 **P0 화면만** 따로 나열한다. Figma 와이어는 아직 그리지 않는다.

## P4 와이어프레임

`01 Wireframes`에 `screens.md`의 P0만.

- 색: `#111111` / `#666666` / `#DDDDDD`만. 그림자·비트맵·브랜드 컬러 금지.
- 화면마다 기준 디바이스 프레임 하나.
- 래퍼를 먼저 만들고 섹션은 그 안. 한 `use_figma`에 섹션 하나.
- Auto Layout. 카피는 실제 문장. Lorem 금지.
- 섹션마다 `get_screenshot`. 겹침·잘린 글자만 고친다.
- `01 Wireframes`는 이후 단계에서 덮어쓰지 않는다.

## G1 구조 게이트 (정지)

그리지 않는다. 사용자에게만 묻는다.

1. 핵심 과업 3개가 화면 목록에 있는가
2. 시퀀스 hop이 화면 ID와 맞는가
3. Empty/Error 목적지가 있는가
4. P0 밖 화면을 와이어에 넣지 않았는가
5. 카피만 읽어도 위계가 보이는가

사용자가 통과를 명시하면 `brief.md`와 `progress.md`에 `G1 pass`와 고친 점을 적는다. “괜찮으면 디자인까지”는 통과가 아니다.

## P5 테마 · 토큰

G1 pass 후에만. `figma-generate-library`의 토큰 순서(컬렉션 → primitive → semantic → scope → 텍스트/이펙트 스타일)를 따른다.

- 레퍼런스 이미지를 Theme 페이지에 둔다 (`upload_assets` 또는 파일에 이미 있는 이미지 해시).
- 무드 키워드 4개를 Cover 또는 Theme에 적는다.
- Color primitives + semantic(`bg`, `surface`, `text`, `border`, `accent`, `danger`, `success`).
- Light / Dark는 **같은 컬렉션의 모드**.
- space, radius, type scale, elevation(effect style).
- 변수마다 `scopes`. `ALL_SCOPES` 금지.
- 팀 라이브러리가 있으면 `get_libraries` → `search_design_system`이 로컬 생성보다 앞선다.

화면·컴포넌트는 만들지 않는다. 토큰 페이지를 스크린샷으로 보여주고 멈출지, 사용자가 이미 P6까지 허용했는지 본다. 허용이 없으면 여기서 멈춘다.

## P6 컴포넌트

Theme 변수만 사용. `03 Components` 최소 세트: Button, Text field, List row, Nav 또는 Tab bar, Card, Banner, Empty state.

- variant: size, hierarchy, state.
- 색·간격은 바인딩. hex 금지.
- 아이콘은 SVG `createNodeFromSvg`. 코드/`currentColor`는 import 후 색을 지정한다.
- 화면은 그리지 않는다. 컴포넌트 페이지 스크린샷 후, P7 허가가 없으면 멈춘다.

## P7 하이파이

`04 Screens`에 P0부터. Light 모드가 기본.

- `01 Wireframes`는 수정하지 않는다.
- `03 Components` 인스턴스로 조립. 박스를 다시 그리지 않는다.
- 래퍼 → 섹션 단위 `use_figma` → 섹션 `get_screenshot`.
- 플레이스홀더 문구(`Title`, `Heading`, `Button`)가 남으면 실패다.
- Dark는 프레임 복제가 아니라 변수 모드로 한 장 검증.
- 웹이고 라이브 URL이 있을 때만 `generate_figma_design` 캡처를 참고로 병행하고, 맞춘 뒤 캡처 노드는 지운다.

## G2 디자인 게이트 (정지)

표로 보고하고 수정은 사용자가 고른 뒤:

- 대비율, 탭 영역 44px, 잘린 글자
- 와이어 대비 빠진 상태(Empty/Error 등)
- 잘못된 폰트(요청하지 않은 Inter 등)

통과 명시에 `G2 pass`를 기록한다.

## 닫기 (선택)

- 프로토: 핵심 시퀀스 **1개**만 연결. 전 화면 연결 금지.
- 핸드오프: 사용자가 구현을 요청한 경우에만 `get_design_context`. 결과는 참고이며 이 저장소에 앱을 새로 만들지 않는다. Code Connect는 라이브러리가 안정된 뒤.
