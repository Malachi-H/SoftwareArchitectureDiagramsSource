# TransitGo — Architecture Diagram Sources

Diagram source for the TransitGo (Public Transport Ticketing Application) software
architecture. Each file is one diagram's raw source: Mermaid (`.mmd`) for the C4 and other
diagrams, SQL (`.sql`) for the physical data model. Paste any `.mmd` file into the
[Mermaid Live Editor](https://mermaid.live) to view or export it.

| File | Diagram |
|---|---|
| `01_3.1_context-diagram.mmd` | System Context diagram |
| `02_3.2-3.4_container-diagram.mmd` | Container diagram |
| `03_3.5-3.7_component-ticketing-payments.mmd` | Component diagram — Ticketing & Payments Service |
| `04_3.5-3.7_component-real-time-tracking.mmd` | Component diagram — Real-Time Tracking Service |
| `05_3.5-3.7_conceptual-data-model.mmd` | Conceptual data model (ER diagram) |
| `06_3.8-3.10_code-fare-calculator.mmd` | Code diagram — Fare Calculator class diagram |
| `07_3.8-3.10_physical-data-model.sql` | Physical data model |
| `08_3.B_iot-architecture.mmd` | IoT architecture — Edge/Platform/Enterprise tiers |
| `09_4.3_deployment-diagram.mmd` | Deployment diagram |
| `10_4.4_sequence-tap-to-pay.mmd` | Tap-to-pay/validate sequence diagram |

## Rendering the diagrams

Rendered images live in `rendered/` (a PNG and an SVG per diagram, named after the
source file). After editing any `.mmd` file, regenerate them with:

```bash
python3 render_diagrams.py          # all diagrams
python3 render_diagrams.py 02 09    # only files starting with 02 or 09
```

The script needs Python 3.8+ and an internet connection only. It uses the standard
library and the public [mermaid.ink](https://mermaid.ink) API, so there is nothing to
install. A failed render usually means a Mermaid syntax error; paste the file into the
[Mermaid Live Editor](https://mermaid.live) to find it. Commit the updated `rendered/`
files along with the source changes so the images stay in sync.
