#let navy = rgb("#1b365d")
#let navy-soft = rgb("#e8eef5")
#let amber = rgb("#9a3412")
#let amber-soft = rgb("#fff7ed")
#let slate = rgb("#334155")
#let muted = rgb("#64748b")
#let line-c = rgb("#cbd5e1")
#let paper = rgb("#fbfaf7")

#set document(
  title: "달러 3.0 구도",
  author: "아이데이션 메모",
  keywords: ("dollar", "stablecoin", "diagram"),
  date: datetime(year: 2026, month: 8, day: 27),
)

#set page(
  paper: "a4",
  margin: (top: 20mm, bottom: 18mm, left: 16mm, right: 16mm),
  fill: paper,
)

#set text(
  font: "Noto Sans KR",
  size: 10pt,
  lang: "ko",
  fill: slate,
  hyphenate: false,
)

#set par(justify: true, leading: 0.7em, spacing: 0.85em)

#let kicker(body) = text(size: 8.5pt, weight: 700, fill: amber, tracking: 0.8pt, body)
#let small(body) = text(size: 8.5pt, fill: muted, body)

#let layer(n, title, body, fill, stroke, light: false) = {
  let tc = if light { white } else { navy }
  let bc = if light { rgb("#e8eef5") } else { slate }
  block(
    width: 100%,
    fill: fill,
    stroke: 1pt + stroke,
    radius: 5pt,
    inset: (x: 11pt, y: 9pt),
  )[
    #grid(
      columns: (22pt, 1fr),
      gutter: 8pt,
      align(horizon)[
        #box(
          width: 20pt,
          height: 20pt,
          fill: stroke,
          radius: 10pt,
        )[
          #align(center + horizon)[
            #text(size: 10pt, weight: 800, fill: white)[#n]
          ]
        ]
      ],
      [
        #text(size: 11pt, weight: 800, fill: tc)[#title]
        #v(1pt)
        #text(size: 9pt, fill: bc)[#body]
      ],
    )
  ]
}

#let arrow-label(txt) = align(center)[
  #v(1.5pt)
  #text(size: 8pt, fill: muted)[▼  #txt]
  #v(1.5pt)
]

#let footer-content = context {
  let p = counter(page).get().first()
  if p > 1 {
    set text(size: 8pt, fill: muted)
    block(width: 100%)[
      #line(length: 100%, stroke: 0.45pt + line-c)
      #v(3pt)
      달러 3.0 구도  ·  2026.08.27
      #h(1fr)
      #counter(page).display("1")
    ]
  }
}

#set page(footer: footer-content)

#kicker[IDEATION  ·  DIAGRAM]
#v(1.5mm)
#text(size: 22pt, weight: 800, fill: navy)[달러 3.0 구도]
#v(1mm)
#text(size: 11.5pt, fill: rgb("#3f5f86"))[위는 누가 쓰나, 가운데는 달러 복제본, 아래는 국채와 법이다]
#v(3mm)
#line(length: 100%, stroke: 1.2pt + navy)
#v(3mm)

#block(
  width: 100%,
  fill: navy-soft,
  stroke: (left: 3pt + navy),
  inset: (x: 10pt, y: 8pt),
  radius: 2pt,
)[
  #text(weight: 700, fill: navy, size: 9.5pt)[한 줄]
  #v(2pt)
  #text(size: 9.5pt)[법정 달러를 온체인에 복제한다. 담보는 국채, 길은 도로다. 금과 비트코인은 옆 창고다.]
]

#v(4mm)

#grid(
  columns: (1fr, 92pt),
  gutter: 8pt,
  [
    #layer("1", "누가 쓰나", [인간  ·  AI 에이전트  ·  역외  ·  도매], rgb("#d7ebff"), rgb("#3DADFF"))
    #arrow-label("쓰다")
    #layer("2", "유통", [비자  ·  스트라이프  ·  코인베이스], rgb("#d4f7f4"), rgb("#2aa89e"))
    #arrow-label("켜다")
    #layer("3", "화폐  =  달러 복제본", [USDC  ·  USDT  ·  은행 코인    ·    1달러 = 1달러], rgb("#d5f5db"), rgb("#3e9b4b"))
    #arrow-label("흘린다")
    #layer("4", "도로  ·  화폐 아님", [Base  ·  솔라나  ·  XRPL  ·  Kinexys  ·  SWIFT], rgb("#e6dcff"), rgb("#874FFF"))
    #arrow-label("지난다")
    #layer("5", "담보 · 수탁", [초단기 국채  ·  현금  ·  BNY  ·  블랙록], rgb("#ffecbd"), rgb("#e8a302"))
    #arrow-label("담보한다")
    #layer("6", "단위와 법", [법정 달러  +  제재 동결], navy, navy, light: true)
  ],
  align(horizon)[
    #block(
      width: 100%,
      fill: rgb("#f1f5f9"),
      stroke: (paint: rgb("#94a3b8"), thickness: 1pt, dash: "dotted"),
      radius: 5pt,
      inset: 9pt,
    )[
      #align(center)[
        #text(size: 8pt, weight: 800, fill: muted)[병행 창고]
        #v(6pt)
        #block(width: 100%, fill: white, stroke: 0.6pt + line-c, radius: 3pt, inset: 7pt)[
          #align(center)[#text(size: 10pt, weight: 700, fill: navy)[금]]
        ]
        #v(6pt)
        #block(width: 100%, fill: white, stroke: 0.6pt + line-c, radius: 3pt, inset: 7pt)[
          #align(center)[#text(size: 10pt, weight: 700, fill: navy)[비트코인]]
        ]
        #v(8pt)
        #text(size: 7.5pt, fill: muted)[화폐가 아님]
        #v(4pt)
        #text(size: 7.5pt, fill: muted)[점선으로 6층에만 닿는다]
      ]
    ]
  ],
)

