#let navy = rgb("#1b365d")
#let navy-soft = rgb("#e8eef5")
#let amber = rgb("#9a3412")
#let amber-soft = rgb("#fff7ed")
#let slate = rgb("#334155")
#let muted = rgb("#64748b")
#let line-c = rgb("#cbd5e1")
#let paper = rgb("#fbfaf7")

#set document(
  title: "달러 3.0에서 선호받을 플레이어 10",
  author: "아이데이션 메모",
  keywords: ("stablecoin", "GENIUS Act", "Circle", "Coinbase", "dollar"),
  date: datetime(year: 2026, month: 8, day: 27),
)

#set page(
  paper: "a4",
  margin: (top: 23mm, bottom: 20mm, left: 18mm, right: 18mm),
  fill: paper,
)

#set text(
  font: "Noto Sans KR",
  size: 10pt,
  lang: "ko",
  fill: slate,
  hyphenate: false,
)

#set par(justify: true, leading: 0.72em, spacing: 0.95em)
#set heading(numbering: "1.")
#show heading: set text(font: "Noto Sans KR", fill: navy)
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(2mm)
  block(below: 4mm)[
    #set text(size: 15pt, weight: 700, fill: navy)
    #block(
      width: 100%,
      inset: (bottom: 3mm),
      stroke: (bottom: 1.6pt + navy),
    )[
      #if it.numbering != none [
        #counter(heading).display()
        #h(2mm)
      ]
      #it.body
    ]
  ]
}
#show heading.where(level: 2): it => {
  v(3mm)
  block(below: 2.2mm)[
    #set text(size: 12pt, weight: 700, fill: navy)
    #it
  ]
}

#let kicker(body) = text(size: 8.5pt, weight: 700, fill: amber, tracking: 0.8pt, body)
#let small(body) = text(size: 8.5pt, fill: muted, body)

#let callout(title, body, tone: "navy") = {
  let bg = if tone == "amber" { amber-soft } else { navy-soft }
  let bd = if tone == "amber" { amber } else { navy }
  block(
    width: 100%,
    fill: bg,
    stroke: (left: 3pt + bd),
    inset: (x: 10pt, y: 9pt),
    radius: 2pt,
    breakable: true,
  )[
    #text(weight: 700, fill: bd, size: 9.5pt)[#title]
    #v(2pt)
    #set text(size: 9.5pt)
    #body
  ]
}

#show table.cell.where(y: 0): set text(fill: white, weight: 700, size: 8.5pt)
#set table(
  stroke: 0.4pt + line-c,
  inset: (x: 7pt, y: 6pt),
  fill: (_, y) => {
    if y == 0 { navy }
    else if calc.odd(y) { rgb("#f8fafc") }
    else { white }
  },
)

#let footer-content = context {
  let p = counter(page).get().first()
  if p > 1 {
    set text(size: 8pt, fill: muted)
    block(width: 100%)[
      #line(length: 100%, stroke: 0.45pt + line-c)
      #v(3pt)
      달러 3.0에서 선호받을 플레이어 10  ·  2026.08.27
      #h(1fr)
      #counter(page).display("1")
    ]
  }
}

#set page(footer: footer-content)

#kicker[IDEATION  ·  DOLLAR 3.0 PLAYERS]
#v(2mm)
#align(left)[
  #text(size: 22pt, weight: 800, fill: navy)[달러 3.0에서 선호받을 플레이어 10]
  #v(2mm)
  #text(size: 12pt, fill: rgb("#3f5f86"))[발행사는 싸우고, 유통·담보·수탁은 어느 스테이블이 이겨도 남는다]
]
#v(4mm)
#line(length: 100%, stroke: 1.2pt + navy)
#v(3mm)

#callout("전제")[
  가상화폐 시스템으로 달러 3.0이 열린다는 가정은 앞선 교정대로다. 법정 달러를 스테이블로 복제하고, 담보는 초단기 국채다. 비트코인·이더·솔라나·리플이 기축을 나눠 갖는 그림이 아니다. 선호는 토큰 시세가 아니라, 달러가 온체인으로 복제될 때 빠져서는 안 되는 자리다. 투자 권유가 아니다.
]

#v(4mm)

USDC·USDT 자체는 화폐이지 투자 대상이 아니다. 1달러는 1달러다. 선호가 쌓이는 곳은 그 달러를 발행·유통·보관·담보운용·도로 하는 쪽이다. 작성 시점 전후 스테이블 시총은 약 2,900억~3,150억 달러. 공급은 테더(약 59%), 회전율은 서클(약 24% 공급).

= 고르는 기준

세 곳에서 동시에 불릴수록 위로 올린다.

