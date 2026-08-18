# 아이데이션 폴더·브랜치 규칙

- 날짜: 2026-08-18
- 상태: active
- 한 줄: 세션마다 `ideas/날짜-slug/` 폴더와 주제 브랜치를 열고, 본문은 md/pdf만 둔다

이 저장소 에이전트는 구현이 아니라 아이데이션용이다. 새 세션이 시작되면 주제를 루트나 이전 폴더에 이어 쓰지 않고, 아래를 먼저 한다.

## 규칙

1. **폴더** `ideas/YYYY-MM-DD-<slug>/`  
   그 세션의 마크다운, PDF, 이미지, 예시 파일은 여기만 쓴다. slug는 ASCII kebab.
2. **브랜치** `idea/YYYY-MM-DD-<slug>` (`main`에서 분기)  
   Cursor Cloud가 `cursor/<name>-<id>`를 강제하면 그 브랜치를 유지하고, 폴더명은 그래도 1번을 따른다.
3. **통합**은 `main`이다. 아이디어 본문을 `main`에 직접 커밋하지 않는다.
4. **카탈로그**는 루트 `README.md`다. 폴더를 열 때 표에 한 줄을 넣는다.
5. **기본 산출물**은 md와 pdf다. 앱·패키지·테스트는 사용자가 분명히 요청한 때만.

에이전트가 읽는 강제 규칙은 `.cursor/rules/ideation-git.mdc`와 `AGENTS.md`다.

## 기존 자료 이관

루트에 흩어져 있던 세 주제를 폴더로 옮겼다.

| 폴더 | 이전 위치 |
| --- | --- |
| `ideas/2026-08-17-trimage-38a-dressing/` | `plans/`, `docs/design-notes.md` |
| `ideas/2026-08-18-us-30y-ai-capital/` | `reports/` |
| `ideas/2026-08-18-shorts-pipeline/` | `docs/shorts-pipeline.md`, `shorts/` |

## 세션이 시작되면

```text
main
  └─ idea/YYYY-MM-DD-slug          (또는 cursor/<slug>-<id>)
        └─ ideas/YYYY-MM-DD-slug/
              README.md            (제목, 날짜, 상태, 한 줄)
              …md / pdf
```

폴더를 연 직후 커밋하고, 본문이 바뀔 때마다 커밋한 뒤 `main`으로 PR한다.
