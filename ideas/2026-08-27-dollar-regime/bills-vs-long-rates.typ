#let navy = rgb("#1b365d")
#let navy-soft = rgb("#e8eef5")
#let amber = rgb("#9a3412")
#let amber-soft = rgb("#fff7ed")
#let slate = rgb("#334155")
#let muted = rgb("#64748b")
#let line-c = rgb("#cbd5e1")
#let paper = rgb("#fbfaf7")

#set document(
  title: "초단기 국채 수요가 장기 금리를 낮추나",
  author: "아이데이션 메모",
  date: datetime(year: 2026, month: 8, day: 27),
)

#set page(
  paper: "a4",
  margin: (top: 22mm, bottom: 18mm, left: 17mm, right: 17mm),
  fill: paper,
)

#set text(font: "Noto Sans KR", size: 10pt, lang: "ko", fill: slate, hyphenate: false)
#set par(justify: true, leading: 0.72em, spacing: 0.92em)
#set heading(numbering: "1.")
#show heading: set text(font: "Noto Sans KR", fill: navy)
#show heading.where(level: 1): it => {
  v(3mm)
  block(below: 3.5mm)[
    #set text(size: 14pt, weight: 700)
    #block(width: 100%, inset: (bottom: 2.5mm), stroke: (bottom: 1.5pt + navy))[
      #counter(heading).display()
      #h(2mm)
      #it.body
    ]
  ]
}

#let kicker(body) = text(size: 8.5pt, weight: 700, fill: amber, tracking: 0.8pt, body)
#let small(body) = text(size: 8.5pt, fill: muted, body)
#let callout(title, body, tone: "navy") = {
  let bg = if tone == "amber" { amber-soft } else { navy-soft }
  let bd = if tone == "amber" { amber } else { navy }
  block(width: 100%, fill: bg, stroke: (left: 3pt + bd), inset: (x: 10pt, y: 9pt), radius: 2pt)[
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
    if y == 0 { navy } else if calc.odd(y) { rgb("#f8fafc") } else { white }
  },
)

#set page(footer: context {
  if counter(page).get().first() > 1 {
    set text(size: 8pt, fill: muted)
    block(width: 100%)[
      #line(length: 100%, stroke: 0.45pt + line-c)
      #v(3pt)
      초단기 국채 수요와 장기 금리  ·  2026.08.27
      #h(1fr)
      #counter(page).display("1")
    ]
  }
})

#kicker[IDEATION  ·  RATES]
#v(2mm)
#text(size: 21pt, weight: 800, fill: navy)[초단기 국채 수요가 장기 금리를 낮추나]
#v(2mm)
#text(size: 12pt, fill: rgb("#3f5f86"))[빌을 사면 짧은 끝이 눌리고, 긴 끝은 자동으로 안 내려간다]
#v(4mm)
#line(length: 100%, stroke: 1.2pt + navy)
#v(4mm)

#callout("한 줄")[
  스테이블이 사는 것은 만기 93일 이하 국채다. 장기 금리를 낮추려면 듀레이션을 사야 한다. 달러 3.0은 장기 금리 억제기가 아니라, 적자를 짧은 만기로 굴릴 수요를 한 줄기 더 붙이는 장치에 가깝다.
]

#v(4mm)

= 자동으로는 아니다

가능한 일은 세 가지다.

1. *짧은 끝*은 조금 눌릴 수 있다. 빌이 비싸지고 정책 금리와의 스프레드가 줄어든다.
2. *커브는 가팔라질 수 있다.* 앞이 눌리고 뒤가 그대로면 스티프닝이다.
3. *긴 끝이 내리려면* 재무부가 쿠폰·30년 발행을 줄여야 한다. 그건 스테이블의 자동 효과가 아니라 발행 정책이다. 이미 그 수를 썼는데도 30년물은 안 내렸다.

= 왜 한 시장이 아닌가

#table(
  columns: (auto, 1fr, 1fr),
  [칸], [누가 사나], [달러 3.0이 하는 일],
  [초단기 빌 (93일 이하)], [MMF, 은행 유동성, 스테이블 준비금], [여기만 직접 산다],
  [2~7년], [은행, 해외 준비금, 연준 경로], [거의 안 산다],
  [10~30년], [보험·연기금, 외국 공적기관, 바이백], [안 산다. 적자와 AI 장기채가 민다],
)

GENIUS Act가 허용하는 준비금은 남은 만기 93일 이하 국채, 현금, 초단기 레포다. 발행사가 10년·30년을 담고 싶어도 법이 막는다. “국채 수요가 늘면 금리가 내린다”는 문장은 맞을 수 있다. 내리는 금리는 빌 금리다.

