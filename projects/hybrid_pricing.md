---
layout: default
title: Hybrid Risk-Adjusted Pricing Model
---

# Hybrid Risk-Adjusted Pricing Model

## Abstract

This study presents a Hybrid Risk-Adjusted Pricing Model designed to improve the accuracy and interpretability of sale price predictions for surplus and life-limited aircraft parts, combined with a high-performance quantitative asset valuation model using JAX.

**Phase 1 - Risk Quantification (JAX):**  
A custom Conceptual Risk Model is implemented using Python and JAX. Total Risk Score ($R$) is computed from TSN, CSN, TSR, TL metrics:

$$
R = \sigma\left( \sum_i w_i X_i - T \right)
$$

**Phase 2 - Price Prediction (XGBoost / Regression):**  
The calculated Total Risk Score ($R$) is passed as a crucial feature to XGBoost, Random Forest, and LSTM regressors to predict market-adjusted sale prices.

**Phase 3 - High-Performance Valuation:**  
A deep neural network in JAX/Flax estimates Fair Market Value (FMV) using JIT compilation and automatic differentiation.

---

## Introduction

### Background and Motivation

The global market for surplus and used aircraft parts is highly sensitive to component condition. Mispricing due to inaccurate risk assessment can lead to financial losses or regulatory issues. Current models often rely on generalised historical averages, failing to account for Remaining Useful Life (RUL) metrics. A reliable system is needed to convert complex operational data into a quantifiable risk factor.

### Problem Statement

The challenge is to translate operational data (TSN, CSN, TL, TSR) into a measurable Total Risk Score ($R$) for use in price prediction. The goal is to integrate this score into XGBoost, LSTM, or other ML frameworks for superior prediction accuracy.

### Hypothesis

Incorporating the Total Risk Score ($R$) derived from the JAX Conceptual Risk Model into ML models will achieve lower RMSE and MAE than models using only raw operational data.

---

## Data Acquisition and Understanding

### Data Sources

- **ILS Inventory Data (External)**: Historical market availability; lacks transparency.  
- **Snowflake Auto-Pricing Project**: Short-term pricing brackets; data accuracy limited.  
- **AJW Internal Data**: Cost management, sales quotes, inventory metrics.

### Data Description

Merged data contains top 200 selling part numbers. Tables, operational metrics, and FMV quotes are included.

| Attribute        | Description          |
|-----------------|--------------------|
| Number of samples | [value]           |
| Number of features| [value]           |
| Target variable  | FMV price           |
| Time period      | [dates]            |

---

## Feature Engineering

### Total Risk Score (Conceptual Risk Model)

$$
R = \sigma\left( \sum_{i=1}^{n} w_i \cdot X_i - T \right)
$$

Where:  
- $R$: Total Risk Score ($[0,1]$)  
- $\sigma(z)$: Sigmoid function  
- $X_i$: Normalised risk factors  
- $w_i$: Learned weights  
- $T$: Threshold parameter  

---

## JAX Model Implementation

```python
import jax
import flax.linen as nn
from jax import numpy as jnp

class ValuationModel(nn.Module):
    @nn.compact
    def __call__(self, x):
        x = nn.Dense(features=128)(x)
        x = nn.swish(x)
        x = nn.Dense(features=64)(x)
        x = nn.swish(x)
        x = nn.Dense(features=32)(x)
        x = nn.swish(x)
        x = nn.Dense(features=1)(x)
        return jnp.squeeze(x)

key = jax.random.PRNGKey(42)
model = ValuationModel()
params = model.init(key, jnp.ones([1, 10]))['params']