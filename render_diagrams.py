#!/usr/bin/env python3
"""
Renders every Mermaid diagram (*.mmd) in this folder to PNG and SVG in ./rendered/,
ready to paste into the shared report document.

Rendering uses the public mermaid.ink API, so the only requirements are Python 3.8+
(standard library only, nothing to pip install) and an internet connection.

Usage (from anywhere):
    python3 render_diagrams.py               # render all diagrams
    python3 render_diagrams.py 02 09         # render only files whose names start with 02 or 09

Output files are named after their source, e.g.
    02_3.2-3.4_container-diagram.mmd -> rendered/02_3.2-3.4_container-diagram.png / .svg

PNGs are rendered 2400px wide on a white background so they stay sharp when scaled
down in the document. The physical data model (.sql) is not a diagram and is pasted
into the document as text, so it is not rendered.
"""
import base64
import sys
import urllib.request
from pathlib import Path

SOURCE_DIR = Path(__file__).resolve().parent
OUT_DIR = SOURCE_DIR / "rendered"
PNG_WIDTH = 2400

FORMATS = {
    "png": "https://mermaid.ink/img/{b64}?type=png&bgColor=FFFFFF&width=" + str(PNG_WIDTH),
    "svg": "https://mermaid.ink/svg/{b64}",
}


def fetch(url):
    req = urllib.request.Request(url, headers={"User-Agent": "curl/8"})
    with urllib.request.urlopen(req, timeout=60) as r:
        return r.read()


def main(prefixes):
    OUT_DIR.mkdir(exist_ok=True)
    sources = sorted(SOURCE_DIR.glob("*.mmd"))
    if prefixes:
        sources = [p for p in sources if p.name.startswith(tuple(prefixes))]
    if not sources:
        print("No matching .mmd files found.")
        return 1

    failures = 0
    for path in sources:
        b64 = base64.urlsafe_b64encode(path.read_text(encoding="utf-8").encode()).decode()
        for ext, template in FORMATS.items():
            out = OUT_DIR / f"{path.stem}.{ext}"
            try:
                out.write_bytes(fetch(template.format(b64=b64)))
                print(f"ok    {out.relative_to(SOURCE_DIR)}")
            except Exception as e:
                # mermaid.ink returns HTTP 400 when the diagram has a syntax error;
                # paste the file into https://mermaid.live to see the exact problem.
                failures += 1
                print(f"FAIL  {path.name} ({ext}): {e}")

    if failures:
        print(f"\n{failures} render(s) failed.")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
