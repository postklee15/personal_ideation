# 밖에서 붙는 Windows VPN 서버

밖에서 노트북·휴대폰으로 연결해, 집 Windows PC를 통해 집 안 기기나 집 인터넷으로 나가는 구성이다. Windows 설정 앱의 VPN 화면으로는 이 서버를 만들 수 없다. 그건 이미 있는 서버에 **접속하는 클라이언트**다.

임의의 상용 VPN 설치파일(Nord, Express 등)을 깔아도 내 PC가 서버가 되지는 않는다. 그런 제품은 클라우드 쪽에 서버가 있고, Windows에는 클라이언트만 온다. 집 PC를 진입점으로 쓰려면 **서버 역할을 하는 소프트웨어**를 고른다.

```text
외부 기기 (카페·해외·휴대폰)
        │  암호화 터널
        ▼
집 Windows PC  ←  이 상자가 서버
        │
        ├─ 집 LAN (NAS, 프린터, 다른 PC)
        └─ 집 인터넷 출구 (회선 IP로 웹을 나감)
```

## 결론

개인 한 대 기준으로 순서는 아래다.

1. **Tailscale exit node** — 공인 IP·포트포워딩 없이 밖에서 붙고, 원하면 집 회선으로 인터넷을 내보낸다. Windows에 공식 앱이 있다.
2. **SoftEther VPN Server** — Windows에 전통적인 VPN 서버를 직접 올리고 싶을 때. 공인 IPv4와 포트포워딩이 필요하다.
3. **WireGuard + 윈도우 서버 GUI** — 프로토콜은 가볍지만, Windows에서 NAT·포워딩을 직접 맞춰야 해서 손이 더 간다.

Windows Home에 내장 RRAS 서버는 없다. PPTP는 쓰지 않는다. 잠자는 PC는 서버가 아니다.

## 나가기 전에 확인할 것