+ *제도.* GENIUS Act, 동결·제재, OCC·신탁, 국채 담보.
+ *유통.* 이미 누가 들고, 누가 켜고, 누가 상점에 꽂는가.
+ *정산.* 돈이 실제로 지나가며 국채 이자를 나눠 갖는가.

2026년 6월 Open USD(Stripe·Visa·Coinbase·BlackRock·BNY 등 140곳)가 발행 마진을 유통 파트너에게 돌리겠다고 나왔다. 발행사는 경쟁에 열리고, 유통·담보운용·수탁은 어느 달러 토큰이 이겨도 남는다. 그 비대칭이 순위다.

= 10곳

#table(
  columns: (auto, auto, auto, 1fr),
  [순위], [플레이어], [자리], [한 줄],
  [1], [코인베이스], [유통 + 체인 + 이자 배분], [미국 온쇼어의 병목. USDC가 이겨도 Open USD가 이겨도 남는다],
  [2], [서클 (USDC)], [규제 달러 복제본], [제도가 보여주는 얼굴. 회전율 1위, 발행 마진은 공격받는 중],
  [3], [블랙록], [담보 운용], [스테이블이 늘면 T-bill을 사는 손이 커진다],
  [4], [스트라이프], [상점·에이전트 결제], [카드망이 안 되는 기계 결제의 마지막 1cm],
  [5], [테더 (USDT)], [역외 유로달러], [워싱턴의 최애가 아니다. 세계의 재고는 여기 있다],
  [6], [JP모건], [도매 은행 돈], [허가형 체인에서 이미 하루 수십억 달러가 돈다],
  [7], [BNY 멜론], [수탁·발행 배관], [준비금이 앉는 금고. 브랜드가 바뀌어도 금고는 남는다],
  [8], [비자], [기존 가맹 그래프], [사람은 카드로 내고, 뒤에서 스테이블로 정산할 수 있다],
  [9], [솔라나], [기계 속도의 도로], [도로이지 화폐가 아니다. 통행료만 남는다],
  [10], [리플], [은행 회랑 + 제재 스위치], [해방망이 아니다. 그래서 달러 3.0 설계와 맞다],
)

== 1. 코인베이스

가장 완전한 스택이다. 거래소, 수탁, Base, x402, USDC 유통 계약, JP모건 코인의 Base 상장, Open USD 참여. 한 발행사에 베팅하지 않고 카테고리에 베팅한다.

2026년 8월 서클과 2029년까지 계약을 그대로 연장했다. 코인베이스 안의 USDC(유통량의 약 30%)는 준비금 이자를 전부 가져가고, 바깥은 절반이다. 2025년 서클이 유통 비용으로 약 14억 달러를 썼다. GENIUS는 발행사가 보유자에게 이자를 못 주게 한다. 그 이자가 거래소로 우회하는 한, 병목은 발행사가 아니라 유통이다.

리스크. 이자 우회가 OCC 규칙에서 막히면 마진이 줄어든다. 그래도 달러 3.0이 미국 법 안에서 열리면, 그 문을 지키는 쪽은 여기다. 선호는 지분과 Base 통행이지, 임의의 알트가 아니다.

== 2. 서클 (USDC)

워싱턴이 가리키는 달러 복제본이다. 초단기 국채와 현금, BNY 수탁, OCC·뉴욕 트러스트. 공급은 테더의 절반도 안 되지만 회전율에서는 앞선 해가 있다.

약점은 성공의 대가다. 매출의 대부분이 준비금 이자이고, 그 상당을 코인베이스에 준다. Open USD와 은행 코인이 같은 칸을 노린다. 달러 3.0이 열려도 서클이 유일한 발행사로 남는 것은 보장되지 않는다. USDC는 1달러다. 업사이드는 발행사 지분이지 페그가 아니다.

== 3. 블랙록

스테이블이 커질수록 누군가는 T-bill을 사야 한다. 서클 준비금 펀드, BUIDL, Open USD. 발행 브랜드가 바뀌어도 담보는 같은 종류의 초단기 국채로 간다. 코인 가격은 실질금리에 지고, 스테이블 배관은 빌 수요를 만든다. 블랙록은 그 배관의 자산운용사다.

== 4. 스트라이프 (Bridge · Tempo)

기계가 초소액을 내는 자리는 카드망이 원래 설계되지 않았다. Bridge 인수, Open Issuance, OCC 조건부 신탁, Open USD 실무의 한가운데. 이미 상점에서 USDC를 받아 솔라나·이더리움·폴리곤으로 정산한다. 코인베이스가 크립토 온쇼어의 병목이라면, 스트라이프는 기존 인터넷 상거래가 온체인 달러로 넘어오는 병목이다.

