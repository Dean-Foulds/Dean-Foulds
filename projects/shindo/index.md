---
layout: default
title: Shindo Japan Seismic Risk Intelligence Graph
---

## Shindo (震度) — Japan Seismic Risk Intelligence Graph

A cascading risk graph connecting earthquakes, fault zones, tsunamis, nuclear facilities, and prefectures — built for the **Neo4j Aura Agent Hackathon**. Named after 震度, Japan's official seismic intensity scale, because this agent reasons about local impact and cascading consequences, not just raw magnitude at the source.

[Launch Live App](https://shindo-earthquake-graph.pages.dev/){:target="_blank" rel="noopener noreferrer"} · [Neo4j Hackathon Entry](https://community.neo4j.com/t/start-here-register-get-aura-credits-aura-agent-hackathon/77191){:target="_blank" rel="noopener noreferrer"}

---

### The Core Idea

Japan's disasters cascade: Fault rupture → Ground shaking → Tsunami → Prefecture inundation → Nuclear facility exposure. A CSV stores events. A graph stores the chain — and an AI agent can traverse it in a single query.

---

### Dataset

| Source | Detail |
|--------|--------|
| USGS Earthquake Hazards Program | ~20,000 M4.0+ events, 1950–2024 |
| IAEA PRIS Nuclear Reactor Registry | 15 nuclear facilities |
| JMA Fault Zone Data | 9 major fault zones |
| Japan Prefecture Reference | 47 prefectures |

---

### Graph Schema

| Relationship | Meaning |
|-------------|---------|
| ORIGINATED_ON | Earthquake → FaultZone |
| TRIGGERED | Earthquake → Tsunami |
| STRUCK | Earthquake → Prefecture |
| INUNDATED | Tsunami → Prefecture |
| WITHIN_50KM_OF | Earthquake → NuclearFacility |
| CONTAINS | Prefecture → NuclearFacility |

---

### Three Agent Tools

**1. Cypher Templates** — pre-built queries for cascade traces from fault zone to nuclear exposure.

**2. Text2Cypher** — natural language to Cypher. Ask: "Which prefectures on the Nankai Trough also have nuclear plants?"

**3. Similarity Search** — finds historical earthquake analogues by magnitude, depth, and location using Cypher and Voyage AI vector embeddings.

---

### Stack

| Layer | Technology |
|-------|-----------|
| Graph database | Neo4j Aura |
| Backend API | FastAPI (Railway) |
| Frontend | React + Vite (Cloudflare Pages) |
| Embeddings | Voyage AI voyage-3 |
| Agent | Neo4j Aura Agent API |

[Launch Live App](https://shindo-earthquake-graph.pages.dev/){:target="_blank" rel="noopener noreferrer"}
