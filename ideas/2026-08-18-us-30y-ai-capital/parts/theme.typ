#let navy = rgb("#1b365d")
#let navy-soft = rgb("#e8eef5")
#let amber = rgb("#9a3412")
#let amber-soft = rgb("#fff7ed")
#let slate = rgb("#334155")
#let muted = rgb("#64748b")
#let line-c = rgb("#cbd5e1")
#let paper = rgb("#fbfaf7")

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