== 5. 테더 (USDT)

공급의 약 59%. 역외 거래소 호가의 기본 화폐. 달러 3.0을 미국 법의 확장으로만 읽으면 빼기 쉽고, 빼면 틀린다. 유로달러가 뉴욕 밖에서도 달러였듯, USDT는 크립토의 역외 달러다.

제도의 선호는 반대에 가깝다. 미국 거래소의 일반 USDT는 줄어들 수 있고, 앵커리지를 통한 USAT가 그 우회다. 그래도 신흥국 송금·역외 거래의 재고는 아직 여기다. 온쇼어(USDC·은행 코인)와 오프쇼어(USDT)는 한동안 같이 간다.

== 6. JP모건 (Kinexys)

허가형 체인에서 누적 약 4조 달러, 하루 약 70억 달러. 예금 토큰을 Base에 올렸다. 소매 스테이블이 인터넷의 달러라면, 키넥시스는 이미 있는 은행 돈의 24시간 판이다. 달러 3.0이 열려도 도매는 허가가 있는 원장을 고른다.

== 7. BNY 멜론

서클 준비금의 금고, 발행·상환 배관. 1:1 약속이 깨지지 않으려면 준비금이 앉을 곳이 필요하다. 발행사가 바뀌어도 초단기 국채와 현금을 장부에 올리는 신탁 은행은 남는다.

== 8. 비자

가맹점과 카드 소지자의 그래프는 온체인이 아직 못 따라온 자산이다. 사람은 카드를 버리고 지갑 주소를 외우지 않는다. 에이전트는 지갑을 쓴다. 비자는 사람 쪽 마지막 층을 지키며 정산만 달러 3.0으로 옮길 수 있다. 마스터카드도 같은 칸이다. 하나만 고르면 가맹 규모로 비자.

== 9. 솔라나 — 도로, 화폐 아님

2026년 2월 스테이블 이전에서 솔라나가 이더리움을 한 달 앞질렀다는 집계가 있다. 통행의 약 70%는 USDC다. 앞선 가정의 오류는 “솔라나가 기축”이었다. 달러 3.0에서 받는 선호는 통행료다. 이더리움 L1은 재고와 최종 정산에서 아직 크고, Base는 1번에 들어가 있어 도로의 독립 이름으로는 솔라나를 올린다. Tempo 같은 결제 체인이 열리면 통행은 갈라진다.

== 10. 리플

가정 평가에서 가장 많이 뒤집힌 이름이다. 그래서 여기 들어간다. 달러 3.0은 제재를 포기하지 않는다. 리플은 미국 회사이고, Deep Freeze와 RLUSD 동결이 있다. 규모는 아직 작다. 10번에 올린 이유는 시총이 아니라 역할 — 국경 은행 회랑 + 컴플라이언스 — 이다. XRP를 기축으로 읽는 순간 순위에서 떨어진다. 실패하면 SWIFT가 이 칸을 가져간다.

= 일부러 안 넣은 것

*비트코인.* 전략 준비금은 창고다. 달러 3.0의 현금흐름이 여기를 지나지 않는다. \
*이더리움 네이티브.* 스테이블 재고의 최대 체인이나, 회전은 Base와 솔라나로 넘어가는 중이다. 가스가 기축이 되지는 않는다. \
*페이팔.* PYUSD는 있으나 규모가 10 안에 못 든다. \
*SWIFT.* 10번 칸의 강력한 후보다. 지금 가상화폐 시스템 안의 이름으로 보면 한 칸 밖이다.

= 한 줄로 다시

달러 3.0이 열리면 사람들이 사고 싶어 하는 알트가 이기지 않는다. 미국 법의 도장을 받은 달러 복제본이 이기고, 그 복제본을 켜고 보관하고 담보를 굴리고 상점에 꽂는 이름이 선호를 받는다.

발행 칸은 이미 Open USD와 은행 코인에 열려 있다. 그래서 코인베이스·블랙록·스트라이프·BNY·비자가 서클·테더보다 체제에 더 단단하다.

#v(4mm)

#callout("관찰")[
  가정이 맞다면 스테이블 공급과 빌 보유, 가맹 정산, Base·솔라나 통행이 같이 늘고, BTC 시총이 그 필수조건이 아니어도 된다. 가정이 틀리다면 스테이블은 거래소 호가 화폐에 머물고, 상점·에이전트·도매 은행은 카드와 SWIFT에 남는다.
]

#v(8mm)
#align(right)[
  #small[작성 기준일 2026년 8월 27일. 특정 자산의 매수·매도를 권유하지 않는다.]
]
