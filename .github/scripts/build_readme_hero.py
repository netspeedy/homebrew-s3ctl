#!/usr/bin/env python3
"""Build the animated README hero, assets/s3ctl-readme-hero.svg.

The banner follows the soakes/cv README hero: the bucket mark, a two-line headline, a short body
and a meta row on the left, and a generated scene on the right. The scene is a three by three
floor of bucket slabs. An access key sends a packet to its own bucket, app-data, which lights up
with 200 OK, then to the next one, billing, which refuses it with 403 AccessDenied.

Edit the copy, layout or timing here and rerun rather than editing the generated SVG. The
headline is positioned from measured advances (see ADVANCE); if you change its words, measure
them again with measure_headline.py. Inter and JetBrains Mono (SIL Open Font License 1.1) are
fetched from Google Fonts, subset to the characters the finished SVG renders, and embedded, so
the hero renders the same on every platform. Needs network access.
"""

from __future__ import annotations

import base64
import random
import re
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUTPUT = ROOT / "assets" / "s3ctl-readme-hero.svg"
USER_AGENT = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36"
)

# The bucket mark's cyan and amber (assets/logo.svg), with oakes.me.uk's inks so the netspeedy
# banners read as one family.
BG = "#060B13"
INK = "#F1F5FA"
INK_2 = "#B5C0CD"
INK_3 = "#808D9E"
CYAN = "#4BD8FF"
CYAN_2 = "#A8ECFF"
CYAN_3 = "#18A8FF"
AMBER = "#F5B841"
AMBER_2 = "#FDE1A7"
GREEN = "#3CD788"
RED = "#FF5D6C"

# Fonts: css class -> (Google Fonts family spec, embedded family name).
FAMILIES = {
    "sans": ("Inter:opsz,wght@14..32,400..800", "Hero Sans"),
    "mono": ("JetBrains Mono:wght@400..700", "Hero Mono"),
}
FONT_CSS = (
    ".sans{font-family:'Hero Sans',-apple-system,'Segoe UI','Helvetica Neue',Arial,sans-serif;"
    "font-optical-sizing:auto;}"
    ".mono{font-family:'Hero Mono','SF Mono',Menlo,Consolas,monospace;}"
)
TWINKLE_CSS = (
    ".tw{animation:tw 5.2s ease-in-out infinite;transform-box:fill-box;transform-origin:center}"
    ".tw1{animation-duration:6.4s}.tw2{animation-duration:4.6s}.tw3{animation-duration:7.3s}"
    "@keyframes tw{0%,100%{opacity:.85}50%{opacity:.15}}"
)

# Starfield: seeded, so rebuilding gives the same sky. No star sits behind the copy.
STAR_SEED = 11
STARS = 110
TWINKLING = 16
COPY_BOX = (36, 30, 520, 340)

# Headline advances in px, measured by measure_headline.py on Inter 800 at 44px (opsz 32,
# letter-spacing -1.3). The swash and the gradients are placed from these.
ADVANCE = {
    "One ": 88.04,
    "key": 69.64,
    "One key,": 164.29,
    "one bucket.": 228.13,
}


# Fonts


def fetch(url: str) -> bytes:
    request = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(request, timeout=30) as response:
        return response.read()


def collect_chars(svg: str) -> dict[str, set[str]]:
    """Characters rendered by each font class, inherited through groups."""
    chars: dict[str, set[str]] = {name: set() for name in FAMILIES}

    def family_of(element: ET.Element, inherited: str | None) -> str | None:
        for cls in (element.get("class") or "").split():
            if cls in FAMILIES:
                return cls
        return inherited

    def walk(element: ET.Element, inherited: str | None, in_text: bool) -> None:
        tag = element.tag.split("}")[-1]
        family = family_of(element, inherited)
        if tag in ("style", "title", "desc", "script"):
            return
        is_text = in_text or tag in ("text", "tspan", "textPath")
        if is_text and tag in ("text", "tspan", "textPath") and element.text:
            if family is None:
                raise SystemExit(f"text without a font class: {element.text!r}")
            chars[family].update(element.text)
        for child in element:
            walk(child, family, is_text)
            if is_text and child.tail and child.tail.strip():
                chars[family or "sans"].update(child.tail)

    walk(ET.fromstring(svg), None, False)
    return chars


