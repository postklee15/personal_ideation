# Cursor + Figma MCP vs Claude Design

- 기준일: 2026-08-19
- Claude Design: Anthropic Labs 베타 (`claude.com/product/design`, 2026-04 공개, 2026-06 디자인 시스템·Claude Code 동기화 강화)
- Cursor + Figma MCP: 이 폴더의 프로세스와 `.cursor/skills/service-design-figma`

둘은 같은 자리를 두고 겨루지 않는다. **진실의 원천**이 다르다.

| | Cursor + Figma MCP | Claude Design |
| --- | --- | --- |
| 한 줄 | Figma를 시스템 오브 레코드로 두고, Agent가 개요→와이어→토큰→화면을 순서대로 그린다 | 설명하면 초안을 만들고, 대화·슬라이더·직접 편집으로 다듬은 뒤 프로토·덱·코드로 보낸다 |
| 산출물 | FigJam 다이어그램, Figma 변수/컴포넌트/화면, `brief.md` | 인터랙티브 프로토타입, PPTX/PDF/HTML, 조직 링크, Claude Code 핸드오프 |
| 연결 | Figma MCP (`use_figma`, `generate_diagram`, `get_design_context`) | GitHub·코드베이스·디자인 파일 import, `/design-sync`, Adobe·Canva·Miro·Lovable·Replit·Vercel 등. **Figma는 Claude Design 커넥터 목록에 없다** |
| 협업 | Figma 멀티플레이어, 코멘트, 라이브러리 | 조직 범위 링크, 그룹 대화로 Claude와 같이 수정 |
| 성숙도 | Figma 자체는 제품 디자인 SoR. Agent가 캔버스에 쓰는 품질은 섹션 단위·스크린샷 검증이 필요 | 베타. 에디터(드래그·리사이즈)와 브랜드 고정이 강화 중 |

## 한 장으로

- **탐색·클릭 가능한 데모·덱** → Claude Design이 빠르다.
- **IA 게이트, 토큰, 컴포넌트, 기존 Figma 리뷰 문화, 네이티브 앱 스펙** → Cursor + Figma MCP가 맞다.
- 실무는 보통 **Claude Design으로 방향을 고르고, 확정분은 Figma에 심는다.** 그 반대(Figma를 SoR로 두고 Claude Design은 덱·마케팅)도 성립한다.

---

## 디자이너

### Cursor + Figma MCP

장점

- 변수, 모드(Light/Dark), 컴포넌트 인스턴스가 **지금 팀이 쓰는 파일**에 남는다.
- G1 때문에 “예쁜데 구조가 틀린” 하이파이가 늦게 나온다. 리뷰가 레이아웃·카피부터 가능하다.
- Auto Layout, 라이브러리, FigJam 워크숍, Dev Mode 주석 등 기존 리뷰 루틴을 그대로 쓴다.
- Agent가 그린 뒤에도 디자이너가 픽셀을 직접 고칠 캔버스가 Figma다.

단점

- 한 번에 열두 방향을 뽑는 속도는 느리다. 색 넣기 전에 P0–P4를 탄다.
- Agent 출력은 잘린 글자, 잘못된 폰트, 얕은 컴포넌트 트리가 흔하다. `get_screenshot`과 사람 보정이 필수다.
- 클릭해서 느껴보는 프로토는 P7 이후고, 그 전까지는 정적이다.
- Figma를 고칠 줄 모르는 사람과는 핸드오프가 안 된다.

### Claude Design

장점

- 프롬프트로 방향을 많이 보고, 슬라이더·인라인 코멘트·직접 드래그로 바로 고친다.
- 정적 목업을 **공유 가능한 인터랙티브 프로토**로 바꿔 사용자 테스트할 수 있다. PR이 필요 없다.
- 온보딩에서 코드/디자인 파일을 읽어 브랜드를 맞추고, 출력 전에 디자인 시스템 검사를 돌린다고 한다.
- 랜딩, 소셜, 덱처럼 Figma 밖 작업도 한 제품에서 나간다.

단점

- 팀 Figma 라이브러리의 **라이브 인스턴스**가 아니다. import·검사는 있어도 SoR이 갈라지기 쉽다.
- 벡터 일러스트, 복잡한 컴포넌트 세트, 버전 히스토리, 실시간 멀티 커서는 Figma 쪽이 여전히 강하다.
- 디자이너가 “이미 끝난 그림”을 넘겨받으면 Figma에 **다시 심는** 비용이 생긴다.
- 베타라 에디터 안정성·한도가 채팅/Claude Code와 공유된다.

디자이너에게 맡길 것: 시각 방향·레퍼런스 무드는 Claude Design으로 빨리 보고, **확정 토큰과 반복 UI는 Figma에 심은 뒤** Cursor Skill로 화면을 늘린다.

---

## 기획자

### Cursor + Figma MCP

장점

- `brief.md`, 화면 표, Empty/Error, G1 질문(과업·시퀀스·범위)이 프로세스에 박혀 있다.
- FigJam 사이트맵·시퀀스로 구멍을 드러낸 다음 와이어로 간다. “홈만 예쁜” 함정을 줄인다.
- 이해관계자가 이미 Figma 링크를 본다. 새 툴을 설득할 일이 적다.
- P0 화면만 그리는 범위 통제가 명시적이다.

단점

