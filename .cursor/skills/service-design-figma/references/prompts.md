# 프롬프트 골격

사용자 요청이 한 문장이어도 Agent는 아래 네 줄을 내부 범위로 고정한다.

```text
역할: Cursor + Figma MCP로 [단계]만 수행.
입력: brief.md, screens.md, Figma fileKey [ ], 지금 페이지 [ ].
범위: [화면 ID 또는 컴포넌트]. 다음 단계로 넘어가지 마.
제약: 없는 기능을 창작하지 마. hex 하드코딩 금지(P5 이후).
완료: 만든 node id / file URL과 get_screenshot 결과를 보고하고 멈춰.
```

사용자가 단계 문장을 직접 붙여 넣으면 [phases.md](phases.md)와 함께 따른다. 원문 치트시트는 아이디어 폴더 `ideas/2026-08-18-cursor-figma-design-process/prompts.md`에도 있다.
