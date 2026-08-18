# 숏츠 반자동화 예시 산출물

파이프라인 설명은 [`docs/shorts-pipeline.md`](../docs/shorts-pipeline.md)에 있다.

이 폴더는 **한 편의 영상 = 한 묶음의 JSON**이라는 계약의 예시다. 오케스트레이터는 채팅 로그가 아니라 이 파일들을 읽고 쓴다.

| 파일 | 단계 | 누가 컨펌 |
| --- | --- | --- |
| `examples/style-pack.v1.yaml` | 채널 자산 | 초기에 한 번, 이후 버전업 |
| `examples/brief.example.json` | 주제·훅 | 주제 선정 시 |
| `examples/script.example.json` | 대본 | Gate A |
| `examples/storyboard.example.json` | 샷 + 키프레임 경로 | Gate B |
| `examples/review.example.json` | 샷별 승인 | Gate B |
| `examples/package/shotlist.csv` | 편집기에 넘기는 샷리스트 | 클립 이후 |

클립·TTS 호출은 `review`에서 `approved`인 샷만 대상으로 한다.
