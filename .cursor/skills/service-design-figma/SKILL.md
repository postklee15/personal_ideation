---
name: service-design-figma
description: >-
  서비스 개요부터 Figma 와이어·테마·하이파이까지 Cursor와 Figma MCP로 진행한다.
  Use when designing a service or app UI from a brief, writing IA or sequence
  diagrams, drawing wireframes, setting app theme / light-dark tokens, building
  a Figma component set, or turning wires into high-fidelity screens.
  Trigger phrases: 와이어프레임, 서비스 디자인, Figma로 그려, 개요부터 디자인,
  App Theme, IA, 시퀀스 다이어그램, 하이파이, 디자인 프로세스.
disable-model-invocation: false
---

# 서비스 디자인 (Cursor + Figma MCP)

서비스를 **개요 → 구조 → 와이어 → 토큰/컴포넌트 → 하이파이** 순으로 만든다. 색 있는 화면을 먼저 그리지 않는다.

이 스킬은 **순서와 게이트**를 담당한다. Figma API 문법·토큰 생성·화면 조립은 아래 전제 스킬을 해당 호출 직전에 읽는다.

## 전제 스킬 (호출 직전 로드)

| 하려 할 일 | 먼저 읽을 스킬 | MCP |
| --- | --- | --- |
| 빈 Design 파일 | `figma-create-new-file` | `create_new_file` |
| IA/시퀀스/상태 그림 | `figma-generate-diagram` | `generate_diagram` |
| Design 캔버스 쓰기 | `figma-use` | `use_figma` |
| FigJam 주석·정리 | `figma-use` + `figma-use-figjam` | `use_figma` |
| 변수·컴포넌트 라이브러리 | `figma-use` + `figma-generate-library` | `use_figma` |
| 화면 조립 | `figma-use` + `figma-generate-design` | `use_figma` |
| 구현 참고 | `figma-design-to-code` | `get_design_context` |

`generate_diagram` 앞에 `create_new_file`을 쓰지 않는다. 다이어그램 도구가 FigJam을 만든다. 두 번째부터는 같은 `fileKey`를 넘긴다.

상세 도구 표는 [references/mcp-map.md](references/mcp-map.md).

## 절대 규칙

1. **피델리티를 건너뛰지 않는다.** G1 통과 전에 브랜드 컬러·그림자·이미지를 넣지 않는다.
2. **없는 기능을 창작하지 않는다.** brief에 없으면 빈칸으로 표시하고 사용자에게 묻는다.
3. **토큰 → 컴포넌트 → 화면.** hex를 화면에 박지 않는다. Light/Dark는 변수 모드다.
4. **MCP는 작게.** 한 `use_figma`에 섹션 하나. 아이콘은 SVG import. 선·원 회전으로 아이콘을 만들지 않는다.
5. **G1·G2는 사람 게이트다.** 체크리스트를 보여준 뒤 **여기서 멈춘다.** 사용자가 통과를 명시하기 전에 다음 단계로 가지 않는다.

## 산출물 위치

이 저장소는 아이데이션 전용이다. **디자인하는 서비스마다** 폴더를 새로 연다. 프로세스 문서 폴더(`ideas/2026-08-18-cursor-figma-design-process/`)에 서비스 본문을 섞지 않는다.

```text
ideas/YYYY-MM-DD-<service-slug>/
  README.md
  brief.md
  screens.md
  progress.md
```

날짜는 세션 당일. slug는 ASCII kebab. 루트 카탈로그(`README.md`)에 한 줄을 넣고, 폴더를 연 직후 커밋한다. 규칙은 `.cursor/rules/ideation-git.mdc`.

Figma:

- Design: `{서비스} — Product Design` — 페이지 `00 Cover / 01 Wireframes / 02 Theme / 03 Components / 04 Screens`
- FigJam: `{서비스} — IA & Flows` — `generate_diagram`이 만들게 둔다

`fileKey`와 URL은 `progress.md`에 적는다.

## 세션 시작

1. 이 스킬을 적용 중이라고 한 줄로 알린다.
2. 서비스 slug·기존 `progress.md`·Figma URL이 있는지 확인한다. 이어 하기면 기록된 단계부터.
3. 범위가 없으면 사용자에게 묻는다: 이번 요청이 한 단계인지, G1까지인지, 하이파이까지인지.
4. 단계에 들어가기 **전에** 사용자에게 `Phase N Checklist`를 보여준다. 게이트 단계가 아니면 체크리스트 후 바로 실행해도 된다.
5. 단계가 끝나면 `Phase N Summary`(URL, node id, 결정, 다음 단계)를 남기고 `progress.md`를 갱신한다.

사용자가 “한 단계만”이면 그 단계에서 멈춘다. “끝까지”여도 **G1과 G2에서는 반드시 멈춘다.**

단계 본문은 [references/phases.md](references/phases.md). 프롬프트 골격은 [references/prompts.md](references/prompts.md). 템플릿은 [references/templates.md](references/templates.md).

## 단계

| ID | 이름 | Agent | 사람 |
| --- | --- | --- | --- |
| P0 | 사전 준비 | MCP, Design 파일, 페이지, 플랫폼 | plan·제약이 맞는지 |
| P1 | 서비스 개요 | `brief.md` | 목적·비목표·과업 |
| P2 | IA · 다이어그램 | 사이트맵 플로차트, 시퀀스 1, 상태 1 | 구조 |
| P3 | 화면 인벤토리 | `screens.md` | P0 범위 |
| P4 | 와이어 | 회색, P0 화면, 섹션 단위 | — |
| **G1** | 구조 게이트 | 질문 5개만. 그리지 않음 | **통과 명시** |
| P5 | 테마 · 토큰 | 레퍼런스, semantic, Light/Dark 모드 | 무드·토큰 |
| P6 | 컴포넌트 | 최소 원자, 변수 바인딩 | 세트 확인 |
| P7 | 하이파이 | 인스턴스 조립, 와이어 페이지 유지 | — |
| **G2** | 디자인 게이트 | 대비·탭·빠진 상태 표 | **통과 명시** |
| 닫기 | 프로토 · 핸드오프 | 시퀀스 1개만 연결. 코드는 요청 시에만 | 엔지니어 |

기존 팀 습관 매핑: 개요=P1, 다이어그램=P2, 와이어=P4, 테마·레퍼런스 디자인=P5–P7.

## 단계 사이 출력

매 단계 끝에 사용자에게 짧게:

- 한 일
- Figma/FigJam 링크
- `progress.md`에 적은 단계
- 다음 단계 이름. 게이트면 “통과하면 P5 진행”처럼 멈춘다

## 금지

- “레퍼런스처럼 앱 전체를 예쁘게”
- 다이어그램을 돌릴 때마다 새 FigJam
- 다크 화면을 복제해 색만 반전 (모드는 변수)
- 에러 없는 스크립트 = 성공으로 간주. `get_screenshot`으로 잘림·플레이스홀더·폰트를 본다
- 이 저장소에서 앱/`src`를 디자인 산출물 대신 만들기. 핸드오프 코드를 요청받았을 때만, 그리고 `get_design_context`는 참고다
- G1 전에 P5 이후를 “미리” 실행
