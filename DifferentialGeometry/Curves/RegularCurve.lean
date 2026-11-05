module

public import DifferentialGeometry.Notation /- ℝ^n -/
public import Mathlib.Analysis.Calculus.ContDiff.Defs /- ContDiffOn, ∞ -/
public import Mathlib.Analysis.Calculus.Deriv.Basic /- deriv -/
public import Mathlib.Order.Interval.Set.Defs /- Set.OrdConnected -/

/-!
# Regular curves

A *regular curve* in `ℝⁿ` is a smooth map `α : I → ℝⁿ` from an open interval `I ⊆ ℝ` whose
velocity `α'(t)` never vanishes. The definition has three parts.

1. `I` is an open interval `(a, b)`, with `a = -∞` and `b = ∞` allowed.
2. `α` is smooth.
3. `α'(t) ≠ 0` for every `t ∈ I`.

Parts 1 and 2 make `α` a *parametrized differentiable curve* (do Carmo, Section 1-2, Definition 1;
Pressley, Definition 1.1.1), where do Carmo's "differentiable" means `C^∞`. Part 3 is *regularity*
(do Carmo, Section 1-3; Pressley, Definition 1.2.2), and `α'(t)` is the *tangent vector* or
*velocity* at `t`. The curve is the map `α`, not its image: two maps with the same image are two
curves, and the image of `α` is its *trace*.

An open interval is an open subset of `ℝ` that, with any two of its points, contains every point
between them. Those are the sets `Set.Ioo a b`, `Set.Ioi a`, `Set.Iio b`, and `ℝ` itself, together
with `∅`. do Carmo takes `n = 3`; Pressley allows any `n`, and so does the definition here.
-/

@[expose] public section

open scoped ContDiff

namespace DifferentialGeometry

/-- **Regular curves** (do Carmo, Section 1-2, Definition 1, and Section 1-3; Pressley,
Definitions 1.1.1 and 1.2.2). A smooth map `α` from an open interval `I ⊆ ℝ` into `ℝⁿ` whose
velocity `α'(t)` is nonzero at every `t ∈ I`. -/
structure RegularCurve (n : ℕ) where
  /-- `α(t)` -/
  toFun : ℝ → ℝ^n
  /-- `I ⊆ ℝ`, the interval of parameters -/
  I : Set ℝ
  /-- `I` is open -/
  open_I : IsOpen I
  /-- `I` is an interval: with any two of its points it contains every point between them -/
  interval : I.OrdConnected
  /-- `α` is smooth -/
  smooth : ContDiffOn ℝ ∞ toFun I
  /-- `α'(t) ≠ 0` for every `t ∈ I`, where `deriv α t` is the velocity `α'(t)` -/
  regular : ∀ t ∈ I, deriv toFun t ≠ 0

attribute [coe] RegularCurve.toFun

/-- A curve `α` can be applied to a parameter `t` and written `α t`, as in the books. -/
instance {n : ℕ} : CoeFun (RegularCurve n) fun _ => ℝ → ℝ^n :=
  ⟨RegularCurve.toFun⟩

end DifferentialGeometry