def font_faces(svg: str) -> str:
    """One @font-face per family, subset to exactly the characters the SVG renders."""
    chars = collect_chars(svg)
    faces = []
    for cls, (spec, local) in FAMILIES.items():
        used = chars[cls]
        if not used:
            continue
        text = "".join(sorted((used - set("\n\t\r")) | {" "}))
        query = urllib.parse.urlencode({"family": spec, "text": text, "display": "block"})
        css = fetch(f"https://fonts.googleapis.com/css2?{query}").decode()
        seen = set()
        # Google serves one variable file covering every weight; embed each file once.
        for weight, url in re.findall(
            r"font-weight:\s*([\d ]+);.*?src:\s*url\(([^)]+)\)", css, re.S
        ):
            if url in seen:
                continue
            seen.add(url)
            data = base64.b64encode(fetch(url)).decode()
            faces.append(
                f"@font-face{{font-family:'{local}';font-weight:{weight.strip()};"
                f"font-style:normal;src:url(data:font/woff2;base64,{data}) format('woff2');}}"
            )
    return "".join(faces)


# Small helpers


def esc(text: str) -> str:
    return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def num(value: float) -> str:
    """One decimal place, without a trailing .0."""
    text = f"{value:.1f}"
    return text[:-2] if text.endswith(".0") else text


def mono_width(chars: int, size: float, spacing: float = 0.0) -> float:
    """JetBrains Mono advances exactly 0.6 em; letter-spacing applies per glyph."""
    return chars * (size * 0.6 + spacing)


def gradient(kind: str, attrs: str, stops: list[tuple[str, str, str]]) -> list[str]:
    lines = [f"    <{kind} {attrs}>"]
    for offset, colour, opacity in stops:
        alpha = f' stop-opacity="{opacity}"' if opacity else ""
        lines.append(f'      <stop offset="{offset}" stop-color="{colour}"{alpha} />')
    return [*lines, f"    </{kind}>"]


def dot_paths(
    points: list[tuple[float, float, int]],
    styles: dict[int, tuple[float, float]],
    colour: str = "#D3E4F4",
) -> str:
    """Dots grouped by band, each band one path of round-capped stubs."""
    paths = []
    for band, (opacity, width) in styles.items():
        pts = sorted(((x, y) for x, y, b in points if b == band), key=lambda p: (round(p[1]), p[0]))
        if not pts:
            continue
        moves = []
        px = py = 0.0
        for x, y in pts:
            # "h.01", not "h0": some renderers drop zero-length subpaths.
            moves.append(f"m{num(x - px)} {num(y - py)}h.01")
            px, py = x + 0.01, y
        paths.append(
            f'<path d="M0 0{"".join(moves)}" fill="none" stroke="{colour}" '
            f'stroke-opacity="{opacity}" stroke-width="{width}" stroke-linecap="round" />'
        )
    return "".join(paths)


def chip(
    x: float,
    y: float,
    label: str,
    colour: str,
    cls: str = "",
    size: float = 10.5,
    spacing: float = 1.2,
    fill_opacity: float = 0.9,
) -> str:
    """A mono label in a small outlined box; (x, y) is the box's top-left corner."""
    width = mono_width(len(label), size, spacing) - spacing + 16
    attr = f' class="{cls}"' if cls else ""
    return (
        f'<g{attr}><rect x="{num(x)}" y="{num(y)}" width="{num(width)}" height="20" rx="4" '
        f'fill="#0A0F18" fill-opacity="{fill_opacity}" stroke="{colour}" stroke-opacity="0.4" />'
        f'<text class="mono" x="{num(x + width / 2)}" y="{num(y + 13.8)}" text-anchor="middle" '
        f'font-size="{size}" letter-spacing="{spacing}" fill="{colour}">{esc(label)}</text></g>'
    )


# Shared card


