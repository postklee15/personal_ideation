#let navy = rgb("#1b365d")
#let navy-soft = rgb("#e8eef5")
#let amber = rgb("#9a3412")
#let amber-soft = rgb("#fff7ed")
#let slate = rgb("#334155")
#let muted = rgb("#64748b")
#let line-c = rgb("#cbd5e1")
#let paper = rgb("#fbfaf7")

#set document(
  title: "후속 논의: 누가 먼저 항복하는가",
  author: "시장 브리핑",
  keywords: ("Treasury", "30Y", "AI", "duration", "discussion"),
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
    #text(size: 13pt, fill: navy, weight: 700)[#value]
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
      후속 논의 · 누가 먼저 항복하는가  ·  2026.08.18
      #h(1fr)
      #counter(page).display("1")
    ]
  }
}

#set page(footer: footer-content)

// ===================== 표지 =====================
#block(width: 100%, height: 100% - 0pt)[
  #v(16mm)
  #kicker[DISCUSSION MEMO  ·  선행 브리핑의 열린 질문]
  #v(6mm)
  #text(size: 26pt, weight: 700, fill: navy, tracking: -0.4pt)[
    후속 논의\
    누가 먼저 항복하는가
  ]
  #v(5mm)
  #block(width: 52mm, height: 3.2pt, fill: amber)
  #v(7mm)
  #text(size: 12pt, fill: slate)[
    미국 30년물과 AI 자본 전쟁 브리핑을 전제로,\
    규모·반론·한국 렌즈, 바이백과 연준의 흡수까지 다음에 볼 충돌을 고른다.
  ]
  #v(9mm)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 6pt,
    metric([AI 부채 YTD], [약 5,000억], [골드만, 하이퍼스케일러는 그중 40%]),
    metric([국채 대비 비중], [약 25%], [메가캡 발행 / 순국채·빌 제외·민간]),
    metric([실질금리], [약 93%], [6월 중순 이후 30년물 상승분]),
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
    부족한 것은 돈이 아니라 공적·장기·투명한 듀레이션이다. 바이백은 하루짜리 밸브다. 공짜로 30년을 내릴 손은 없다.
  ]

  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + line-c)
  #v(4mm)
  #grid(
    columns: (1fr, 1fr),
    text(size: 8.5pt, fill: muted)[
      작성 기준일  2026년 8월 18일\
      선행  `미국_30년물_금리_AI_자본전쟁_브리핑.pdf`\
      성격  내부 논의 메모 / 시장 노트
    ],
    align(right)[
      #text(size: 8.5pt, fill: muted)[
        본 자료는 투자 권유가 아니다.\
        브리핑을 다시 쓰지 않는다. 싸울 지점만 고른다.
      ]
    ],
  )
]

#pagebreak()

#heading(level: 1, numbering: none, outlined: false)[목차]
#v(1mm)
#set text(size: 10pt)
#show outline.entry.where(level: 1): set block(above: 0.85em)
#show outline.entry.where(level: 2): set text(size: 9.4pt, fill: muted)
#outline(title: none, indent: 1.1em, depth: 2)
#set text(size: 10pt)

#include "parts/discussion-body.typ"
