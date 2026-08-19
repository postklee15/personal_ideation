# SoftEther로 모바일 접속

iPhone·Android에는 **공식 SoftEther VPN Client 앱이 없다.** 스토어의 “SoftEther” 앱은 쓰지 않는다. 폰은 OS 내장 VPN이나 **OpenVPN Connect**로, 집 Windows 11 Pro의 SoftEther **VPN Server**에 붙는다.

개인 원격접속 기준 추천은 OpenVPN이다. L2TP/IPsec은 iOS에는 아직 있고, 최근 Android는 제조사가 빼 둔 경우가 많다.

자세한 설치·OpenVPN 순서는 [softether-setup.md](softether-setup.md).

## 서버에서 먼저

Server Manager로 `localhost`에 붙인 다음이다.

1. 가상 허브에 **본인 전용 사용자**를 만든다. 익명·게스트는 켜지 않는다.
2. 밖에서 집 인터넷으로 나가려면 그 허브에서 **SecureNAT**을 켠다. 집 LAN DHCP를 쓰려면 Local Bridge만 고른다. 둘을 동시에 어설프게 켜면 DHCP가 충돌한다.
3. **OpenVPN**을 켠다. Manager에서 샘플 `.ovpn`을 받는다. 호텔·카페 방화벽에는 TCP/443 리스너가 유리하다.
4. iOS 내장 VPN을 쓰려면 **L2TP/IPsec**만 켠다. 사전공유키(PSK)는 기본값 `vpn`을 바꾼다. 암호화 없는 Raw L2TP는 켜지 않는다.
5. L2TP는 허브 구간에 **DHCP**가 있어야 붙는다. 공유기 DHCP 또는 SecureNAT 가상 DHCP 중 하나는 살아 있어야 한다.
6. 허브가 여러 개면 폰 사용자 이름을 `사용자@허브이름`으로 넣는다. 기본 허브 하나를 L2TP 설정에 지정하면 `@허브`를 생략할 수 있다.

공유기에서 집 PC로 넘겨야 하는  inbound는 고른 프로토콜에 따른다. OpenVPN을 443에 두면 HTTPS와 같은 포트다. L2TP는 UDP 500·4500(필요하면 1701)이다. 공인 IPv4가 없으면 이 인바운드는 실패하고, 그때는 Tailscale이 맞다.

Windows에서 다른 L2TP 서비스와 UDP 포트가 겹치면 SoftEther L2TP가 죽는다. 이 PC는 Windows 11 Pro라 RRAS는 원래 없다.

## 폰에서

### OpenVPN (iOS·Android 공통, 이쪽을 먼저)

1. 스토어에서 **OpenVPN Connect**(OpenVPN Inc.)만 설치한다.
2. Server에서 받은 `.ovpn`을 메일·에어드롭·클라우드로 폰에 넣는다.
3. 앱이 프로필을 읽으면 서버 사용자·비밀번호로 연결한다.
4. 파일 안의 `remote` 주소가 집 공인 IP 또는 DDNS와 같고, 포트가 서버 리스너와 같은지 본다.

### iOS 내장 L2TP

설정 → VPN → 구성 추가 → 유형 **L2TP**.

- 서버: 집 공인 IP 또는 DDNS
- 계정: 가상 허브 사용자 (필요하면 `사용자@허브`)
- 암호: 그 사용자 비밀번호
- 암호(시크릿): 서버 L2TP의 PSK

연결 후 상태 화면의 “Connect to 1.0.0.1”은 SoftEther 쪽에서 흔히 보이는 표시라 고장 신호가 아니다.

### Android 내장 L2TP

설정에 **L2TP/IPsec PSK**가 있으면 iOS와 같은 값으로 만든다. 전체 터널이 필요하면 제조사 화면에 전달 경로/`0.0.0.0/0` 칸이 있는 경우가 있다. **없으면 OpenVPN으로 간다.** Pixel·최신 One UI는 내장 L2TP가 없는 경우가 많다.

SSTP는 Windows에는 편하지만 iOS 내장에는 없고, Android는 서드파티라 개인 용도에서는 OpenVPN만으로 충분하다.

## 안 되는 이유

| 증상 | 먼저 볼 것 |
| --- | --- |
| 연결 자체가 안 됨 | 공인 IP·포트포워딩·PC 절전·Windows 방화벽 |
| 인증 실패 | 사용자 객체, `사용자@허브`, PSK가 서버와 다름 |
| 연결은 됐는데 인터넷이 없음 | SecureNAT/DHCP, 폰 DNS |
| 카페에서만 안 됨 | UDP L2TP가 막힘 → OpenVPN TCP/443 |
| 스토어 SoftEther 앱 | 공식 클라이언트가 아님. 삭제 |

밖에서 쓰는 폰은 클라이언트라 모바일 CGNAT는 상관없다. 막히는 쪽은 **집 서버가 인터넷에서 보이는지**다.