def starfield(free: list[tuple[float, float, float, float]]) -> tuple[list[str], list[str]]:
    """Background gradient and nebula defs, plus the body: base, glows and seeded stars."""
    rng = random.Random(STAR_SEED)
    stars = []
    tries = 0
    while len(stars) < STARS and tries < STARS * 50:
        tries += 1
        x, y = rng.uniform(8, 1192), rng.uniform(8, 392)
        if any(x0 <= x <= x1 and y0 <= y <= y1 for x0, y0, x1, y1 in free):
            continue
        radius = rng.choice([0.55, 0.6, 0.7, 0.8, 0.9, 1.0, 1.15])
        stars.append((x, y, radius, rng.uniform(0.18, 0.6)))
    twinkling = [
        f'<circle class="tw tw{i % 4}" cx="{num(x)}" cy="{num(y)}" r="{num(r + 0.25)}" '
        f'fill="#DDF2FF" opacity="{o + 0.25:.2f}" '
        f'style="animation-delay:-{rng.uniform(0, 6):.1f}s" />'
        for i, (x, y, r, o) in enumerate(stars[:TWINKLING])
    ]
    plain = "".join(
        f'<circle cx="{num(x)}" cy="{num(y)}" r="{num(r)}" opacity="{o:.2f}" />'
        for x, y, r, o in stars[TWINKLING:]
    )
    defs = [
        '    <linearGradient id="spaceBg" x1="0" y1="0" x2="0.35" y2="1">',
        '      <stop offset="0" stop-color="#081020" />',
        f'      <stop offset="0.55" stop-color="{BG}" />',
        '      <stop offset="1" stop-color="#0B1424" />',
        "    </linearGradient>",
        *gradient(
            "radialGradient",
            'id="nebCyan" cx="0.5" cy="0.5" r="0.5"',
            [("0", CYAN_3, "0.34"), ("1", CYAN_3, "0")],
        ),
        *gradient(
            "radialGradient",
            'id="nebIndigo" cx="0.5" cy="0.5" r="0.5"',
            [("0", "#3B4BB8", "0.3"), ("1", "#3B4BB8", "0")],
        ),
    ]
    body = [
        '    <rect width="1200" height="400" fill="url(#spaceBg)" />',
        '    <ellipse cx="190" cy="-30" rx="520" ry="260" fill="url(#nebIndigo)" />',
        '    <ellipse cx="1000" cy="420" rx="560" ry="300" fill="url(#nebCyan)" opacity="0.5" />',
        f'    <g fill="#CFE6FF">{plain}</g>',
        f'    <g>{"".join(twinkling)}</g>',
    ]
    return defs, body


def bucket_symbols() -> list[str]:
    """The bucket from assets/logo.svg: the full tile, and the outline on its own."""
    outline = (
        '<ellipse cx="32" cy="16" rx="14" ry="4.2" />'
        '<path d="M18 16 L21.5 47 L42.5 47 L46 16" />'
        '<path d="M19 25 L45 25" stroke-width="2.2" stroke-opacity="0.85" />'
        '<path d="M20 34 L44 34" stroke-width="2.2" stroke-opacity="0.85" />'
    )
    keyhole = (
        f'<g fill="{AMBER}"><circle cx="32" cy="39" r="2.8" />'
        '<path d="M30.7 41 L33.3 41 L34.2 46.6 L29.8 46.6 Z" /></g>'
    )
    return [
        *gradient(
            "linearGradient",
            'id="markStroke" x1="16" y1="14" x2="48" y2="50" gradientUnits="userSpaceOnUse"',
            [("0", CYAN, ""), ("1", CYAN_3, "")],
        ),
        '    <symbol id="bucket" viewBox="0 0 64 64">',
        '      <g fill="none" stroke="url(#markStroke)" stroke-width="3.4" stroke-linecap="round" '
        f'stroke-linejoin="round">{outline}</g>{keyhole}',
        "    </symbol>",
    ]


def lockup() -> list[str]:
    return [
        '  <rect x="48.5" y="38.5" width="33" height="33" rx="8" fill="#0E1726" stroke="#3B4A5F" '
        'stroke-width="1.2" />',
        '  <use href="#bucket" x="49" y="39" width="32" height="32" />',
        f'  <text class="sans" x="94" y="52.5" font-size="15" font-weight="600" fill="{INK}">'
        "s3ctl</text>",
        f'  <text class="sans" x="94" y="69.5" font-size="12" fill="{INK_3}">'
        "netspeedy · S3 bucket provisioning CLI</text>",
    ]


