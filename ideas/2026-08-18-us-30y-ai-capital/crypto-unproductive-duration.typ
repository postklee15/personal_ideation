#let navy = rgb("#1b365d")
#let navy-soft = rgb("#e8eef5")
#let amber = rgb("#9a3412")
#let amber-soft = rgb("#fff7ed")
#let slate = rgb("#334155")
#let muted = rgb("#64748b")
#let line-c = rgb("#cbd5e1")
#let paper = rgb("#fbfaf7")

#set document(
  title: "가상화폐 렌즈: 생산성 없는 자산의 시간",
  author: "시장 브리핑",
  keywords: ("Treasury", "30Y", "Bitcoin", "real-yield", "duration"),
  date: datetime(year: 2026, month: 8, day: 18),
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

#let metric(label, value, note) = block(
  width: 100%,
  fill: white,
  stroke: 0.5pt + line-c,
  radius: 3pt,
  inset: 9pt,
)[
  #align(center)[
    #text(size: 8pt, fill: muted, weight: 700)[#label]
    #v(2pt)
    #text(size: 12.5pt, fill: navy, weight: 700)[#value]
    #v(1pt)
    #text(size: 7.5pt, fill: muted)[#note]
  ]
]

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
      가상화폐 렌즈 · 생산성 없는 자산의 시간  ·  2026.08.18
      #h(1fr)
      #counter(page).display("1")
    ]
  }
}

#set page(footer: footer-content)

#block(width: 100%, height: 100% - 0pt)[
  #v(16mm)
  #kicker[CRYPTO LENS  ·  선행 논의의 두 질문을 이 시장에 대입]
  #v(6mm)
  #text(size: 26pt, weight: 700, fill: navy, tracking: -0.4pt)[
    가상화폐 렌즈\
    생산성 없는 자산의 시간
  ]
  #v(5mm)
  #block(width: 52mm, height: 3.2pt, fill: amber)
  #v(7mm)
  #text(size: 12pt, fill: slate)[
    높은 실질금리와 AI 자본 수급 국면에서\
    제로 캐시플로 자산이 지는 이유, 그리고 층이 갈리는 이유.
  ]
  #v(9mm)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 6pt,
    metric([10년 실질], [약 2.4%], [TIPS. 제로 캐시플로의 허들]),
    metric([BTC / 금, 1년], [−46% / +32%], [디지털 골드 서사가 갈라진 자리]),
    metric([국가 바닥], [없음], [연산은 지키고 시총은 안 지킴]),
  )

  #v(9mm)
  #block(
    width: 100%,
    fill: white,
    stroke: 0.6pt + line-c,
    radius: 3pt,
    inset: 12pt,
  )[
    #text(weight: 700, fill: navy, size: 10pt)[한 줄]
    #v(3pt)
    맞다. 기본값은 급락의 한 방이 아니라, 이자를 안 주는 자산이 이자를 주는 안전자산·현금흐름이 가까운 AI 공급망과 자본을 놓고 지는 시간이 길어지는 것이다.
  ]

  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + line-c)
  #v(4mm)
  #grid(
    columns: (1fr, 1fr),
    text(size: 8.5pt, fill: muted)[
      작성 기준일  2026년 8월 18일\
      선행  30년물 브리핑 · 항복 · 개인 대응 틀\
      성격  내부 논의 / 시장 노트
    ],
    align(right)[
      #text(size: 8.5pt, fill: muted)[
        본 자료는 투자 권유가 아니다.\
        가상화폐를 한 덩어리로 보지 않는다.
      ]
    ],
  )
]

#pagebreak()

#heading(level: 1, numbering: none, outlined: false)[목차]
#v(1mm)
#outline(title: none, indent: 1.1em, depth: 2)

#include "parts/crypto-body.typ"
