---
layout: default
title: 4-Stage Pipelined Binary Perceptron
---

## 4-Stage Pipelined Binary Perceptron

A hardware implementation of the McCulloch-Pitts neuron — the 1943 mathematical model that started the entire field of neural networks — built as a 4-stage pipelined digital circuit on a **Tiny Tapeout** tile. No CPU, no software, no operating system. Just logic gates switching at the speed of electrons.

The perceptron classifies an 8-bit input vector every clock cycle after an initial 4-cycle warmup latency.

### How it works

The circuit computes a weighted sum of binary inputs and compares it to a programmable threshold:
```
y = 1  if  Σ(wi · xi) >= θ
y = 0  otherwise
```

Since all values are binary, multiplication reduces to a logical AND — the simplest possible gate on silicon.

### The 4 Pipeline Stages

**Stage 1 — Input Latch:** 8 input bits are frozen into flip-flops on the rising clock edge.

**Stage 2 — AND Array:** Each input bit is ANDed with its corresponding weight bit in parallel.

**Stage 3 — Adder Tree:** Eight 0/1 results are summed using a tree of half-adders across 3 levels, producing a 4-bit count from 0–8.

**Stage 4 — Threshold Comparator:** If sum >= θ, the neuron fires (fire = 1). This is the classification decision.

After the 4-cycle warmup, a new result is produced on every single clock tick.

### Why this is genuinely AI

This is the fundamental atom of machine intelligence. Every modern AI model — from GPT to image classifiers — is built from billions of these exact computations, implemented here directly in silicon.

[View on GitHub](https://github.com/Dean-Foulds/ttsky-wokwi-template){:target="_blank" rel="noopener noreferrer"}

[Tiny Tapeout](https://tinytapeout.com){:target="_blank" rel="noopener noreferrer"}