def headline(prefix: str, word: str, suffix: str, second: str) -> tuple[list[str], list[str]]:
    """Two lines at 44px: line one with a highlighted word and an amber swash under it."""
    x = 46.0
    first = prefix + word + suffix
    start = x + ADVANCE[prefix]
    bare = word.rstrip(",.")
    end = start + ADVANCE[bare]
    defs = [
        *gradient(
            "linearGradient",
            f'id="titleWhite" gradientUnits="userSpaceOnUse" x1="{num(x)}" y1="0" '
            f'x2="{num(x + ADVANCE[first])}" y2="0"',
            [("0", "#FFFFFF", ""), ("1", "#D5ECF8", "")],
        ),
        *gradient(
            "linearGradient",
            f'id="hl" gradientUnits="userSpaceOnUse" x1="{num(start)}" y1="0" '
            f'x2="{num(end)}" y2="0"',
            [("0", CYAN_2, ""), ("0.5", "#F4F7FA", ""), ("1", AMBER, "")],
        ),
        *gradient(
            "linearGradient",
            f'id="titleCyan" gradientUnits="userSpaceOnUse" x1="{num(x)}" y1="0" '
            f'x2="{num(x + ADVANCE[second])}" y2="0"',
            [("0", CYAN_2, ""), ("0.55", CYAN, ""), ("1", CYAN_3, "")],
        ),
        *gradient(
            "linearGradient",
            'id="uline" x1="0" y1="0" x2="1" y2="0"',
            [("0", AMBER, "0.35"), ("0.5", AMBER, ""), ("1", AMBER, "0.5")],
        ),
    ]
    span = end - start
    tail = f'<tspan fill="url(#titleWhite)">{esc(suffix)}</tspan>' if suffix else ""
    els = [
        f'  <text class="sans" x="{num(x)}" y="160" font-size="44" font-weight="800" '
        'letter-spacing="-1.3" xml:space="preserve">'
        f'<tspan fill="url(#titleWhite)">{esc(prefix)}</tspan>'
        f'<tspan fill="url(#hl)">{esc(word)}</tspan>{tail}</text>',
        f'  <path d="M{num(start + 2)} 172.5q{num(span * 0.5)} -6.5 {num(span - 6)} -1.5" '
        'fill="none" stroke="url(#uline)" stroke-width="2.6" stroke-linecap="round" />',
        f'  <text class="sans" x="{num(x)}" y="212" font-size="44" font-weight="800" '
        f'letter-spacing="-1.3" fill="url(#titleCyan)">{esc(second)}</text>',
    ]
    return defs, els


def body(lines: list[list[tuple[str, bool]]]) -> list[str]:
    out = [f'  <text class="sans" font-size="15.5" fill="{INK_2}" xml:space="preserve">']
    for i, segments in enumerate(lines):
        spans = "".join(
            (
                f'<tspan class="mono" font-size="14" fill="{CYAN_2}">{esc(text)}</tspan>'
                if mono
                else esc(text)
            )
            for text, mono in segments
        )
        out.append(f'    <tspan x="48" y="{254 + 23 * i}">{spans}</tspan>')
    out.append("  </text>")
    return out


def meta_row(labels: list[str]) -> str:
    x = 48.0
    parts = []
    for i, label in enumerate(labels):
        if i:
            parts.append(f'<circle cx="{num(x + 9)}" cy="318.3" r="2.1" fill="{AMBER}" />')
            x += 19
        parts.append(f'<text x="{num(x)}" y="322">{esc(label)}</text>')
        x += mono_width(len(label), 11.5, 1.5)
    return (
        f'  <g class="mono" font-size="11.5" letter-spacing="1.5" fill="{INK_3}">'
        f'{"".join(parts)}</g>'
    )


# Scene: isolation

ISO_W, ISO_H, ISO_T = 80.0, 40.0, 16.0  # grid step (half a tile's width and height), slab depth
ISO_O = (910.0, 214.0)  # centre of the middle tile's top face
TILE = 0.84  # top faces are drawn smaller than the grid step, so gaps show between slabs
OWN, OTHER = (0, 0), (1, -1)
NAMES = {OWN: "app-data", OTHER: "billing"}
KEY = (716.0, 104.0)  # the key hovers above and left of the floor; both packets start from it
LOOP = 8.0
TO_OWN = (0.0, 1.3)  # seconds into the loop that each packet leaves and lands
TO_OTHER = (3.9, 5.1)


