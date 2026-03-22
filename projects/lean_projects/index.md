---
layout: default
title: Lean 4 Theorem Proving Projects
---

## Lean 4 Theorem Proving Projects

Formal mathematics verified using **Lean 4** and the **[Mathlib4](https://github.com/leanprover-community/mathlib4)** library — one of the largest formal mathematics libraries in existence. Every theorem on this page is machine-verified: no logical gaps, no hand-waving, just proof.

[View all source code on GitHub](https://github.com/Dean-Foulds/lean_projects){:target="_blank" rel="noopener noreferrer"}

---

### Aircraft Parts Volatility Index (APVI)

Formal proofs underpinning the **APVI** composite risk metric, combining equity market volatility (XAR ETF) with Producer Price Index volatility for the aerospace sector.

| Theorem | Statement |
|---------|-----------|
| `is_spike` | A value constitutes a spike when it exceeds mean + k·σ |
| `spike_monotone_k` | Raising threshold k makes spikes harder to trigger |
| `realized_vol_nonneg` | Realised volatility is always non-negative |
| `apvi_nonneg` | The composite APVI index is always non-negative |
| `apvi_le_max` | APVI is bounded above by its most extreme component |
| `apvi_spike` | Bilateral spikes in equity and PPI imply a composite APVI spike |
| `mean_bounded_by_max` | Rolling window mean is bounded by the window maximum |

[View Source](https://github.com/Dean-Foulds/lean_projects/blob/main/LeanProjects/volatility_theory/volatility_theory.lean){:target="_blank" rel="noopener noreferrer"} · [Download PDF Proofs](https://github.com/Dean-Foulds/lean_projects/raw/main/LeanProjects/volatility_theory/volatility_theory.pdf){:download}

---

### Market Volatility Propagation — War Economy

Advanced real analysis and topology proofs formalising how financial market volatility propagates during geopolitical stress events. Uses Mathlib's metric space, topological space, and uniform space hierarchies.

| Theorem | Mathematical Tool | Statement |
|---------|------------------|-----------|
| `volatility_propagation_continuous` | Composition | Smooth shocks propagate smoothly between markets |
| `volatility_attains_max` | Extreme Value Theorem | Worst-case volatility always exists on a compact market |
| `lipschitz_propagation_bounds_shock` | Lipschitz analysis | K < 1 absorbs shocks; K > 1 amplifies them |
| `propagation_uniformly_continuous` | Uniform continuity | A single threshold controls propagation across all states |
| `volatility_sequence_has_convergent_subseq` | Bolzano-Weierstrass | Markets always find convergent volatility patterns |
| `equilibrium_volatility_exists` | Banach Fixed Point | A unique post-crisis equilibrium volatility level exists |
| `composite_propagation_continuous` | Composition | Multi-hop propagation chains (oil → equity → credit) are well-behaved |
| `volatility_spread_pos` | Order theory | Asymmetric crises produce measurable contagion gaps |
| `crisis_threshold_exists` | Intermediate Value Theorem | Every crisis has a mathematically precise tipping point |
| `spike_preimage_open` | Topology | Crisis-triggering market states form an open set |

[View Source](https://github.com/Dean-Foulds/lean_projects/blob/main/LeanProjects/war_economy/volatility_propagation.lean){:target="_blank" rel="noopener noreferrer"}

---

### Analysis & Calculus

Foundational theorems in real analysis using Mathlib's `Real` library.

| Theorem | Statement |
|---------|-----------|
| `abs_nonneg'` | The absolute value of any real number is non-negative |
| `sq_nonneg'` | The square of any real number is non-negative |
| `triangle_ineq` | Triangle inequality: \|a + b\| ≤ \|a\| + \|b\| |
| `pos_ne_zero` | If x > 0 then x ≠ 0 |

[View Source](https://github.com/Dean-Foulds/lean_projects/blob/main/LeanProjects/analysis_basics.lean){:target="_blank" rel="noopener noreferrer"}

---

### Logic & Type Theory

Proofs of fundamental logical laws using Lean's classical logic and Mathlib's `Logic` library.

| Theorem | Statement |
|---------|-----------|
| `modus_ponens` | If P and P → Q then Q |
| `double_neg` | Double negation elimination: ¬¬P → P |
| `de_morgan` | De Morgan's law: ¬(P ∨ Q) → ¬P ∧ ¬Q |
| `and_comm'` | Conjunction commutativity: P ∧ Q → Q ∧ P |

[View Source](https://github.com/Dean-Foulds/lean_projects/blob/main/LeanProjects/logic_basics.lean){:target="_blank" rel="noopener noreferrer"}

---

### Combinatorics

Proofs about finite sets and summation using Mathlib's `Finset` library.

| Theorem | Statement |
|---------|-----------|
| `sum_range` | Sum of first n natural numbers: 2·Σi = n·(n+1) |
| `card_nonneg'` | Every finite set has non-negative cardinality |
| `empty_card` | The empty set has cardinality zero |

[View Source](https://github.com/Dean-Foulds/lean_projects/blob/main/LeanProjects/combinatorics_basics.lean){:target="_blank" rel="noopener noreferrer"}

---

### Linear Algebra

Proofs about vector spaces over ℝ using Mathlib's `Pi` and `LinearAlgebra` libraries.

| Theorem | Statement |
|---------|-----------|
| `vec_add_comm` | Vector addition is commutative: u + v = v + u |
| `smul_add'` | Scalar multiplication distributes over vector addition |
| `zero_add_vec` | Zero vector is the additive identity: 0 + v = v |

[View Source](https://github.com/Dean-Foulds/lean_projects/blob/main/LeanProjects/linear_algebra_basics.lean){:target="_blank" rel="noopener noreferrer"}

---

*All proofs verified by the Lean 4 kernel. Source code available at [github.com/Dean-Foulds/lean_projects](https://github.com/Dean-Foulds/lean_projects){:target="_blank" rel="noopener noreferrer"}.*
