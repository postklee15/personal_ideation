#let navy = rgb("#1b365d")
#let navy-soft = rgb("#e8eef5")
#let amber = rgb("#9a3412")
#let amber-soft = rgb("#fff7ed")
#let slate = rgb("#334155")
#let muted = rgb("#64748b")
#let line-c = rgb("#cbd5e1")
#let paper = rgb("#fbfaf7")
#let card = rgb("#f4f1ea")

#set document(
  title: "미국 30년물 금리와 AI 자본 전쟁",
  author: "시장 브리핑",
  keywords: ("Treasury", "30Y", "AI", "duration", "mortgage"),
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
#show heading.where(level: 3): it => {
  v(2mm)
  block(below: 1.6mm)[
    #set text(size: 10.5pt, weight: 700, fill: rgb("#3f5f86"))
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
    #text(size: 14pt, fill: navy, weight: 700)[#value]
    #v(1pt)
    #text(size: 7.5pt, fill: muted)[#note]
  ]
]

#let th-fill = navy
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
      미국 30년물 금리와 AI 자본 전쟁  ·  2026.08.18
      #h(1fr)
      #counter(page).display("1")
    ]
  }
}

#set page(footer: footer-content)

// ===================== 표지 =====================
#block(width: 100%, height: 100% - 0pt)[
  #v(18mm)
  #kicker[MARKET BRIEFING  ·  2026.08.18]
  #v(6mm)
  #text(size: 28pt, weight: 700, fill: navy, tracking: -0.4pt)[
    미국 30년물 금리와\
    AI 자본 전쟁
  ]
  #v(5mm)
  #block(width: 52mm, height: 3.2pt, fill: amber)
  #v(7mm)
  #text(size: 12.5pt, fill: slate)[
    연준이 아니라 장기 자본 수급이 만드는 고금리 국면.\
    듀레이션, 빅테크 발행, 지정학, 주택 모기지까지.
  ]
  #v(10mm)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 6pt,
    metric([30년 국채], [5.31%], [2007년 6월 이후 최고]),
    metric([30년 입찰], [5.216%], [2001년 이후 최고 낙찰금리]),
    metric([30년 모기지], [6.73%], [국채 상승이 주담대로 전달]),
  )

  #v(10mm)
  #block(
    width: 100%,
    fill: white,
    stroke: 0.6pt + line-c,
    radius: 3pt,
    inset: 12pt,
  )[
    #text(weight: 700, fill: navy, size: 10pt)[한 줄 결론]
    #v(3pt)
    지금 미국 장기금리는 기준금리 경로가 아니라, AI가 자본을 놓고 미국 정부와 경쟁하면서 장기 돈의 가격이 다시 매겨지는 국면이다. 시장을 가르는 질문은 “AI인가 아닌가”가 아니라 *이 자산의 듀레이션이 얼마나 긴가*이다.
  ]

  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + line-c)
  #v(4mm)
  #grid(
    columns: (1fr, 1fr),
    text(size: 8.5pt, fill: muted)[
      작성 기준일  2026년 8월 18일\
      성격  내부 브리핑 / 시장 노트\
      원천  시장 코멘트 및 공개 시세·입찰·주택 지표
    ],
    align(right)[
      #text(size: 8.5pt, fill: muted)[
        본 자료는 투자 권유가 아니다.\
        수치는 작성 시점 전후의 공개 보도를 기준으로 한다.
      ]
    ],
  )
]

#pagebreak()

// ===================== 목차 =====================
#heading(level: 1, numbering: none, outlined: false)[목차]
#v(1mm)
#set text(size: 10pt)
#show outline.entry.where(level: 1): set block(above: 0.85em)
#show outline.entry.where(level: 2): set text(size: 9.4pt, fill: muted)
#outline(title: none, indent: 1.1em, depth: 2)
#set text(size: 10pt)

#pagebreak()

#include "parts/briefing-body.typ"
