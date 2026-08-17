#!/usr/bin/env node
/**
 * 트리마제 38A — 방3 통로형 드레스룸 평면도 생성.
 *
 * 현장 실측은 공개되어 있지 않다.
 * mm 값은 전용 84.82㎡ + 첨부 38A 평면도 비율 + 국내 공동주택 모듈의 환산값.
 * 시공 발주 전 해당 세대 현장 실측으로 보정할 것.
 */
import { writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const W = 200;
const ROOM1 = { x: 200, y: 200, w: 6200, h: 3200 };
const ENSUITE = { x: 200, y: 1400, w: 1800, h: 2000 };
const BATH = { x: 6600, y: 200, w: 2000, h: 2200 };
const ENTRY = { x: 8800, y: 200, w: 2600, h: 2200 };
const HALL = { x: 8800, y: 2600, w: 2600, h: 2200 };
const LIVING = { x: 200, y: 3600, w: 6400, h: 4600 };
const ROOM2 = { x: 6800, y: 5000, w: 2200, h: 3200 };
const ROOM3 = { x: 9200, y: 5000, w: 2900, h: 3200 };
const CLOSET = { x: 10100, y: 5000, w: 2000, h: 700 };
const DOOR3 = { x: 9200, y: 5000, w: 800 };
const DR_DEPTH = 1500;
const DR_PASS = 900;
const DR_CLOSET_D = 600;
const DR_WALL = 100;
const UNIT_W = 12300;
const UNIT_H = 8600;
const SCALE = 0.11;

const px = (mm) => Math.round(mm * SCALE * 100) / 100;
const area = (r) => Math.round((r.w * r.h) / 10000) / 100;
const EXCLUSIVE =
  area(ROOM1) + area(BATH) + area(ENTRY) + area(HALL) + area(LIVING) + area(ROOM2) + area(ROOM3);

const C = {
  wood: "#C9A36A",
  wood2: "#B89058",
  bed: "#E8D5B0",
  bath: "#8FB8C9",
  bath2: "#A8CADC",
  entry_a: "#B8B8B8",
  entry_b: "#F4F4F4",
  closet: "#FFFFFF",
  dr: "#E4C9B6",
  dr_cab: "#F7F1EA",
  wall: "#2B2B2B",
  wall_thin: "#4A4A4A",
  ink: "#1A1A1A",
  muted: "#5C5C5C",
  dim: "#C0392B",
  new: "#1F7A4D",
  paper: "#F7F4EE",
  card: "#FFFFFF",
  line: "#D8D2C8",
  door: "#6B5A4A",
  win: "#6A8FA3",
  furn: "#8A7A68",
  sofa: "#7A8B6F",
};

const rect = (x, y, w, h, fill, stroke = null, sw = 1, extra = "") => {
  const s = stroke ? ` stroke="${stroke}" stroke-width="${sw}"` : ' stroke="none"';
  return `<rect x="${px(x)}" y="${px(y)}" width="${px(w)}" height="${px(h)}" fill="${fill}"${s} ${extra}/>`;
};
const text = (x, y, s, size = 13, fill = C.ink, anchor = "middle", weight = 600, extra = "") =>
  `<text x="${px(x)}" y="${px(y)}" font-size="${size}" fill="${fill}" text-anchor="${anchor}" font-weight="${weight}" ${extra}>${s}</text>`;
const line = (x1, y1, x2, y2, stroke, sw = 1, extra = "") =>
  `<line x1="${px(x1)}" y1="${px(y1)}" x2="${px(x2)}" y2="${px(y2)}" stroke="${stroke}" stroke-width="${sw}" ${extra}/>`;

function checker(x, y, w, h, cell = 200) {
  const parts = [rect(x, y, w, h, C.entry_b)];
  for (let yy = 0; yy < h; yy += cell) {
    const row = Math.floor(yy / cell);
    for (let xx = 0; xx < w; xx += cell) {
      if ((row + Math.floor(xx / cell)) % 2 === 0) {
        parts.push(rect(x + xx, y + yy, Math.min(cell, w - xx), Math.min(cell, h - yy), C.entry_a));
      }
    }
  }
  return parts.join("\n");
}

function woodFloor(x, y, w, h) {
  const parts = [rect(x, y, w, h, C.wood)];
  for (let yy = 0; yy < h; yy += 180) {
    parts.push(line(x, y + yy, x + w, y + yy, C.wood2, 0.6, 'opacity="0.45"'));
  }
  return parts.join("\n");
}

function doorSwing(hx, hy, width, toward = "se") {
  const r = width;
  let d, leaf;
  if (toward === "se") {
    d = `M ${px(hx + r)} ${px(hy)} A ${px(r)} ${px(r)} 0 0 1 ${px(hx)} ${px(hy + r)}`;
    leaf = line(hx, hy, hx + r, hy, C.door, 2);
  } else if (toward === "sw") {
    d = `M ${px(hx - r)} ${px(hy)} A ${px(r)} ${px(r)} 0 0 0 ${px(hx)} ${px(hy + r)}`;
    leaf = line(hx, hy, hx - r, hy, C.door, 2);
  } else if (toward === "ne") {
    d = `M ${px(hx + r)} ${px(hy)} A ${px(r)} ${px(r)} 0 0 0 ${px(hx)} ${px(hy - r)}`;
    leaf = line(hx, hy, hx + r, hy, C.door, 2);
  } else {
    d = `M ${px(hx - r)} ${px(hy)} A ${px(r)} ${px(r)} 0 0 1 ${px(hx)} ${px(hy - r)}`;
    leaf = line(hx, hy, hx - r, hy, C.door, 2);
  }
  return `${leaf}\n<path d="${d}" fill="none" stroke="${C.door}" stroke-width="1.2"/>`;
}

function window(x, y, w, side = "s") {
  if (side === "s") {
    return rect(x, y + 40, w, 80, "#D6E6EE", C.win, 1.4) + line(x, y + 80, x + w, y + 80, C.win, 1);
  }
  return rect(x, y - 40, w, 80, "#D6E6EE", C.win, 1.4) + line(x, y, x + w, y, C.win, 1);
}

function furnitureBed(x, y, w, h) {
  return [
    rect(x, y, w, h, "#F3E6CF", C.furn, 1, 'rx="4"'),
    rect(x + 40, y + 40, w - 80, 160, "#EFE7DC", C.furn, 0.8),
  ].join("\n");
}

function closetBox(x, y, w, h, title = "옷장") {
  const parts = [rect(x, y, w, h, C.closet, C.wall_thin, 1.4)];
  const n = Math.max(2, Math.floor(w / 500));
  for (let i = 1; i < n; i++) parts.push(line(x + (w * i) / n, y, x + (w * i) / n, y + h, C.line, 1));
  parts.push(text(x + w / 2, y + h / 2 + 40, title, 12, C.muted, "middle", 600));
  return parts.join("\n");
}

function hangerCabinet(x, y, w, h, title = "행거") {
  const parts = [rect(x, y, w, h, C.dr_cab, C.new, 1.6)];
  parts.push(line(x + 80, y + 180, x + w - 80, y + 180, C.furn, 2));
  for (let i = 0; i < 4; i++) {
    const cx = x + 200 + (i * (w - 400)) / 3;
    parts.push(
      `<ellipse cx="${px(cx)}" cy="${px(y + 280)}" rx="7" ry="18" fill="none" stroke="${C.furn}" stroke-width="1.2"/>`,
    );
  }
  parts.push(line(x + 40, y + h - 160, x + w - 40, y + h - 160, C.line, 1));
  parts.push(text(x + w / 2, y + h / 2 + 80, title, 11, C.new, "middle", 700));
  return parts.join("\n");
}

function unitShell() {
  return [
    rect(0, 0, UNIT_W, UNIT_H, C.paper, C.wall, 4),
    rect(ROOM1.x, ROOM1.y, ROOM1.w, ROOM1.h, C.bed),
    text(ROOM1.x + 3600, ROOM1.y + 700, "방1", 16),
    furnitureBed(ROOM1.x + 2800, ROOM1.y + 900, 2200, 1800),
    rect(ENSUITE.x, ENSUITE.y, ENSUITE.w, ENSUITE.h, C.bath2, C.wall, 2),
    text(ENSUITE.x + 900, ENSUITE.y + 280, "안방욕실", 11, C.muted),
    rect(ENSUITE.x + 200, ENSUITE.y + 500, 500, 700, "#D8E8EE", C.win, 1),
    rect(ENSUITE.x + 900, ENSUITE.y + 1400, 700, 400, "#CEE0E8", C.win, 1),
    doorSwing(ENSUITE.x + 1800, ENSUITE.y + 200, 700, "sw"),
    rect(BATH.x, BATH.y, BATH.w, BATH.h, C.bath, C.wall, 2),
    text(BATH.x + 1000, BATH.y + 280, "욕실", 13),
    rect(BATH.x + 200, BATH.y + 500, 500, 700, "#D8E8EE", C.win, 1),
    rect(BATH.x + 1100, BATH.y + 1500, 700, 500, "#CEE0E8", C.win, 1),
    doorSwing(BATH.x + 200, BATH.y + 2200, 700, "ne"),
    checker(ENTRY.x, ENTRY.y, ENTRY.w, ENTRY.h),
    rect(ENTRY.x + 1800, ENTRY.y + 200, 600, 1800, C.closet, C.wall_thin, 1.2),
    text(ENTRY.x + 1000, ENTRY.y + 400, "현관", 13),
    rect(HALL.x, HALL.y, HALL.w, HALL.h, "#EFE8DC"),
    text(HALL.x + 1300, HALL.y + 400, "복도", 12, C.muted, "middle", 500),
    woodFloor(LIVING.x, LIVING.y, LIVING.w, LIVING.h),
    text(LIVING.x + 1800, LIVING.y + 500, "거실", 18),
    rect(LIVING.x + 400, LIVING.y + 900, 2200, 900, C.sofa, null, 0, 'rx="8" opacity="0.85"'),
    rect(LIVING.x + 900, LIVING.y + 2000, 1100, 600, "#E8D8B8", C.furn, 1),
    rect(LIVING.x + 3600, LIVING.y + 2800, 2600, 600, "#D9D3C7", C.wall_thin, 1.2),
    rect(LIVING.x + 5600, LIVING.y + 1600, 600, 1800, "#D9D3C7", C.wall_thin, 1.2),
    text(LIVING.x + 4800, LIVING.y + 2500, "주방", 16),
    rect(LIVING.x + 3800, LIVING.y + 3600, 1400, 800, "#EFE6D4", C.furn, 1),
    rect(ROOM2.x, ROOM2.y, ROOM2.w, ROOM2.h, C.bed, C.wall, 2),
    text(ROOM2.x + 1100, ROOM2.y + 400, "방2", 15),
    furnitureBed(ROOM2.x + 350, ROOM2.y + 900, 1500, 2000),
    doorSwing(ROOM2.x + 200, ROOM2.y, 800, "se"),
    window(ROOM2.x + 400, ROOM2.y + ROOM2.h, 1400, "s"),
    window(LIVING.x + 800, LIVING.y + LIVING.h, 2800, "s"),
    window(ROOM1.x + 2200, ROOM1.y, 2400, "n"),
  ].join("\n");
}

function room3Asis() {
  return [
    rect(ROOM3.x, ROOM3.y, ROOM3.w, ROOM3.h, C.bed, C.wall, 2.4),
    text(ROOM3.x + 1100, ROOM3.y + 1600, "방3", 16),
    furnitureBed(ROOM3.x + 400, ROOM3.y + 1400, 1600, 1500),
    closetBox(CLOSET.x, CLOSET.y, CLOSET.w, CLOSET.h, "옷장"),
    doorSwing(DOOR3.x, DOOR3.y, DOOR3.w, "se"),
    window(ROOM3.x + 500, ROOM3.y + ROOM3.h, 1800, "s"),
  ].join("\n");
}

function room3Tobe() {
  const r = ROOM3;
  const wallY = r.y + DR_DEPTH;
  const ax = r.x + DR_PASS / 2;
  return [
    rect(r.x, r.y, r.w, r.h, C.bed, C.wall, 2.4),
    rect(r.x, r.y, r.w, DR_DEPTH, C.dr, C.new, 2),
    rect(r.x, r.y, DR_PASS, DR_DEPTH, "#F6EDE4", C.new, 1.2),
    hangerCabinet(r.x + DR_PASS, r.y, r.w - DR_PASS, DR_CLOSET_D, "상부 행거 600"),
    hangerCabinet(r.x + r.w - DR_CLOSET_D, r.y + DR_CLOSET_D, DR_CLOSET_D, DR_DEPTH - DR_CLOSET_D, "측면"),
    rect(r.x + DR_PASS, wallY - DR_WALL / 2, r.w - DR_PASS, DR_WALL, C.wall),
    `<path d="M ${px(ax)} ${px(r.y + 200)} L ${px(ax)} ${px(wallY + 400)}" fill="none" stroke="${C.new}" stroke-width="2.4" marker-end="url(#arrowG)"/>`,
    text(ax + 20, r.y + 800, "통로", 11, C.new, "start", 700),
    text(r.x + r.w / 2 + 200, r.y + 1100, "드레스룸", 13, C.new),
    text(r.x + 1100, r.y + DR_DEPTH + 500, "방3 침실", 15),
    furnitureBed(r.x + 400, r.y + DR_DEPTH + 400, 1600, 1400),
    doorSwing(DOOR3.x, DOOR3.y, DOOR3.w, "se"),
    window(r.x + 500, r.y + r.h, 1800, "s"),
  ].join("\n");
}

function wallsOverlay() {
  return [
    rect(0, 0, UNIT_W, UNIT_H, "none", C.wall, 5),
    rect(200, 3400, 6400, W, C.wall),
    rect(6400, 200, W, 3200, C.wall),
    rect(8600, 200, W, 2400, C.wall),
    rect(6600, 5000, W, 3200, C.wall),
    rect(9000, 5000, W, 3200, C.wall),
    rect(6800, 4800, 5300, W, C.wall),
    rect(6600, 3600, W, 1400, C.wall),
  ].join("\n");
}

function planGroup(ox, oy, room3Fn, title, badgeFill, badge) {
  const inner = `${unitShell()}\n${room3Fn()}\n${wallsOverlay()}`;
  const tw = px(UNIT_W) + 80;
  const th = px(UNIT_H) + 90;
  return `
    <g transform="translate(${ox},${oy})">
      <rect x="-24" y="-56" width="${tw}" height="${th}" rx="16" fill="${C.card}" stroke="${C.line}" stroke-width="1.5"/>
      <rect x="-24" y="-56" width="8" height="${th}" rx="4" fill="${badgeFill}"/>
      <text x="8" y="-28" font-size="18" font-weight="700" fill="${C.ink}">${title}</text>
      <rect x="${tw - 140}" y="-48" width="100" height="24" rx="12" fill="${badgeFill}"/>
      <text x="${tw - 90}" y="-31" font-size="11" font-weight="700" fill="#fff" text-anchor="middle">${badge}</text>
      ${inner}
    </g>`;
}

function room3Detail(ox, oy, tobe) {
  const s = 0.28;
  const lp = (mm) => Math.round(mm * s * 100) / 100;
  const lrect = (x, y, w, h, fill, stroke = null, sw = 1.4) => {
    const st = stroke ? ` stroke="${stroke}" stroke-width="${sw}"` : ' stroke="none"';
    return `<rect x="${lp(x)}" y="${lp(y)}" width="${lp(w)}" height="${lp(h)}" fill="${fill}"${st}/>`;
  };
  const ltext = (x, y, t, size = 12, fill = C.ink, anchor = "middle", weight = 600) =>
    `<text x="${lp(x)}" y="${lp(y)}" font-size="${size}" fill="${fill}" text-anchor="${anchor}" font-weight="${weight}">${t}</text>`;
  const lline = (x1, y1, x2, y2, stroke, sw = 1) =>
    `<line x1="${lp(x1)}" y1="${lp(y1)}" x2="${lp(x2)}" y2="${lp(y2)}" stroke="${stroke}" stroke-width="${sw}"/>`;

  const w = ROOM3.w;
  const h = ROOM3.h;
  const parts = [lrect(0, 0, w, h, C.bed, C.wall, 3)];
  let title, badge, bf;
  if (!tobe) {
    const cx = CLOSET.x - ROOM3.x;
    const cy = CLOSET.y - ROOM3.y;
    const cw = CLOSET.w;
    const ch = CLOSET.h;
    parts.push(lrect(cx, cy, cw, ch, C.closet, C.wall_thin, 1.6));
    parts.push(ltext(cx + cw / 2, cy + ch / 2 + 40, "기존 옷장", 12, C.muted));
    parts.push(ltext(w / 2 - 200, h / 2 + 200, "방3", 18));
    parts.push(lline(0, 0, 800, 0, C.door, 3));
    parts.push(
      `<path d="M ${lp(800)} ${lp(0)} A ${lp(800)} ${lp(800)} 0 0 1 ${lp(0)} ${lp(800)}" fill="none" stroke="${C.door}" stroke-width="1.4"/>`,
    );
    parts.push(lline(0, -140, w, -140, C.dim, 1));
    parts.push(ltext(w / 2, -180, `${w} mm`, 12, C.dim));
    parts.push(lline(-140, 0, -140, h, C.dim, 1));
    parts.push(ltext(-220, h / 2, `${h}`, 12, C.dim, "end"));
    parts.push(lline(cx, ch + 80, cx + cw, ch + 80, C.dim, 1));
    parts.push(ltext(cx + cw / 2, ch + 160, `옷장 ${cw}×${ch}`, 11, C.dim));
    parts.push(ltext(400, -40, "문 800", 11, C.door));
    title = "방3 기존 — 입구 우상단 붙박이 옷장";
    badge = "AS-IS";
    bf = "#8A7A68";
  } else {
    parts.push(lrect(0, 0, w, DR_DEPTH, C.dr, C.new, 2));
    parts.push(lrect(0, 0, DR_PASS, DR_DEPTH, "#F6EDE4", C.new, 1.4));
    parts.push(lrect(DR_PASS, 0, w - DR_PASS, DR_CLOSET_D, C.dr_cab, C.new, 1.6));
    parts.push(lrect(w - DR_CLOSET_D, DR_CLOSET_D, DR_CLOSET_D, DR_DEPTH - DR_CLOSET_D, C.dr_cab, C.new, 1.6));
    parts.push(lrect(DR_PASS, DR_DEPTH - DR_WALL / 2, w - DR_PASS, DR_WALL, C.wall));
    parts.push(ltext(DR_PASS / 2, DR_DEPTH / 2, "통로", 13, C.new));
    parts.push(ltext(DR_PASS + (w - DR_PASS) / 2, 320, "상부 행거", 12, C.new));
    parts.push(ltext(w / 2 - 100, DR_DEPTH + 500, "침실", 16));
    parts.push(
      `<path d="M ${lp(DR_PASS / 2)} ${lp(120)} L ${lp(DR_PASS / 2)} ${lp(DR_DEPTH + 280)}" fill="none" stroke="${C.new}" stroke-width="2.2" marker-end="url(#arrowG)"/>`,
    );
    parts.push(lline(0, 0, 800, 0, C.door, 3));
    parts.push(
      `<path d="M ${lp(800)} ${lp(0)} A ${lp(800)} ${lp(800)} 0 0 1 ${lp(0)} ${lp(800)}" fill="none" stroke="${C.door}" stroke-width="1.4"/>`,
    );
    parts.push(lline(0, -140, w, -140, C.dim, 1));
    parts.push(ltext(w / 2, -180, `방 폭 ${w} mm`, 12, C.dim));
    parts.push(lline(0, -280, DR_PASS, -280, C.new, 1));
    parts.push(ltext(DR_PASS / 2, -320, `통로 ${DR_PASS}`, 11, C.new));
    parts.push(lline(w + 140, 0, w + 140, DR_DEPTH, C.new, 1));
    parts.push(ltext(w + 220, DR_DEPTH / 2, `DR ${DR_DEPTH}`, 11, C.new, "start"));
    parts.push(lline(w + 140, DR_DEPTH, w + 140, h, C.dim, 1));
    parts.push(ltext(w + 220, (DR_DEPTH + h) / 2, `침실 ${h - DR_DEPTH}`, 11, C.dim, "start"));
    parts.push(lline(DR_PASS, DR_CLOSET_D + 80, w, DR_CLOSET_D + 80, C.new, 1));
    parts.push(ltext((DR_PASS + w) / 2, DR_CLOSET_D + 160, `행거 깊이 ${DR_CLOSET_D}`, 11, C.new));
    title = "방3 변경 — 통로형 드레스룸";
    badge = "TO-BE";
    bf = C.new;
  }
  parts.push(lrect(500, h - 40, 1800, 80, "#D6E6EE", C.win, 1.4));
  parts.push(ltext(1400, h + 160, "창", 11, C.win));
  const boxW = lp(w) + 220;
  const boxH = lp(h) + 200;
  return `
    <g transform="translate(${ox},${oy})">
      <rect x="-40" y="-80" width="${boxW + 80}" height="${boxH + 80}" rx="16" fill="${C.card}" stroke="${C.line}"/>
      <text x="0" y="-48" font-size="16" font-weight="700" fill="${C.ink}">${title}</text>
      <rect x="${boxW - 70}" y="-70" width="72" height="22" rx="11" fill="${bf}"/>
      <text x="${boxW - 34}" y="-54" font-size="10" font-weight="700" fill="#fff" text-anchor="middle">${badge}</text>
      ${parts.join("")}
    </g>`;
}

function legend(ox, oy) {
  const items = [
    [C.wood, "거실·주방 (우드)"],
    [C.bed, "침실"],
    [C.bath, "욕실"],
    [C.entry_a, "현관 타일"],
    [C.closet, "기존 옷장"],
    [C.dr, "드레스룸 존"],
    [C.new, "신설 통로·행거"],
  ];
  const rows = items.flatMap(([col, name], i) => {
    const yy = i * 26;
    return [
      `<rect x="0" y="${yy}" width="16" height="16" rx="3" fill="${col}" stroke="#ccc"/>`,
      `<text x="24" y="${yy + 13}" font-size="12" fill="${C.ink}">${name}</text>`,
    ];
  });
  return `<g transform="translate(${ox},${oy})">${rows.join("")}</g>`;
}

function buildSvg() {
  const boardW = 1680;
  const boardH = 1480;
  const g1 = planGroup(56, 150, room3Asis, "기존 평면  38A", "#8A7A68", "AS-IS");
  const g2 = planGroup(860, 150, room3Tobe, "변경 평면  방3 통로형 드레스룸", C.new, "TO-BE");
  const d1 = room3Detail(56, 880, false);
  const d2 = room3Detail(860, 880, true);
  const notes = `
    <g transform="translate(56,1320)">
      <text x="0" y="0" font-size="13" font-weight="700" fill="${C.ink}">치수 근거 · 시공 전 확인</text>
      <text x="0" y="22" font-size="12" fill="${C.muted}">현장 실측 데이터는 공개되어 있지 않음. 본 치수는 전용 84.82㎡와 첨부 38A 평면도 비율로 환산한 값이다 (내부 순면 합 ${EXCLUSIVE}㎡).</text>
      <text x="0" y="42" font-size="12" fill="${C.muted}">방3 환산: 2,900 × 3,200 mm. 기존 옷장 함몰 2,000 × 700 mm. 변경: 통로 900 · 행거 깊이 600 · 드레스룸 존 깊이 1,500 · 침실 잔여 깊이 1,700.</text>
      <text x="0" y="62" font-size="12" fill="${C.muted}">모듈은 국내 공동주택 관례(문 800, 옷장 600, 통로 900, 경량벽 100). 벽체·창호·문틀 실측 후 발주할 것. 천장고는 미확인.</text>
    </g>`;
  return `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${boardW}" height="${boardH}" viewBox="0 0 ${boardW} ${boardH}">
  <defs>
    <style>
      text { font-family: "Noto Sans KR", "IBM Plex Sans KR", "Apple SD Gothic Neo", sans-serif; }
    </style>
    <marker id="arrowG" markerWidth="8" markerHeight="8" refX="6" refY="3" orient="auto">
      <path d="M0,0 L6,3 L0,6 Z" fill="${C.new}"/>
    </marker>
  </defs>
  <rect width="100%" height="100%" fill="${C.paper}"/>
  <text x="56" y="48" font-size="26" font-weight="800" fill="${C.ink}">트리마제 38A · 방3 통로형 드레스룸</text>
  <text x="56" y="74" font-size="13" fill="${C.muted}">성수동 트리마제  ·  전용 84.82㎡  /  공급 126.66㎡  ·  방3 화2  ·  84A 97세대</text>
  <text x="56" y="96" font-size="12" fill="${C.dim}">치수 mm 는 평면도 스케일 환산값 (현장 실측 아님). 시공 전 해당 세대 실측 필수.</text>
  ${g1}
  ${g2}
  ${d1}
  ${d2}
  ${legend(1480, 180)}
  ${notes}
</svg>
`;
}

const outDir = dirname(fileURLToPath(import.meta.url));
writeFileSync(join(outDir, "trimage-38a-room3-dressing.svg"), buildSvg(), "utf8");
writeFileSync(
  join(outDir, "dimensions.json"),
  JSON.stringify(
    {
      complex: "성수동 트리마제",
      type: "38A / 84A",
      exclusive_m2: 84.82,
      supply_m2: 126.66,
      units_this_type: 97,
      occupancy: "2017-05-29",
      basis: "현장 실측 없음. 전용면적 + 첨부 38A 평면도 비율 환산.",
      exclusive_sum_scaled_m2: EXCLUSIVE,
      unit: "mm",
      room3: { width: ROOM3.w, depth: ROOM3.h, door: DOOR3.w },
      closet_asis: { width: CLOSET.w, depth: CLOSET.h },
      walkthrough_dressing: {
        zone_depth: DR_DEPTH,
        passage_width: DR_PASS,
        hanger_depth: DR_CLOSET_D,
        partition: DR_WALL,
        bedroom_remaining_depth: ROOM3.h - DR_DEPTH,
      },
    },
    null,
    2,
  ) + "\n",
  "utf8",
);
console.log("exclusive sum", EXCLUSIVE);