- 회의 중에 클릭 데모를 보여 주기까지 단계가 길다.
- Cursor MCP, planKey, 파일 페이지 규약이 필요하다. 기획자 혼자 밀기 어렵다.
- 산출물이 문장·그레이 와이어라, 임원 자리에서는 “덜 된 것”으로 보일 수 있다.

### Claude Design

장점

- 아이디어를 그 자리에서 그림·프로토로 만든다. Anthropic이 PM 와이어 → 디자이너 정제 또는 Claude Code 구현을 사용 예로 든다.
- 조직 링크만 주면 된다. Figma를 못 다루는 이해관계자도 클릭해볼 수 있다.
- 피치 덱·원페이저가 같은 제품에 있어 기획 문서와 데모를 같이 돌리기 쉽다.

단점

- 예쁜 초안이 **결정처럼 보이면** Empty/권한/실패 경로가 빠지기 쉽다. G1에 해당하는 강제 게이트가 제품 기본값이 아니다.
- 화면 ID·우선순위 표가 자동으로 생기지 않는다. 기획 산출물은 따로 적어야 한다.
- Enterprise는 기본 꺼짐, 공유는 조직 안. 외부 이해관계자·에이전시는 Figma/PDF가 더 편할 수 있다.

기획자에게 맡길 것: 시나리오 검증·임원 데모는 Claude Design. **범위와 상태와 IA 확정은 Cursor 프로세스의 P1–G1**에 남긴다. Claude Design 산출물을 G1 입력으로 쓸 수는 있어도, G1을 건너뛰면 안 된다.

---

## 개발자

### Cursor + Figma MCP

장점

- 스펙이 Figma에 있다. `get_design_context`는 참고 코드이고, Code Connect가 있으면 **실제 컴포넌트 이름**에 붙는다.
- Light/Dark가 변수 모드라 구현의 토큰 구조와 맞추기 쉽다.
- 작업 환경이 Cursor라 brief부터 (요청 시) 구현까지 한 IDE다.
- iOS/Android처럼 코드가 HTML이 아닌 제품은 Figma 스펙이 여전히 맞다.

단점

- 디자인이 코드가 아니다. 핸드오프 후에도 간극이 있다.
- Agent가 만든 노드 트리가 더러우면 Dev Mode 스펙이 쓸모가 떨어진다.
- 인터랙션·마이크로카피를 “돌아가는 것”으로 검증하려면 별도 프로토/스토리북이 필요하다.

### Claude Design

장점

- 프로토타입이 이미 돌아가는 HTML/코드에 가깝다. `/design`·핸드오프 번들로 Claude Code가 **스크린샷부터 다시 시작하지 않는다**.
- `/design-sync`로 레포 컴포넌트를 디자인 쪽에 맞출 수 있다.
- Lovable, Replit, Vercel로 이어 붙이면 아이디어→배포 경로가 짧다.
- 복잡한 인터랙션(음성, 셰이더 등) 탐색은 정적 Figma보다 이 쪽이 낫다.

단점

- 프로토 코드와 **제품 레포가 같은 나무라는 보장이 없다.** 토큰이 Claude Design / Figma / 코드 세 곳에 생길 수 있다.
- 네이티브 앱, 접근성 스펙, 주석 달린 Dev Mode는 Figma가 남아 있는 경우가 많다.
- 사용량이 채팅·Claude Code와 한도를 나눈다. 긴 디자인 탐색이 구현 쿼터를 깎을 수 있다.

개발자에게 맡길 것: 스파이크·인터랙션 검증은 Claude Design 프로토. **제품에 넣을 때는 Figma 토큰/컴포넌트(또는 코드 DS) 하나를 SoR로 고른다.** 둘 다 SoR이면 드리프트가 바로 생긴다.

---

## 역할별 한 줄

| 역할 | Cursor + Figma MCP가 앞서는 순간 | Claude Design이 앞서는 순간 |
| --- | --- | --- |
| 디자이너 | 라이브러리·모드·리뷰·픽셀 확정 | 방향 탐색, 브랜드 초안, 클릭 프로토 |
| 기획자 | IA, 범위, 상태, G1 | 회의 중 데모, 덱, 비디자이너 공유 |
| 개발자 | Figma 스펙, Code Connect, 네이티브 | 동작하는 스파이크, Claude Code로 이어가기 |

## 팀이 쓰면 좋은 결합

1. 기획이 시나리오를 적는다 (P1 수준, 도구 무관).
2. 애매한 방향은 Claude Design에서 2~3안을 클릭해 본다.
3. 고른 안을 레퍼런스로 Cursor Skill **P2–G1**에 넣는다. 와이어는 여전히 회색.
4. G1 통과 후 Figma에 토큰·컴포넌트·하이파이 (P5–P7).
5. 구현은 제품 레포 기준. 웹 스파이크는 Claude Design/Claude Code, 장기 스펙은 Figma.

Claude Design만으로 제품 UI를 끝내지 말고, Figma MCP만으로 열두 비주얼 방향을 뽑으려 하지 않는 것이 이 비교의 실무 결론이다.

## 출처

- [Claude Design 제품 페이지](https://claude.com/product/design)
- [Introducing Claude Design (2026-04-17)](https://www.anthropic.com/news/claude-design-anthropic-labs)
- [Claude Design now stays on brand (2026-06-17)](https://claude.com/blog/claude-design-stays-on-brand-for-daily-work)
- 이 저장소 Skill: `.cursor/skills/service-design-figma/SKILL.md`
