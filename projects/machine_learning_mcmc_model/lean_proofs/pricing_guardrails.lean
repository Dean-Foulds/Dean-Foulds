import Mathlib

/-!
# Aircraft Parts Pricing Guardrails — Formal Proofs
## Hybrid XGBoost & MCMC NUTS Pricing Pipeline (Version 7)
-/

def above_bracket_flag (pred upper : ℝ) : Prop := pred > 1.2 * upper

theorem above_bracket_monotone (pred₁ pred₂ upper : ℝ)
    (h : pred₁ ≤ pred₂) (hflag : above_bracket_flag pred₁ upper) :
    above_bracket_flag pred₂ upper := by
  unfold above_bracket_flag at *; linarith

def below_bracket_filter (price lower : ℝ) : Prop := price < lower - 2000

theorem below_bracket_filter_monotone (p₁ p₂ lower : ℝ)
    (h : p₂ ≤ p₁) (hfail : below_bracket_filter p₁ lower) :
    below_bracket_filter p₂ lower := by
  unfold below_bracket_filter at *; linarith

theorem filter_threshold_lt_lower (lower : ℝ) : lower - 2000 < lower := by linarith

def below_bracket_prediction_flag (pred lower : ℝ) : Prop := pred < 0.8 * lower

theorem below_bracket_pred_monotone (pred₁ pred₂ lower : ℝ)
    (h : pred₁ ≤ pred₂) (hflag : below_bracket_prediction_flag pred₁ lower) :
    below_bracket_prediction_flag pred₂ lower := by
  unfold below_bracket_prediction_flag at *; linarith

theorem disagreement_abs_symm (xgb nuts : ℝ) :
    |xgb - nuts| = |nuts - xgb| := abs_sub_comm xgb nuts

theorem log_transform_preserves_order (a b : ℝ)
    (ha : 0 < a) (hb : 0 < b) (h : b < a) :
    Real.log (1 + b) < Real.log (1 + a) := by
  apply Real.log_lt_log <;> linarith

theorem credible_interval_nonneg (p5 p95 : ℝ) (h : p5 < p95) :
    0 < p95 - p5 := sub_pos.mpr h

def bracket_midpoint (lower upper : ℝ) : ℝ := (lower + upper) / 2

theorem midpoint_between_bounds (lower upper : ℝ) (h : lower < upper) :
    lower < bracket_midpoint lower upper ∧ bracket_midpoint lower upper < upper := by
  constructor <;> unfold bracket_midpoint <;> linarith

theorem partial_pooling_shrinks (alpha lambda : ℝ)
    (hl : 0 < lambda) (hl1 : lambda < 1) :
    |lambda * alpha| < |alpha| ∨ alpha = 0 := by
  by_cases h : alpha = 0
  · right; exact h
  · left
    rw [abs_mul, abs_of_pos hl]
    nlinarith [abs_pos.mpr h, abs_nonneg alpha]

def price_bracket_ratio (price midpoint : ℝ) : ℝ := price / midpoint

theorem ratio_pos_of_pos (price midpoint : ℝ)
    (hp : 0 < price) (hm : 0 < midpoint) :
    0 < price_bracket_ratio price midpoint := div_pos hp hm

theorem guardrail_covers_outliers (pred lower upper : ℝ)
    (hlu : lower < upper)
    (hout : pred < 0.8 * lower ∨ pred > 1.2 * upper) :
    below_bracket_prediction_flag pred lower ∨ above_bracket_flag pred upper := by
  cases hout with
  | inl h => left; unfold below_bracket_prediction_flag; exact h
  | inr h => right; unfold above_bracket_flag; exact h