def iso(i: int, j: int) -> tuple[float, float]:
    return ISO_O[0] + (i - j) * ISO_W, ISO_O[1] + (i + j) * ISO_H


def poly(*points: tuple[float, float]) -> str:
    return "M" + "L".join(f"{num(x)} {num(y)}" for x, y in points) + "Z"


def pct(seconds: float) -> float:
    return seconds / LOOP * 100


def packet(cls: str, d: str) -> str:
    """A packet along `d`: a wide faint glow under a thin bright core."""
    return (
        f'<path class="{cls}" pathLength="100" d="{d}" fill="none" stroke="{AMBER}" '
        'stroke-width="4.5" stroke-opacity="0.3" stroke-linecap="round" />'
        f'<path class="{cls}" pathLength="100" d="{d}" fill="none" stroke="{AMBER_2}" '
        'stroke-width="1.8" stroke-linecap="round" />'
    )


def packet_css(cls: str, leave: float, land: float) -> str:
    """Hidden until `leave`, then a 16-unit dash runs the path's length and vanishes at `land`."""
    start, end = pct(leave), pct(land)
    return (
        f".{cls}{{stroke-dasharray:16 120;stroke-dashoffset:16;opacity:0;"
        f"animation:{cls} {LOOP}s linear infinite}}"
        f"@keyframes {cls}{{0%,{start:.2f}%{{stroke-dashoffset:16;opacity:0}}"
        f"{start + 0.01:.2f}%{{stroke-dashoffset:16;opacity:1}}"
        f"{end:.2f}%{{stroke-dashoffset:-100;opacity:1}}"
        f"{end + 0.01:.2f}%,100%{{stroke-dashoffset:-100;opacity:0}}}}"
    )


