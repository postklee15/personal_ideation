# Cursor + Figma MCP 프롬프트 치트시트

PT 슬라이드(`deck.html`)의 단계와 같은 번호다. 대괄호만 채워 붙인다.

공통으로 네 줄을 앞에 둔다.

```text
역할: Cursor + Figma MCP로 [단계]만 수행.
입력: brief.md, screens.md, Figma fileKey [ ], 지금 페이지 [ ].
범위: [화면 ID 또는 컴포넌트]. 다음 단계로 넘어가지 마.
제약: 없는 기능을 창작하지 마. hex 하드코딩 금지(P5 이후).
완료: 만든 node id / file URL과 get_screenshot 결과를 보고하고 멈춰.
```

## P0 사전 준비

```text
Figma MCP 연결을 확인하고 whoami로 plan을 보여줘.
Design 파일 "{서비스} — Product Design"을 create_new_file로 만들어.
페이지: 00 Cover, 01 Wireframes, 02 Theme, 03 Components, 04 Screens.
지금은 페이지 이름과 Cover의 제목·플랫폼·기준 프레임( [예: 390x844] )만.
화면, 컬러, 컴포넌트는 만들지 마.
```

## P1 서비스 개요

```text
아래 항목으로 brief.md를 작성해. 모르는 칸은 TODO로 남겨.
- 한 줄 문제, 목적, 타겟
- 하지 않을 일
- 핵심 과업 3개
- 사용자 시나리오(행복 경로 1, 실패 경로 1)
- 성공 기준
- 레퍼런스 URL 3~5개와 각 항목의 가져올 점 / 버릴 점
- 플랫폼, 기준 프레임, 기존 디자인 시스템 유무
디자인이나 다이어그램은 그리지 마.
```

## P2 IA · 다이어그램

```text
brief.md만 근거로 FigJam 다이어그램을 만들어.
1) 사이트맵: Mermaid flowchart, 깊이 3단. 마인드맵 쓰지 마.
2) 핵심 시나리오 1개: sequenceDiagram. Note 넣지 마.
3) 로그인·권한: stateDiagram-v2.
generate_diagram을 쓰고, 보드가 있으면 같은 fileKey에 이어 그려.
brief에 없는 노드는 창작하지 말고 빈칸으로 표시해.
```

## P3 화면 인벤토리

```text
brief와 FigJam 사이트맵을 읽어 screens.md 표를 만들어.
열: ID, 이름, 진입, 핵심 과업, 우선순위(P0/P1/P2), 상태(Default/Empty/Loading/Error/Success/Permission).
해당 없는 상태는 N/A.
이번 작업 범위는 P0만 별도로 나열해. Figma에는 아직 그리지 마.
```

## P4 와이어프레임

```text
01 Wireframes에 screens.md의 P0 화면만 그려.
회색 #111 / #666 / #DDD만. 컬러, 그림자, 비트맵 금지.
각 화면은 기준 디바이스 프레임 하나.
래퍼 프레임을 먼저 만들고, 섹션은 그 안에, 한 호출에 섹션 하나.
카피는 실제 문장에 가깝게. Lorem 금지.
섹션마다 get_screenshot으로 겹침·잘림을 고친 뒤 다음으로.
```

## G1 게이트 (사람)

```text
G1 리뷰야. 디자인하지 마.
질문:
1) 핵심 과업 3개가 화면 목록에 있는가
2) 시퀀스 hop이 화면 ID와 맞는가
3) Empty/Error 목적지가 있는가
4) P0 밖 화면을 와이어에 넣지 않았는가
5) 카피만 읽어도 위계가 보이는가
통과/보류와 수정 목록만 brief.md에 적어.
```

## P5 테마 · 토큰

```text
G1 pass 이후에만 진행.
02 Theme에 레퍼런스 이미지를 두고, 무드 키워드 4개를 Cover 또는 Theme에 적어.
변수 컬렉션:
- Color primitives + semantic(bg, surface, text, border, accent, danger, success)
- Light / Dark는 같은 컬렉션의 모드
- space, radius. 텍스트 스타일 스케일. elevation은 effect style
변수 scope를 명시하고 ALL_SCOPES는 쓰지 마.
팀 라이브러리가 있으면 get_libraries → search_design_system이 먼저다.
화면과 컴포넌트는 만들지 마. 토큰 페이지를 스크린샷으로 보여준 뒤 멈춰.
```

## P6 컴포넌트

```text
02 Theme 변수만 써서 03 Components에 최소 세트를 만들어.
Button, Text field, List row, Nav 또는 Tab bar, Card, Banner, Empty state.
variant: size, hierarchy, state.
색·간격은 바인딩. hex 금지.
아이콘은 SVG import. 선과 원을 회전시켜 아이콘을 만들지 마.
끝나면 컴포넌트 페이지 스크린샷만 보고하고 화면은 그리지 마.
```

## P7 하이파이

```text
04 Screens에 화면 [ID]만. Light 모드.
01 Wireframes는 수정하지 마.
03 Components 인스턴스로 조립하고 박스를 다시 그리지 마.
래퍼를 만든 뒤 섹션 단위로 use_figma.
섹션마다 get_screenshot. 잘린 글자, 겹침, 남은 플레이스홀더("Title")를 고친다.
Dark는 프레임 복제가 아니라 변수 모드로 한 장 검증.
```

## G2 · 프로토 · 핸드오프

```text
G2: 화면 [ID]의 대비율, 44px 탭, 와이어 대비 빠진 상태를 표로 보고해. 수정은 내가 고르면.

프로토: 시퀀스 [이름]에 해당하는 화면만 Prototype 연결해. 전 화면 연결 금지.

핸드오프(선택): 화면 [node]에 get_design_context를 쓰고,
이 저장소의 기존 컴포넌트 이름에 맞춰 참고만 정리해. 앱 코드를 새로 만들지 마.
```
