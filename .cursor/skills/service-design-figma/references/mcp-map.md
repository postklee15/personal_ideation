# Figma MCP 맵

호출 전에 해당 스킬을 읽는다. `use_figma`는 `skillNames`에 `figma-use`와 이번 작업 스킬을 넣는다.

| 목적 | MCP | 선행 스킬 | 메모 |
| --- | --- | --- | --- |
| 팀/plan 확인 | `whoami` | — | `create_new_file`의 `planKey` |
| Design 파일 생성 | `create_new_file` | `figma-create-new-file` | `editorType: design`. 다이어그램 앞에 쓰지 않음 |
| IA/시퀀스/상태/ER | `generate_diagram` | `figma-generate-diagram` | 지원: flowchart, sequenceDiagram, stateDiagram, gantt, erDiagram. 마인드맵·저니·C4 불가 |
| 캔버스 읽기/쓰기 | `use_figma` | `figma-use` (+ 작업별) | 페이지는 `setCurrentPageAsync`. 호출마다 첫 페이지로 리셋 |
| FigJam 주석 | `use_figma` | `figma-use-figjam` | FigJam에서 `createPage` 금지 |
| 시각 검증 | `get_screenshot` | — | 섹션 node id로. 전체만 찍으면 잘림이 안 보임 |
| 구조 확인 | `get_metadata` | — | 기존 화면 갱신 전 |
| 라이브러리 목록 | `get_libraries` | — | `search_design_system` 전에 |
| 컴포넌트/변수/스타일 검색 | `search_design_system` | — | 로컬 `getLocalVariableCollectionsAsync`가 비어도 원격 변수가 있을 수 있음 |
| 레퍼런스 이미지 | `upload_assets` | — | Plugin API는 외부 URL 이미지를 직접 못 넣음 |
| 라이브 웹 캡처 | `generate_figma_design` | — | 웹이고 URL이 있을 때만. 참고 후 삭제 |
| FigJam 읽기 | `get_figjam` | — | `figma.com/board/...` |
| 구현 참고 | `get_design_context` | `figma-design-to-code` | 참고 코드. 프로젝트에 맞게 옮김 |

## `use_figma`에서 자주 깨지는 것

스킬 `figma-use`가 정본이다. 요약만:

- 색은 0–1. `figma.notify` 금지. `return`으로 node id를 돌려준다.
- 텍스트는 폰트 로드 후 변경.
- `HUG`/`FILL`은 오토레이아웃 부모에 붙인 다음.
- 실패하면 즉시 재시도하지 않는다. 스크립트는 원자적이라 실패분은 적용되지 않는다. 메시지를 읽고 고친다.

## 파일 키

- Design: `figma.com/design/{fileKey}/...`
- FigJam: `figma.com/board/{fileKey}/...`
- node id URL의 `-`는 `:` 로 바꾼다 (`123-456` → `123:456`).