def scene_isolation() -> tuple[list[str], str, str, list[tuple[float, float, float, float]]]:
    """A three by three floor of bucket slabs; the key reaches app-data and billing refuses it."""
    w, h = ISO_W * TILE, ISO_H * TILE
    tiles, dots, labels = [], [], []
    cells = sorted(((i, j) for i in (-1, 0, 1) for j in (-1, 0, 1)), key=lambda c: c[0] + c[1])
    for cell in cells:  # back to front
        cx, cy = iso(*cell)
        mine = cell == OWN
        top = poly((cx, cy - h), (cx + w, cy), (cx, cy + h), (cx - w, cy))
        left = poly((cx - w, cy), (cx, cy + h), (cx, cy + h + ISO_T), (cx - w, cy + ISO_T))
        right = poly((cx, cy + h), (cx + w, cy), (cx + w, cy + ISO_T), (cx, cy + h + ISO_T))
        tiles.append(
            f'<path d="{left}" fill="#07101C" stroke="#1C2D44" stroke-width="0.8" />'
            f'<path d="{right}" fill="#0A1626" stroke="#1C2D44" stroke-width="0.8" />'
            f'<path d="{top}" fill="#0C1A2C" stroke="{CYAN if mine else "#4B6A8C"}" '
            f'stroke-opacity="{0.7 if mine else 0.35}" stroke-width="1.1" />'
        )
        # A dotted lattice on each top face.
        for a in range(1, 8):
            for b in range(1, 8):
                u, v = a / 8, b / 8
                dots.append((cx + (u - v) * w, cy - h + (u + v) * h, 1 if mine else 0))
        if mine:
            # The key's policy boundary, marching round its own bucket.
            boundary = poly(
                (cx, cy - h - 10), (cx + w + 20, cy), (cx, cy + h + 10), (cx - w - 20, cy)
            )
            tiles.append(
                f'<path class="policy" d="{boundary}" fill="none" stroke="{CYAN}" '
                'stroke-opacity="0.55" stroke-width="1.2" stroke-dasharray="5 5" />'
            )
        if cell == OTHER:
            tiles.append(
                f'<path class="deny" d="{top}" fill="{RED}" fill-opacity="0.12" stroke="{RED}" '
                'stroke-width="1.6" />'
            )
        if mine:
            tiles.append(
                f'<path class="ok" d="{top}" fill="{GREEN}" fill-opacity="0.1" stroke="{GREEN}" '
                'stroke-width="1.6" />'
            )
        # Stand each bucket on the middle of its face; the outline's base is 47/64 down the symbol.
        # The name sits just below it, where the face is still wide enough to hold it.
        size = 36 if mine else 30
        base = cy + 3
        tiles.append(
            f'<use href="#bucket" x="{num(cx - size / 2)}" y="{num(base - size * 47 / 64)}" '
            f'width="{size}" height="{size}" opacity="{1 if mine else 0.55}" />'
        )
        if cell in NAMES:
            label = NAMES[cell]
            if mono_width(len(label), 9, 0.4) / 2 > w * (1 - (base + 13.5 - cy) / h) - 6:
                raise SystemExit(f"tile label {label!r} is wider than its tile face")
            labels.append(
                f'<text class="mono" x="{num(cx)}" y="{num(base + 13.5)}" text-anchor="middle" '
                f'font-size="9" letter-spacing="0.4" fill="{INK if mine else INK_2}">'
                f"{esc(label)}</text>"
            )

    kx, ky = KEY
    ox, oy = iso(*OWN)
    tx, ty = iso(*OTHER)
    to_own = f"M{num(kx + 14)} {num(ky + 6)}Q{num(ox - 60)} {num(ky - 10)} {num(ox)} {num(oy - 36)}"
    to_other = (
        f"M{num(kx + 16)} {num(ky - 2)}Q{num((kx + tx) / 2)} {num(ky - 70)} "
        f"{num(tx - 6)} {num(ty - 40)}"
    )
    # 200 OK shows from the first landing until the second packet leaves; 403 flickers on, then
    # holds until near the end of the loop.
    ok, deny = pct(TO_OWN[1]), pct(TO_OTHER[1])
    css = (
        packet_css("pa", *TO_OWN)
        + packet_css("pb", *TO_OTHER)
        + f".ok,.okc{{animation:ok {LOOP}s ease-out infinite}}"
        f"@keyframes ok{{0%,{ok - 0.5:.2f}%{{opacity:0}}{ok + 1:.2f}%{{opacity:1}}"
        f"{ok + 32:.2f}%{{opacity:1}}{ok + 40:.2f}%,100%{{opacity:0}}}}"
        f".deny,.denyc{{animation:deny {LOOP}s ease-out infinite}}"
        f"@keyframes deny{{0%,{deny - 0.5:.2f}%{{opacity:0}}{deny + 0.6:.2f}%{{opacity:1}}"
        f"{deny + 3:.2f}%{{opacity:.45}}{deny + 5:.2f}%{{opacity:1}}"
        f"{deny + 26:.2f}%{{opacity:1}}{deny + 33:.2f}%,100%{{opacity:0}}}}"
        ".policy{animation:march 1.6s linear infinite}"
        "@keyframes march{to{stroke-dashoffset:-20}}"
        ".kglow{animation:kglow 4s ease-in-out infinite}"
        "@keyframes kglow{0%,100%{opacity:.55}50%{opacity:1}}"
    )
    defs = [
        *gradient(
            "radialGradient",
            'id="keyGlow" cx="0.5" cy="0.5" r="0.5"',
            [("0", AMBER, "0.6"), ("0.4", AMBER, "0.16"), ("1", AMBER, "0")],
        ),
        *gradient(
            "radialGradient",
            'id="floorGlow" cx="0.5" cy="0.5" r="0.5"',
            [("0", CYAN_3, "0.3"), ("1", CYAN_3, "0")],
        ),
    ]
    key = (
        f'<circle class="kglow" cx="{num(kx)}" cy="{num(ky)}" r="40" fill="url(#keyGlow)" />'
        f'<g transform="translate({num(kx - 17)} {num(ky - 17)}) rotate(-12 17 17)" fill="none" '
        f'stroke="{AMBER_2}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">'
        '<circle cx="10" cy="22" r="7" /><path d="M15 17L31 2M26 7l4 4M21.5 11.5l3 3" /></g>'
        f'<text class="mono" x="{num(kx)}" y="{num(ky + 36)}" text-anchor="middle" '
        f'font-size="10.5" letter-spacing="1.2" fill="{AMBER_2}">AKIA…EXAMPLE</text>'
    )
    routes = "".join(
        f'<path d="{d}" fill="none" stroke="{AMBER}" stroke-opacity="{opacity}" '
        'stroke-width="1.1" stroke-dasharray="3 4" />'
        for d, opacity in ((to_own, 0.28), (to_other, 0.2))
    )
    chips = chip(ox - 112, oy - 78, "200 OK", GREEN, "okc")
    chips += chip(tx - 66, ty - 82, "403 AccessDenied", RED, "denyc")
    glow = (
        f'<ellipse cx="{num(ISO_O[0])}" cy="{num(ISO_O[1] + 20)}" rx="300" ry="150" '
        'fill="url(#floorGlow)" />'
    )
    scene = "".join(
        [
            glow,
            f'<g>{"".join(tiles)}</g>',
            dot_paths(dots, {0: (0.16, 1.1), 1: (0.4, 1.2)}),
            "".join(labels),
            routes,
            packet("pa", to_own),
            packet("pb", to_other),
            key,
            chips,
        ]
    )
    return defs, css, scene, [(640, 40, 1170, 380)]