| 확인 | 왜 |
| --- | --- |
| 공유기 WAN IP와 [외부에서 보이는 IP](https://ifconfig.me)가 같은가 | 같으면 공인 IPv4. 다르면 CGNAT이거나 이중 공유기라 **포트포워딩형 서버는 밖에서 안 들어온다** |
| WAN IP가 `100.64.0.0/10`, `10/8`, `172.16/12`, `192.168/16`인가 | 통신사 CGNAT 또는 상위 공유기. SoftEther·WireGuard 인바운드는 여기서 막힌다 |
| 이 PC를 절전 없이 켜 둘 수 있는가 | 서버 프로세스가 살아 있어야 한다. 절전·최대 절전·로그아웃 후 터널 끊김을 따로 끈다 |
| 밖에서 필요한 것이 집 기기인가, 집 IP로 웹을 나가는 것인가 | 전자는 서브넷/브리지, 후자는 exit node / SecureNAT / `0.0.0.0/0` 전체 터널 |

CGNAT이면 2·3번은 통신사에 공인 IP를 받기 전에는 포기하고 1번(또는 싼 VPS를 중계로 두는 구성)으로 간다.

## 경로 1 — Tailscale (개인 기본값)

클라이언트/서버를 나누지 않고, 집 PC와 외부 기기가 같은 사설망에 들어간다. 집 PC는 **밖으로 나가는 연결**만 하므로 공유기 포트를 열지 않는다. CGNAT·호텔 방화벽에서도 동작하는 이유가 이것이다.

밖에서 “그 PC를 통해 간다”고 쓰려면 집 Windows를 **exit node**로 켠다. 집 LAN에 Tailscale을 못 까는 기기(NAS, TV, 프린터)까지 붙이려면 같은 PC에 **subnet router**를 같이 켠다.

Windows에서 빠지기 쉬운 점:

- 트레이에서 **unattended / 로그인 없이 실행**을 켠다. 기본값은 로그온 세션에 묶인다.
- 절전을 끈다. 잠든 exit node는 경로가 아니다.
- 관리 콘솔에서 exit node·서브넷 광고를 **승인**해야 한다. 앱만 설치하면 안 열린다.
- 개인 무료 범위는 계정·기기 수 제한이 있다. 혼자·가족 소수는 보통 충분하다.
- 데이터는 기기 사이 WireGuard로 암호화된다. 좌표 서버는 누가 누구인지 같은 제어 평면을 본다. 제어 평면까지 직접 쥐려면 Headscale을 별도 호스트에 둔다. Headscale을 집 Windows에 얹는 것은 이 문서의 1순위가 아니다.

외부 기기에도 같은 앱을 깐다. 표준 VPN 클라이언트(내장 IKEv2, 아무 OpenVPN 앱)만으로 붙는 구조가 아니다.

## 경로 2 — SoftEther VPN Server

Windows에서 가장 완성도에 가까운 **전통적 VPN 서버**다. 가상 허브, 사용자 계정, SSTP·L2TP/IPsec·OpenVPN 호환·자체 SSL-VPN을 한 프로세스에서 연다. 관리 GUI가 Windows에 있다.

밖에서 인터넷까지 집 회선으로 내보내려면 SecureNAT(가상 NAT/DHCP)를 쓴다. 집 LAN에 브리지하려면 Local Bridge를 쓴다. 둘을 동시에 어설프게 켜면 DHCP가 충돌할 수 있다. 목적 하나를 고른다.

전제:

- 공인 IPv4, 또는 통신사가 열어 준 포트
- 공유기에서 집 PC의 **고정 LAN 주소**로 포트 전달. 443/TCP를 쓰면 호텔·회사 방화벽을 비교적 잘 통과한다
- 공인 IP가 바뀌면 DDNS
- Windows 방화벽과 백신의 서버 프로세스 허용
- 서버를 Windows 서비스로 등록해 부팅 후 로그온 전에 뜨게 한다

장점: 폰·맥에 내장 VPN(SSTP, L2TP)으로도 붙을 수 있어, 상대 기기에 SoftEther 클라이언트가 없어도 되는 경우가 있다.  
단점: 인바운드 포트를 연다. 소프트웨어와 사용자 계정을 직접 패치·관리한다. 유저모드 SecureNAT는 속도가 기대보다 낮을 수 있다.

## 경로 3 — WireGuard를 Windows에서 서버처럼

공식 WireGuard for Windows는 터널 엔진이지, “서버 마법사”가 아니다. 서버처럼 쓰려면 피어 키, ListenPort, NAT, 포워딩을 직접 맞춘다. 그걸 GUI로 줄인 것이 [Wg Server for Windows](https://github.com/micahmo/WgServerforWindows), [EasyWG Server](https://github.com/tailin/easy-wireguard-server) 같은 도구다.

전제는 SoftEther와 같다. 보통 UDP 51820을 집 PC로 넘긴다. Windows 10/11의 NAT(`New-NetNat`)는 Hyper-V/프로 에디션에 막히기도 하고, 그때는 인터넷 연결 공유(ICS)로 우회한다. Home에서 “아무 설정 없이 게이트웨이”가 되지는 않는다.

밖에서 전체 트래픽을 집으로 보내려면 클라이언트 `AllowedIPs`에 기본 경로를 넣고, 서버 쪽에서 NAT가 살아 있어야 한다. DNS도 터널 안에 넣지 않으면 “연결은 됐는데 웹이 안 된다”.

속도·단순 프로토콜은 이쪽이 낫다. 운영 공수는 SoftEther·Tailscale보다 크다.

## 이 경로들은 쓰지 않는다

| 선택 | 이유 |
| --- | --- |
| Windows 11 설정 → VPN | 클라이언트 프로필만 만든다 |
| Windows Home의 RRAS | 서버 역할이 없다. RRAS는 Windows Server 쪽 |
| PPTP | 낡은 프로토콜. 새 배포에 쓰지 않는다 |
| 웹에서 받은 “무료 VPN 서버” 실행 파일 | 서버가 아니라 백도어인 경우가 많다. 공식 사이트·GitHub 릴리스만 |
| 상용 VPN 앱을 서버 대용 | 내 PC로 들어오는 리스너가 없다 |
| 잠자는 노트북 + 뚜껑 닫기 | 원격 진입점이 사라진다 |

공인 IP가 없고 Tailscale도 쓰기 싫으면, 작은 **Linux VPS**에 WireGuard 허브를 두고 집 PC는 피어로 붙는 구성이 남는다. 허브가 공인 IP를 갖고 양쪽이 밖으로 나가기만 하면 CGNAT를 우회한다. 집 Windows만으로 인바운드를 여는 것과는 다른 설계다.

## 집 Windows를 서버로 둘 때 공통 조건

- **고정 LAN IP** (DHCP 예약 또는 수동). 포트포워딩 대상이 바뀌면 밖에서 끊긴다.
- **절전 없음**, USB 선택적 절전으로 NIC가 꺼지지 않게.
- **빠른 시작 끄기**를 검토한다. 하이브리드 부팅이 서비스를 건너뛰는 경우가 있다.
- Windows Update 재부팅 후 서버 프로세스가 자동 기동인지 확인.
- 동적 공인 IP면 DDNS. CGNAT면 DDNS를 붙여도 인바운드는 안 산다.
- 원격 데스크톱·SMB를 인터넷에 직접 노출하지 않는다. VPN이 붙은 뒤에만 집 주소로 연다.
- 사용자·키는 본인 기기만. 지인에게 “아무나 붙는 VPN”으로 열어 두면 집 회선이 열린 프록시가 된다. ISP 약관·본인 회선 책임 문제가 된다.

## 무엇을 고를지

```text
밖에서 집 Windows로 가서 LAN 또는 집 IP로 웹을 쓴다
        │
        ├─ 공인 IPv4가 없거나 확인을 아직 안 했다
        │         → Tailscale exit node (+ 필요하면 subnet router)
        │
        ├─ 공인 IPv4가 있고, 표준 VPN 앱으로 붙이고 싶다
        │         → SoftEther (SSTP/443 우선)
        │
        └─ 공인 IPv4가 있고, WireGuard만 쓰겠다
                  → Wg Server for Windows / EasyWG
                    NAT가 안 되면 Linux·공유기 쪽으로 서버를 옮긴다
```

Windows PC는 가능은 하지만 24시간 게이트웨이로는 공유기(OpenWrt, GL.iNet)나 작은 Linux 상자가 더 덜 아프다. “이미 켜 두는 그 Windows 한 대”에 얹을 이유가 있을 때만 1~3번이 맞다.

## 다음에 정하면 되는 것

1. 공유기 WAN IP와 외부 표시 IP가 같은지
2. 밖에서 집 LAN이 필요한지, 집 회선 출구만 필요한지
3. 외부 기기에 Tailscale 앱을 깔 수 있는지, 아니면 내장 VPN 클라이언트만 쓸 것인지
4. 그 Windows를 절전 없이 둘 수 있는지