#v(4mm)
#align(center)[
  #text(size: 9.5pt, style: "italic", fill: navy)[발행사는 싸우고, 유통 · 담보 · 수탁은 어느 스테이블이 이겨도 남는다]
]

#pagebreak()

#text(size: 15pt, weight: 800, fill: navy)[층을 이렇게 읽는다]
#v(2mm)
#line(length: 100%, stroke: 1.2pt + navy)
#v(3mm)

돈이 아래로 내려갈수록 달러에 가까워진다. 위는 사용자, 가운데는 복제본, 아래는 국채와 법이다.

#v(2mm)

#table(
  columns: (auto, 1fr, 1fr),
  stroke: 0.4pt + line-c,
  inset: (x: 7pt, y: 6pt),
  fill: (_, y) => {
    if y == 0 { navy }
    else if calc.odd(y) { rgb("#f8fafc") }
    else { white }
  },
  table.header(
    text(fill: white, weight: 700, size: 8.5pt)[층],
    text(fill: white, weight: 700, size: 8.5pt)[하는 일],
    text(fill: white, weight: 700, size: 8.5pt)[혼동하지 말 것],
  ),
  [1 누가 쓰나], [돈을 써야 하는 주체], [AI가 담보가 아니다],
  [2 유통], [켜고 꽂고 정산한다], [발행사가 갈려도 이 문은 남는다],
  [3 화폐], [1달러짜리 복제본], [가격이 오르는 알트가 아니다],
  [4 도로], [복제본이 지나가는 길], [통행료 토큰이 기축이 아니다],
  [5 담보·수탁], [국채와 현금에 앉힌다], [담보는 금·원유·비트가 아니다],
  [6 단위와 법], [이름을 달러로 남기고 동결한다], [제재를 포기하는 체제가 아니다],
  [옆 창고], [보험으로 쌓아 둔다], [창고는 화폐가 아니다],
)

#v(6mm)
#text(size: 13pt, weight: 800, fill: navy)[틀린 그림, 맞은 그림]
#v(2mm)

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  block(
    width: 100%,
    fill: rgb("#fff1f0"),
    stroke: 1pt + rgb("#ff7556"),
    radius: 4pt,
    inset: 10pt,
  )[
    #text(size: 8pt, weight: 800, fill: rgb("#dc3009"))[틀린 그림]
    #v(4pt)
    #align(center)[
      #text(size: 10pt, fill: navy)[금]
      #v(2pt)
      #text(size: 8pt, fill: rgb("#dc3009"))[죽임 ▼]
      #v(2pt)
      #text(size: 10pt, fill: navy)[원유]
      #v(2pt)
      #text(size: 8pt, fill: rgb("#dc3009"))[죽임 ▼]
      #v(2pt)
      #text(size: 10pt, fill: navy)[BTC · ETH · SOL · XRP]
    ]
    #v(4pt)
    #text(size: 8.5pt)[담보를 죽여 기축을 교체한다.]
  ],
  block(
    width: 100%,
    fill: rgb("#eefbf1"),
    stroke: 1pt + rgb("#3e9b4b"),
    radius: 4pt,
    inset: 10pt,
  )[
    #text(size: 8pt, weight: 800, fill: rgb("#3e9b4b"))[맞은 그림]
    #v(4pt)
    #align(center)[
      #text(size: 10pt, fill: navy)[법정 달러]
      #v(2pt)
      #text(size: 8pt, fill: rgb("#3e9b4b"))[복제 ▼]
      #v(2pt)
      #text(size: 10pt, fill: navy)[USDC · USDT]
      #v(2pt)
      #text(size: 8pt, fill: rgb("#3e9b4b"))[담보 ▼]
      #v(2pt)
      #text(size: 10pt, fill: navy)[초단기 국채]
    ]
    #v(4pt)
    #text(size: 8.5pt)[같은 달러가 배관만 바꾼다.]
  ],
)

#v(6mm)
#text(size: 13pt, weight: 800, fill: navy)[한 번의 결제가 앉는 곳]
#v(2mm)

사람이 카드를 긁으면 비자가 앞에서 받고, 뒤에서 USDC가 Base를 지나 초단기 국채에 앉는다. AI가 초소액을 내면 스트라이프가 받아 솔라나 위 USDC로 같은 국채에 앉는다. 도매는 JP모건 허가형 원장, 역외는 테더. 도착지는 네 길 모두 T-bill과 법이다.

#v(3mm)

#block(
  width: 100%,
  fill: white,
  stroke: 0.6pt + line-c,
  radius: 4pt,
  inset: 10pt,
)[
  #text(size: 9pt)[인간 → 비자 → USDC → Base → T-bill → BNY → 법정 달러]
  #v(3pt)
  #text(size: 9pt)[AI → 스트라이프 → USDC → 솔라나 → T-bill]
  #v(3pt)
  #text(size: 9pt)[도매 → Kinexys → 은행 코인 → T-bill]
  #v(3pt)
  #text(size: 9pt)[역외 → 테더망 → USDT → 솔라나 → T-bill]
]

#v(5mm)
#small[편집용 FigJam  https://www.figma.com/board/7IEGWTjWBDCmlf1N6Fez4n]
#v(2mm)
#small[작성 기준일 2026년 8월 27일. 특정 자산의 매수·매도를 권유하지 않는다.]

#pagebreak()

#text(size: 15pt, weight: 800, fill: navy)[포스터]
#v(2mm)
#line(length: 100%, stroke: 1.2pt + navy)
#v(3mm)

#image("dollar-3-layers.png", width: 100%)