# Copy

CARD = {
    "title": "s3ctl - one key, one bucket",
    "desc": (
        "A floor of bucket slabs. An access key reaches its own bucket, app-data, with 200 OK, "
        "and is refused by the bucket billing with 403 AccessDenied."
    ),
    "headline": ("One ", "key,", "", "one bucket."),
    "body": [
        [("Each key's policy names one bucket, so a leaked key", False)],
        [("gets ", False), ("403 AccessDenied", True), (" everywhere else.", False)],
    ],
    "meta": ["BUCKET-READONLY", "BUCKET-READWRITE", "BUCKET-ADMIN"],
    "scene": scene_isolation,
}


def build_svg(spec: dict = CARD) -> str:
    scene_defs, scene_css, scene, free = spec["scene"]()
    star_defs, star_body = starfield([COPY_BOX, *free])
    head_defs, head_els = headline(*spec["headline"])
    lines = [
        '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 400" width="960" height="320" '
        'role="img" aria-labelledby="title desc">',
        f'  <title id="title">{esc(spec["title"])}</title>',
        f'  <desc id="desc">{esc(spec["desc"])}</desc>',
        "",
        "  <defs>",
        "    <style>",
        "      /* Inter and JetBrains Mono, SIL Open Font License 1.1, subset to the glyphs used "
        "here. */",
        "      __FONT_FACES__",
        f"      {FONT_CSS}",
        f"      {TWINKLE_CSS}",
        f"      {scene_css}",
        "      @media (prefers-reduced-motion: reduce){",
        "        *{animation:none !important}",
        "      }",
        "    </style>",
        *star_defs,
        *bucket_symbols(),
        *head_defs,
        *scene_defs,
        '    <clipPath id="frame"><rect x="1" y="1" width="1198" height="398" rx="20" />'
        "</clipPath>",
        "  </defs>",
        "",
        '  <g clip-path="url(#frame)">',
        *star_body,
        f"    {scene}",
        "  </g>",
        '  <rect x="0.75" y="0.75" width="1198.5" height="398.5" rx="20" fill="none" '
        'stroke="#1A2638" stroke-width="1.5" />',
        "",
        "  <!-- Left: brand and headline -->",
        *lockup(),
        "",
        *head_els,
        *body(spec["body"]),
        meta_row(spec["meta"]),
        "</svg>",
    ]
    return "\n".join(lines) + "\n"


def main() -> None:
    svg = build_svg()
    svg = svg.replace("__FONT_FACES__", font_faces(svg))
    if "http://" in svg.replace("http://www.w3.org/2000/svg", "") or "https://" in svg:
        raise SystemExit("external reference found in the hero SVG")
    ET.fromstring(svg)  # well-formed, or this raises
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(svg, encoding="utf-8")
    print(f"Wrote {OUTPUT.relative_to(ROOT)} ({len(svg.encode()) / 1024:.1f} KiB)")


if __name__ == "__main__":
    main()
