# Windows PC에서 개인 VPN 운영

- 날짜: 2026-08-19
- 상태: draft
- 한 줄: Windows 11 Pro에 밖에서 붙는 VPN 서버를 올릴 수 있다. Pro여도 RRAS는 없고, 공인 IP가 없으면 Tailscale이 먼저다

## 메모

범위는 **Windows 11 Pro PC를 외부 접속 서버로** 쓰는 것이다. Pro는 Home보다 WireGuard NAT·원격 데스크톱 호스트·Hyper-V가 열려 있지만, Windows Server가 아니라서 내장 VPN 서버 역할(RRAS)은 없다.

집 PC를 서버로 쓰면 출구 IP는 집 회선이다. 해외에서 한국 사이트가 필요할 때는 맞고, 미국 IP가 필요할 때는 틀린 도구다.

본문: [windows-personal-vpn.md](windows-personal-vpn.md)