규모도 아직 앞 칸의 일부다. 빌 잔액은 대략 6조~7조 달러. 스테이블이 국채·레포로 앉힌 돈은 2026년 초 전후 1,500억~2,200억 달러권, 빌 시장의 약 2.5~3%라는 집계가 있다. 2028년 1조 달러는 TBAC가 그린 시나리오지 기본값이 아니다. 1조가 되어도 사는 것은 3개월물이다.

BIS 쪽 추정을 옮긴 글은, 스테이블이 조 단위로 커져도 유입 충격이 빌 금리를 수 bp 누르는 규모라고 본다. 불 케이스에서 빌 약 9bp. 그 숫자가 30년물에 그대로 옮겨 붙는 공식은 없다.

= 긴 끝이 내려가려면

직접 경로가 막혀 있으면 우회다.

*우회 A. 재무부가 쿠폰을 줄인다.* 빌 사는 손이 두꺼우면 적자를 빌로 메우고 10년·30년 입찰을 안 늘릴 수 있다. 긴 끝 공급이 줄면 숨통이 트인다. 스테이블이 30년을 사서 만드는 효과가 아니다. 발행 만기를 짧게 가져가는 정책이다.

이미 하고 있다. 2026년 8월 QRA는 쿠폰·30년 규모를 유지했고 구멍은 빌이 흡수했다. 쿠폰 순공급이 전년보다 적다는 집계가 나와도 30년물은 내리지 않고 올랐다. 공급을 안 늘렸는데 금리가 아프면, 수요가 약하거나 AI 장기 회사채가 같은 지갑을 쓰거나, 둘 다다.

TBAC는 2026 회계연도 안에는 쿠폰을 유지하고, 2027~28년 약 1.45조 달러의 자금 공백이면 쿠폰을 늘려야 할 수 있다고 봤다. 빌 비중은 이미 권고 구간 위나 끝이다. 빌로만 계속 메우면 차환 위험이 정부에 붙는다. 우회 A는 실재하고, 이미 쓰였고, 한도가 있다. 한도 안에서 하는 일은 “장기 금리를 낮춘다”보다 “장기물 공급을 당장 안 늘린다”다.

*우회 B. 앞이 너무 비싸져 뒤로 간다.* 포트폴리오 재조정은 2차고, 적자·텀 프리미엄·AI 발행 앞에서 잘 진다. 반대도 있다. 스테이블이 은행 예금을 빼가면 은행이 중장기 국채를 덜 살 수 있다. 커브는 오히려 가팔라진다.

*우회 C. 연준이 인하한다고 읽는다.* 짧은 끝의 정책 금리는 연준이 정한다. 빌이 정책 금리보다 조금 더 비싸지는 것은 머니마켓 배관이다. 8월 19일 바이백을 QE로 읽던 날과 같은 반사다.

= 트위스트의 반대

긴 끝을 누르고 싶을 때 하는 일은 짧은 것을 덜 사고 긴 것을 사는 것이다. 오퍼레이션 트위스트, 장기물 바이백, QE의 쿠폰 매입이 그 가족이다. 스테이블 준비금은 반대다. 짧은 것만 사고 긴 것은 손도 안 댄다. 앞을 받치면 상대 가격으로 뒤가 더 높아 보일 수 있다.

달러 3.0이 커질수록 앞은 두꺼워지고, 뒤의 부족은 그대로이거나 더 눈에 띈다.

= 언제면 맞다가 되나

1. 스테이블 공급이 역외·신규 달러로 늘고 (MMF에서 옮긴 돈이면 순수요가 아니다)
2. 재무부가 그 수요를 명분으로 10년·30년 입찰을 줄인다
3. 같은 지갑의 AI 장기 회사채 발행도 꺾인다

1만 있으면 빌이 조금 비싸질 뿐이다. 2가 있어도 3이 없으면, 이미 본 그림이다.

#v(3mm)
#callout("관찰", tone: "amber")[
  빌–10년 스프레드가 벌어지고 30년물이 안 내리면 이 메모가 맞다. 스테이블 시총이 늘는데 30년이 같이 내리면, 원인은 스테이블이 아니라 연준 경로·바이백·쿠폰 축소·성장 기대를 먼저 의심한다.
]

#v(8mm)
#align(right)[#small[작성 기준일 2026년 8월 27일. 특정 자산의 매수·매도를 권유하지 않는다.]]
