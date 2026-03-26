---
layout: default
title: Machine Learning MCMC Model
---
## Machine Learning MCMC Model

Full MCMC model training pipeline with continuous retraining and visualisations. Version 7 implements a dual-model strategy: XGBoost gradient-boosted regression achieving test MAE of $4,584 and MdAPE of 5.2%, alongside MCMC NUTS hierarchical Bayesian regression via NumPyro with per-PN random effects achieving MAE of $4,238 with full posterior predictive intervals.

[Download Report v7](ml_report_v7.pdf)

[View Formal Lean Proofs](lean_proofs/pricing_guardrails.lean)
