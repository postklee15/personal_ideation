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
  title: "미국 30년물 금리와 AI 자본 전쟁 — 합본",
  author: "시장 브리핑",
  keywords: ("Treasury", "30Y", "AI", "duration", "mortgage", "household", "Bitcoin"),
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
  if it.numbering == none {
    none
  } else {
    pagebreak(weak: true)
    v(2mm)
    block(below: 4mm)[
      #set text(size: 15pt, weight: 700, fill: navy)
      #block(
        width: 100%,
        inset: (bottom: 3mm),
        stroke: (bottom: 1.6pt + navy),
      )[
        #counter(heading).display()
        #h(2mm)
        #it.body
      ]
    ]
  }
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
      미국 30년물 금리와 AI 자본 전쟁 합본  ·  2026.08.18
      #h(1fr)
      #counter(page).display("1")
    ]
  }
}

#set page(footer: footer-content)

#let part-page(kicker-text, title, subtitle) = {
  pagebreak(weak: false)
  counter(heading).update(0)
  block(width: 100%, height: 100% - 40pt)[
    #v(1fr)
    #kicker(kicker-text)
    #v(8mm)
    #text(size: 26pt, weight: 700, fill: navy, tracking: -0.4pt)[#title]
    #v(5mm)
    #block(width: 52mm, height: 3.2pt, fill: amber)
    #v(7mm)
    #text(size: 12pt, fill: slate)[#subtitle]
    #v(1fr)
  ]
}

// ===================== 표지 =====================
#block(width: 100%, height: 100% - 0pt)[
  #v(14mm)
  #kicker[COMBINED BRIEFING  ·  2026.08.18]
  #v(6mm)
  #text(size: 26pt, weight: 700, fill: navy, tracking: -0.4pt)[
    미국 30년물 금리와\
    AI 자본 전쟁
  ]
  #v(3mm)
  #text(size: 13pt, weight: 700, fill: amber)[합본]
  #v(5mm)
  #block(width: 52mm, height: 3.2pt, fill: amber)
  #v(7mm)
  #text(size: 12pt, fill: slate)[
    브리핑부터 후속 논의, 가상화폐 렌즈, 개인 대응까지 한 권으로 묶었다.\
    연준이 아니라 장기 자본 수급이 만드는 고금리 국면.
  ]
  #v(7mm)

  #grid(
    columns: (1fr, 1fr),
    rows: (auto, auto),
    gutter: 6pt,
    metric([제1부], [브리핑], [구조와 듀레이션]),
    metric([제2부], [후속 논의], [누가 먼저 항복하는가]),
    metric([제3부], [가상화폐], [생산성 없는 자산의 시간]),
    metric([제4부], [개인 대응], [가계 부채와 두 질문]),
  )

  #v(8mm)
  #block(
    width: 100%,
    fill: white,
    stroke: 0.6pt + line-c,
    radius: 3pt,
    inset: 12pt,
  )[
    #text(weight: 700, fill: navy, size: 10pt)[한 줄]
    #v(3pt)
    지금 미국 장기금리는 기준금리 경로가 아니라, AI가 자본을 놓고 미국 정부와 경쟁하면서 장기 돈의 가격이 다시 매겨지는 국면이다. 네러티브는 분자를 바꾸고, 금리는 분모를 바꾼다. 시장을 가르는 질문은 “AI인가 아닌가”가 아니라 *이 자산의 듀레이션이 얼마나 긴가*이다.
  ]

  #v(1fr)
  #line(length: 100%, stroke: 0.5pt + line-c)
  #v(4mm)
  #grid(
    columns: (1fr, 1fr),
    text(size: 8.5pt, fill: muted)[
      작성 기준일  2026년 8월 18일\
      구성  브리핑 · 후속 논의 · 가상화폐 · 개인 대응\
      성격  내부 브리핑 / 시장 노트
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

#heading(level: 1, numbering: none, outlined: false)[목차]
#v(1mm)
#set text(size: 10pt)
#show outline.entry.where(level: 1): set block(above: 0.85em)
#show outline.entry.where(level: 2): set text(size: 9.4pt, fill: muted)
#outline(title: none, indent: 1.1em, depth: 2)
#set text(size: 10pt)

#part-page(
  [PART I  ·  MARKET BRIEFING],
  [제1부  브리핑],
  [미국 30년물 금리와 AI 자본 전쟁.\ 연준이 아닌 장기 수급, 듀레이션, 지정학, 주택까지.],
)
#heading(level: 1, numbering: none)[제1부  브리핑]
#include "parts/briefing-body.typ"

#part-page(
  [PART II  ·  DISCUSSION],
  [제2부  후속 논의],
  [누가 먼저 항복하는가.\ 일본 수요 축, 바이백은 밸브, 연준은 기능에서만.],
)
#heading(level: 1, numbering: none)[제2부  후속 논의]
#include "parts/discussion-body.typ"

#part-page(
  [PART III  ·  CRYPTO LENS],
  [제3부  가상화폐 렌즈],
  [생산성 없는 자산의 시간.\ 제로 캐시플로, 실질금리, 스테이블·채굴 층의 갈림.],
)
#heading(level: 1, numbering: none)[제3부  가상화폐 렌즈]
#include "parts/crypto-body.typ"

#part-page(
  [PART IV  ·  HOUSEHOLD PLAYBOOK],
  [제4부  개인투자자 대응 틀],
  [종목보다 듀레이션.\ 가계 부채와 두 질문으로 대응의 순서를 정한다.],
)
#heading(level: 1, numbering: none)[제4부  개인투자자 대응 틀]
#include "parts/playbook-body.typ"
