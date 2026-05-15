---
layout: default
title: Shindo Japan Seismic Risk Intelligence Graph
---

## Shindo (震度) — Japan Seismic Risk Intelligence Graph

A cascading risk graph connecting earthquakes, fault zones, tsunamis, nuclear facilities, and prefectures — built for the **Neo4j Aura Agent Hackathon**. Named after 震度, Japan's official seismic intensity scale, because this agent reasons about local impact and cascading consequences, not just raw magnitude at the source.

[Launch Live App](https://shindo-earthquake-graph.pages.dev/){:target="_blank" rel="noopener noreferrer"} · [GitHub](https://github.com/Dean-Foulds/shindo-earthquake-graph){:target="_blank" rel="noopener noreferrer"}

---

### The Core Idea

Japan's disasters cascade: Fault rupture → Ground shaking → Tsunami → Prefecture inundation → Nuclear facility exposure. A CSV stores events. A graph stores the chain — and an AI agent can traverse it in a single query.

The 2011 Tōhoku earthquake didn't just happen — it traversed a graph:

```
Japan Trench ruptured → M9.1 earthquake struck
  → 40m tsunami generated → Miyagi, Iwate, Fukushima inundated
    → Fukushima Daiichi within 10km → cascading nuclear crisis
```

Every link in that chain is a graph edge. The agent can trace it, explain it, and ask: which other fault zones have the same potential?

---

### Dataset

| Source | Detail |
|--------|--------|
| USGS Earthquake Hazards Program | ~33,875 M4.0+ events, 1950–present |
| IAEA PRIS Nuclear Reactor Registry | 15 nuclear facilities |
| JMA Fault Zone Data | 9 major fault zones |
| Japan Prefecture Reference | 47 prefectures with coastal classifications |
| NOAA NCEI Historical Tsunami Database | 135 tsunami events with measured wave heights |
| GEBCO 2026 Bathymetry Grid | Sea floor depth at every epicentre |
| JMA Live Feed | Real-time events via ATOM eqvol.xml (60s polling) |

---

### Formal Ontology

The graph schema is grounded in a formal OWL 2 ontology (`ontology/japanese_earthquake.ttl`), authored in Turtle format with bilingual English/Japanese labels.

**Base URI:** `http://deanfoulds.xyz/ontology/earthquake#`

**13 OWL Classes across four domains:**

| Domain | Classes |
|--------|---------|
| Seismic events | `Earthquake`, `TsunamiEvent`, `TsunamiWarning`, `WaveProfile`, `InundationZone`, `TsunamiDamage` |
| Geography | `Prefecture`, `City` |
| Damage assessment | `DamageReport`, `ShakingDamage`, `FireAfterQuake`, `LandslideRisk`, `NuclearIncident` |

The ontology defines formal object properties (relationships) and data properties (node fields) with XSD types and data source citations for every field.

---

### Graph Schema

**Node types (17):**

| Label | Count |
|-------|-------|
| Earthquake | ~33,875 |
| Prefecture | 47 |
| FaultZone | 9 |
| NuclearFacility | 15 |
| Tsunami | ~180 |
| City | 33 |
| ShakingDamage, TsunamiEvent, InundationZone, LandslideRisk, FireAfterQuake, TsunamiWarning, WaveProfile, TsunamiDamage, NuclearIncident, DamageReport | 3–6 each |

**Key relationships:**

| Relationship | Meaning |
|-------------|---------|
| ORIGINATED_ON | Earthquake → FaultZone |
| TRIGGERED | Earthquake → Tsunami |
| STRUCK | Earthquake → Prefecture |
| INUNDATED | Tsunami → Prefecture |
| WITHIN_50KM_OF | Earthquake → NuclearFacility |
| CONTAINS | Prefecture → NuclearFacility |
| hasShakingDamage / hasFireRisk / hasLandslideRisk / hasNuclearIncident | Earthquake → damage chain nodes |
| causedInundation → hasTsunamiDamage | Tsunami → InundationZone → TsunamiDamage |

**12 vector indexes** using Voyage AI voyage-3 (1024-dim) across all node types.

---

### Enrichment Pipeline

The graph was built in three stages beyond raw USGS ingestion:

**1. GEBCO Sea Floor Depth** — `seaFloorDepthM` added to all 32,976 earthquake nodes using GEBCO 2026 bathymetry. Critical for tsunami inference: a shallow shelf quake and a deep trench quake of identical magnitude produce fundamentally different waves. Vectorised numpy lookup (~30s for ~33k nodes).

**2. NOAA Tsunami Wave Data** — 135 historical tsunami events matched and enriched with measured wave heights (`waveHeightAtShoreM`), fatalities, building damage, and runup counts from the NOAA NCEI Global Historical Tsunami Database.

**3. Fault Type Inference** — `faultType` (subduction / strike-slip / reverse) inferred for all earthquake nodes via Cypher rules based on depth and location. Result: 81% subduction — geologically correct for Japan's four-plate junction.

---

### Perseus Knowledge Graph Enrichment

The OWL ontology was used as an extraction schema for [Lettria Perseus](https://docs.perseus.lettria.net) to extract structured damage chain data from prose disaster reports covering six major events (Tōhoku 2011, Kobe 1995, Noto 2024, Fukushima aftershock 2011, Kumamoto 2016, Tokachi-Oki 2003).

Perseus extracted entities and relationships from natural language, exported as CQL, and migrated to Neo4j Aura — adding 10 new node types (ShakingDamage, TsunamiEvent, InundationZone, LandslideRisk, FireAfterQuake, TsunamiWarning, WaveProfile, TsunamiDamage, NuclearIncident, DamageReport) and 33 City nodes with sub-prefecture granularity.

---

### Agent Tools

**1. Cypher Templates (9 registered)** — cascade trace, compound risk corridors, historical analog finder, nuclear proximity risk, decade pattern analysis, fault zone lethality, the Hamaoka question, region vulnerability score, graph summary.

**2. Text2Cypher** — natural language to Cypher. Ask: "Which prefectures on the Nankai Trough also have nuclear plants?" or "What M7+ earthquakes struck Miyagi in the 2000s?"

**3. Nearest Neighbour Tsunami Inference** — finds the most physically similar historical tsunami events using a weighted Cypher similarity score (magnitude weighted 2×) across sea floor depth, latitude, and magnitude dimensions.

**4. Vector Semantic Search** — 12 Voyage AI voyage-3 embedding indexes for semantic similarity across all node types.

---

### Live Feed

The backend continuously ingests real events: JMA ATOM feed polled every 60 seconds, plus a USGS backfill of the last 24 hours on startup. Events appear on the map within one polling cycle.

---

### Stack

| Layer | Technology |
|-------|-----------|
| Graph database | Neo4j Aura |
| Backend API | FastAPI (Python) |
| Frontend | React + Vite (Cloudflare Pages) |
| Embeddings | Voyage AI voyage-3 (1024-dim) |
| Agent (chat) | Neo4j Aura Agent Builder (GPT-4o) |
| Agent (predict) | Claude Sonnet via Anthropic API |
| Ontology | OWL 2 / Turtle (W3C standard) |
| NLP extraction | Lettria Perseus |

[Launch Live App](https://shindo-earthquake-graph.pages.dev/){:target="_blank" rel="noopener noreferrer"}
