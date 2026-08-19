# Windows PC에서 개인 VPN 운영

- 날짜: 2026-08-19
- 상태: draft
- 한 줄: Windows 11 Pro에 밖에서 붙는 VPN 서버를 올릴 수 있다. 추천 소프트웨어는 개인 사용이 무료고, 돈은 전기·공인 IP·VPS에서 난다

## 메모

범위는 **Windows 11 Pro PC를 외부 접속 서버로** 쓰는 것이다. Pro는 Home보다 WireGuard NAT·원격 데스크톱 호스트·Hyper-V가 열려 있지만, Windows Server가 아니라서 내장 VPN 서버 역할(RRAS)은 없다.

집 PC를 서버로 쓰면 출구 IP는 집 회선이다. 해외에서 한국 사이트가 필요할 때는 맞고, 미국 IP가 필요할 때는 틀린 도구다.

개인 한 대로 밖에서 붙는 용도면 **소프트웨어 구독료는 안 내도 된다.** Tailscale Personal, SoftEther, WireGuard 모두 무료다. SoftEther는 Windows용 **VPN Server**만 받는다. Server Manager는 그 설치본에 들어 있고, VPN Bridge는 사이트 간용이라 필요 없다. 24시간 전기, 통신사 공인 IP, 싼 VPS 중계만 유료 후보다.

본문: [windows-personal-vpn.md](windows-personal-vpn.md). 모바일: [softether-mobile.md](softether-mobile.md) (공식 앱 없음, OpenVPN Connect 또는 iOS L2TP).
