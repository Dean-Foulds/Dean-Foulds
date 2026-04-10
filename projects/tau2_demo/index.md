---
layout: default
title: τ²-bench Demo — LLM Reliability Evaluation
---

## τ²-bench — LLM Agent Reliability Evaluation

An implementation of the τ²-bench framework: a system for measuring how reliably LLM agents follow policy under repeated, adversarial testing. Built as a Flask web app with live conversation streaming and Pass^k reliability scoring across three customer service domains.

---

### What is Pass^k?

Single-run accuracy (`Pass^1`) overstates reliability. τ²-bench uses `Pass^k` — the probability that an agent succeeds on *every one* of k independent trials — to expose brittleness that a one-shot test misses.

```
Pass^k = p^k   where p = single-trial success probability

p = 0.80 → Pass^8 ≈ 17%   (looks fine, is actually brittle)
p = 0.95 → Pass^8 ≈ 66%   (genuinely reliable)
```

The gap between `Pass^1` and `Pass^k` is the measure of a model's true reliability under production conditions.

---

### Domains

| Domain | Tasks | Tools |
|--------|-------|-------|
| ✈ Airline | 5 | 5 |
| ◻ Retail | 4 | 5 |
| ◈ Telecom | 3 | 5 |

Each domain has a policy document, a tool schema, and a set of tasks ranging from straightforward requests to adversarial customers designed to push the agent off-policy.

---

### Architecture

An **Agent LLM** plays the customer service agent with access to domain tools and policy. A **User Simulator LLM** generates realistic, sometimes adversarial, customer behaviour. Each task runs for k trials. The evaluator scores each trial and aggregates Pass^k.

```
Agent LLM  ←──tools + policy──┐
     ↕  conversation           │
User LLM   ←──user goal───────┘
     ↓
Evaluator → Pass^k score
```

---

[View Demo](demo.html){:target="_blank" rel="noopener noreferrer"}  &nbsp;·&nbsp;  [View Talk](tau2_bench_talk.html){:target="_blank" rel="noopener noreferrer"}  &nbsp;·&nbsp;  [Paper (arXiv)](https://arxiv.org/pdf/2406.12045){:target="_blank" rel="noopener noreferrer"}  &nbsp;·&nbsp;  [GitHub](https://github.com/Dean-Foulds/tau2_demo){:target="_blank" rel="noopener noreferrer"}
