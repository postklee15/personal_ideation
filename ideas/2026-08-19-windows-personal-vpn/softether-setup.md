# SoftEther VPN Server 설치 → 설정 → OpenVPN 연결

전제: 집 **Windows 11 Pro**에 Server를 올리고, **폰·노트북은 OpenVPN Connect**로 붙는다. VPN Bridge·Server Manager 단독본·폰용 SoftEther 앱은 쓰지 않는다.

밖에서 집 회선으로 웹을 나가는 구성이다. 집 LAN만 붙이려면 SecureNAT 대신 Local Bridge를 고르고, 둘을 같이 켜지 않는다.

## 0. 설치 전에

1. 공유기 WAN IP와 [ifconfig.me](https://ifconfig.me)가 **같은지** 본다. 다르면 포트포워딩이 안 되고, 이 순서는 실패한다.
2. 이 PC에 **고정 LAN IP**(또는 공유기 DHCP 예약)를 준다. 포트포워딩 대상이 바뀌면 밖에서 끊긴다.
3. 절전·최대 절전을 끈다. 잠든 서버는 서버가 아니다.
4. 설치 파일은 [공식 다운로드](https://www.softether-download.com/)만 쓴다. Component는 **SoftEther VPN Server**, Platform은 **Windows**.

일부 백신이 설치 파일을 오탐한다. SoftEther 프로젝트가 안내하는 공식 배포본이면 서명·출처를 확인한 뒤 진행한다.

## 1. 설치

1. 받은 `vpnserver-*-win32-x86.exe`를 실행한다. 64비트 Windows 11에서도 이 설치본을 쓴다.
2. 설치할 소프트웨어에서 **VPN Server**만 고른다. Client·Bridge는 고르지 않는다.
3. 약관에 동의하고 기본 경로(`Program Files\SoftEther VPN Server`)로 설치한다.
4. 설치기가 **서비스 모드**로 등록한다. 부팅 후 로그온 전에 떠야 하므로 이 상태가 맞다.
5. 서비스 목록에 **SoftEther VPN Server**가 있고 실행 중인지 본다. 재부팅은 보통 필요 없다.

설치가 끝나면 **SoftEther VPN Server Manager**가 같이 있다. 따로 받지 않는다.

## 2. 처음 접속과 관리 암호

목록이 비어 있으면 **New Connection Setting**이 뜬다. 이 창은 폰 VPN이 아니다. Manager가 **같은 PC의 Server 서비스**에 관리용으로 붙는 설정이다.

| 칸 | 값 |
| --- | --- |
| Setting Name | `localhost` 또는 `Home` |
| Connect to Localhost | **켠다.** Host Name이 `localhost`로 채워지고 OK가 살아난다 |
| Host Name | localhost가 자동으로 들어가면 그대로 |
| Port Number | **443** (TCP). 기본 리스너다 |
| Proxy | **Direct TCP/IP Connection (No Proxy)** |
| Administration Mode | **Server Admin Mode** |
| Password | **지금은 비운다.** 갓 설치한 Server는 관리 암호가 없다 |
| Do not Save Admin's Password | 원하면 켠다 |

OK 후 Connect한다. 암호가 없다는 안내가 나오면 **지금** 관리자 암호를 정한다. 허브 사용자 암호와 다른 긴 암호로 둔다. 이 암호는 Server Manager 접속용이다. 여기서 미리 아무 암호나 넣으면 접속이 거절된다.

허브가 없으면 Easy Setup 창이 뜬다. 이미 **Manage VPN Server 'localhost'** 본창이 보이면 아래 4장을 따른다.

## 2.1 본창에서 할 일 (허브가 이미 있을 때)

Virtual Hub 목록에 허브가 하나 있고 Online이면 Easy Setup은 끝난 상태다. 예: 허브 이름 `seven_vpn`, 사용자 0명.

이 창의 버튼은 다음 순서로만 쓴다. Encryption and Network, Edit Config, IPsec / L2TP, VPN Azure, Local Bridge는 지금은 열지 않는다.

1. 허브를 클릭한 뒤 **Manage Virtual Hub**.
2. **Manage Users**에서 본인 계정 하나. 인증은 비밀번호. 익명 없음. OpenVPN 로그인 이름은 `계정@허브이름` (예: `나@seven_vpn`).
3. 같은 허브 창에서 **Virtual NAT and Virtual DHCP Server (SecureNAT)** → **Enable SecureNAT**. 밖에서 집 인터넷으로 나가려면 이 스위치가 필요하다. Local Bridge와 같이 켜지 않는다.
4. 허브 창을 닫고 본창으로 돌아온다.
5. **OpenVPN / MS-SSTP Setting** → **Enable OpenVPN Clone Server Function**. **Generate a Sample Configuration File for OpenVPN Clients**. zip 안의 `*_openvpn_remote_access_l3.ovpn`만 쓴다.
6. 창 아래 **Dynamic DNS** 이름(예: `vpn….softether.net`)을 `.ovpn`의 `remote`에 넣는다. 포트는 본창 리스너에 이미 있는 **443**이 카페망에 유리하다. `proto tcp`로 맞춘다.

그 이름은 직접 신청하는 도메인이 아니다. SoftEther가 이 Server에 붙여 주는 주소다. **Manage VPN Server 'localhost'** 본창 **맨 아래 상태줄**에 `vpn숫자.softether.net`으로 보인다. 같은 창의 **Dynamic DNS Setting**을 열면 전체 이름을 복사할 수 있다. 집 공인 IP가 바뀌어도 이 이름이 따라가므로 `.ovpn`에는 IP보다 이 이름을 넣는 편이 낫다. 공유기 포트포워딩이 안 되는 CGNAT면 이 이름이 있어도 밖에서 안 들어온다.

리스너에 443, 992, 1194, 5555가 Listening이면 Server 쪽 포트는 열린 것이다. 밖에서 들어오려면 공유기에서 그 TCP를 이 PC로 넘기는 일이 남는다.

## 3. Easy Setup (원격 액세스)

1. **Remote Access VPN Server**를 고른다. Site-to-Site·Bridge가 아니다.
2. 가상 허브 이름을 정한다. 예: `HOME`. 나중에 OpenVPN 계정에 `사용자@HOME`으로 붙는다.
3. SoftEther **Dynamic DNS**(예: `*.softether.net`)가 나오면 켠다. 집 공인 IP가 바뀌어도 이름이 따라간다. 이 이름을 `.ovpn`의 `remote`에 쓴다.
4. **Azure VPN**은 끈다. 클라우드 중계라 이 구성에는 필요 없다.
5. **L2TP/IPsec**은 지금은 끈다. 모바일은 OpenVPN만 쓴다. 켜면 UDP 500/4500을 더 열어야 하고 기본 PSK `vpn`을 반드시 바꿔야 한다.
6. 가상 허브에 **사용자**를 만든다. 본인만, 비밀번호 인증. 익명·게스트는 없다.

## 4. SecureNAT (밖에서 집 인터넷으로 나가기)

1. 서버 관리 창에서 허브를 고르고 **Manage Virtual Hub**.
2. **Virtual NAT and Virtual DHCP Server (SecureNAT)**.
3. **Enable SecureNAT**.

이러면 폰이 터널로 붙었을 때 IP·DNS를 받고, 웹은 집 회선으로 나간다. 공유기 DHCP와 대역이 겹치면 가상 DHCP 대역을 허브 전용으로 나눈다. Local Bridge는 이 단계에서 켜지 않는다.

## 5. OpenVPN 켜고 `.ovpn` 받기

1. 서버 관리 창에서 **OpenVPN / MS-SSTP Settings**.
2. **Enable OpenVPN Clone Server Function**을 켠다. SSTP는 Windows 클라이언트용이라 폰에는 필수가 아니다.
3. **Generate a Sample Configuration File for OpenVPN Clients**로 zip을 받는다.
4. zip 안에서 `*_openvpn_remote_access_l3.ovpn`만 쓴다. `*_bridge_l2` / TAP 쪽은 사이트 간·브리지용이다.

메모장으로 `.ovpn`을 연다.

- `remote` 주소를 SoftEther DDNS 또는 집 공인 IP로 맞춘다. 설치 직후 샘플이 `127.0.0.1`이거나 내부 이름이면 밖에서 실패한다.
- 카페·호텔을 염두에 두면 `proto tcp`와 포트 `443`이 유리하다. SoftEther 기본 리스너는 TCP 443, 992, 5555다.
- UDP 1194만 열려 있고 TCP가 아니면 일부 공용망에서 막힌다. 리스너 목록에 **443/TCP**가 있는지 확인한다.

`.ovpn`에는 보통 비밀번호가 없다. 파일만 있어도 계정 없으면 못 붙는다. 그래도 본인 기기에만 둔다.

OpenVPN 사용자 이름은 허브가 하나여도 `이름@HOME`처럼 **허브 이름을 붙이는 편**이 안전하다.

## 6. 방화벽과 공유기

1. Windows 방화벽에서 SoftEther VPN Server의 **TCP 443**(쓰는 리스너) 인바운드가 열려 있는지 본다. 설치기가 규칙을 넣기도 하지만 백신·타사 방화벽이 막으면 실패한다.
2. 공유기에서 그 TCP 포트를 **이 PC의 고정 LAN IP**로 전달한다. UDP OpenVPN을 쓰면 1194/UDP도 같이 전달한다.
3. 공인 IP가 바뀌고 DDNS를 안 썼으면 `.ovpn`의 `remote`를 매번 고쳐야 한다.

RDP(3389)나 SMB를 인터넷에 같이 열지 않는다. VPN이 붙은 뒤에만 집 주소로 화면을 연다.

## 7. 폰·노트북에서 OpenVPN 연결

1. 스토어/공식 사이트에서 **OpenVPN Connect**(OpenVPN Inc.)만 설치한다.
2. `.ovpn`을 에어드롭·메일·클라우드로 넣는다.
3. 앱이 프로필을 읽으면 사용자 이름(`이름@HOME`)과 허브 사용자 비밀번호를 넣고 연결한다.
4. 붙으면 폰 브라우저에서 [ifconfig.me](https://ifconfig.me)가 **집 공인 IP**와 같은지 본다. 같으면 집 회선으로 나간 것이다.

노트북 Windows도 같다. SoftEther VPN Client가 아니라 OpenVPN Connect로 같은 `.ovpn`을 쓴다.

## 8. 안 되면

| 증상 | 볼 것 |
| --- | --- |
| 연결 시간 초과 | 공인 IP, 포트포워딩, PC 절전, 방화벽, `.ovpn`의 `remote` |
| AUTH_FAILED | 사용자 객체, `이름@허브`, 비밀번호. `.ovpn`만으로는 인증이 안 끝난다 |
| 연결은 됐는데 웹이 안 됨 | SecureNAT가 꺼져 있음, DNS |
| 집 와이파이에서는 되고 밖에서는 안 됨 | 밖에서 공인 주소로 붙고 있는지. 집 안에서 `127.0.0.1` 테스트와는 다르다 |
| 카페에서만 안 됨 | UDP 차단 → `proto tcp` + 443 |

같은 PC에서 Server와 Bridge를 같이 올리지 않는다. 관리 창은 설치된 Server Manager로 `localhost`만 쓰면 된다.

## 9. Chrome 원격 데스크톱이랑 같이 쓸 때

**VPN Server만 켜 두는 것**과 **그 PC가 VPN 클라이언트로 붙는 것**은 다르다.

Chrome 원격 데스크톱·AnyDesk·TeamViewer는 보통 이 PC가 Google 등으로 **밖으로 나가는** 연결이다. SoftEther Server는 밖에서 **들어오는** 리스너다. 집 PC를 서버로만 두고, 그 PC에는 OpenVPN/SoftEther 클라이언트를 켜지 않으면 원격 프로그램은 대체로 그대로 된다. 공유기에서 443을 SoftEther로 넘기는 것은 인바운드라, Chrome이 쓰는 아웃바운드 HTTPS를 빼앗지 않는다.

끊길 수 있는 경우는 이쪽이다.

| 상황 | 결과 |
| --- | --- |
| 서버 PC에서 OpenVPN·상용 VPN을 전체 터널로 켬 | 기본 경로가 바뀌어 원격 호스트가 Google에 못 가거나 세션이 떨어질 수 있다 |
| Local Bridge를 실제 NIC에 걸어 어댑터가 출렁임 | 원격 호스트가 네트워크 변경으로 재연결한다 |
| IPsec/L2TP를 켜 Windows 쪽 IPsec과 겹침 | 드물지만 다른 VPN·원격이 이상해질 수 있다. OpenVPN만 쓸 때는 꺼 둔다 |
| 밖에서 RDP(3389)를 직접 연 상태 | VPN과 무관하게 위험하다. 원격은 Chrome/AnyDesk처럼 아웃바운드 중계이거나, VPN 붙은 뒤 LAN으로만 |

폰에서 VPN을 켠 채로 Chrome 원격 데스크톱을 쓰면, 폰의 CRD 트래픽이 집을 거쳐 Google로 나간다. 집 서버가 켜져 있는 한 동작은 가능하다. 화면만 필요하면 VPN 없이 CRD만으로도 된다. VPN은 집 NAS·집 IP로 웹을 쓰는 용도다.
