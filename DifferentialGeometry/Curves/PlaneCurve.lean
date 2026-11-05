module

public import DifferentialGeometry.Curves.RegularCurve /- RegularCurve -/
public import Mathlib.Analysis.InnerProductSpace.PiL2 /- !₂[x, y], ⟪v, w⟫ on ℝ² -/

/-!
# Plane curves

A *plane curve* is a regular curve in `ℝ²`, a `RegularCurve 2`. The plane has one thing the other
`ℝⁿ` do not: a vector can be rotated a quarter turn, `J(x, y) = (-y, x)`, so every nonzero `v` has
a distinguished normal `Jv` and a line has a left side and a right side. That is what gives plane
curves a signed curvature, and what makes the following definition possible.

A plane curve is *convex* if for every `t` its trace lies on one side of the tangent line at
`α(t)`, the line through `α(t)` in the direction `α'(t)` (do Carmo, Section 1-7). A point `α(s)`
is to the left of that line when `⟪α(s) - α(t), J α'(t)⟫ > 0` and to the right when it is `< 0`,
so the condition is that this inner product has one sign for all `s`. do Carmo states this for a
regular plane curve that is not necessarily closed, and so does the definition here. Pressley's
form, that the interior of a simple closed curve is a convex set, needs the Jordan curve theorem
to state, and agrees with do Carmo's for simple closed curves.

A circle and an ellipse are convex. A figure eight is not, and neither is a limaçon with an inner
loop.
-/

@[expose] public section

open scoped RealInnerProductSpace

namespace DifferentialGeometry

/-- `Jv`, the vector `v ∈ ℝ²` rotated a quarter turn counterclockwise: `J(x, y) = (-y, x)`. -/
def J (v : ℝ²) : ℝ² :=
  !₂[-v 1, v 0]

namespace RegularCurve

variable (α : RegularCurve 2)

/-- **Convex curves** (do Carmo, Section 1-7). For every `t ∈ I`, the trace of `α` lies on one
side of the tangent line at `α(t)`: `⟪α(s) - α(t), J α'(t)⟫` has one sign for all `s ∈ I`. -/
def IsConvex : Prop :=
  ∀ t ∈ α.I,
    (∀ s ∈ α.I, 0 ≤ ⟪α s - α t, J (deriv α t)⟫) ∨ (∀ s ∈ α.I, ⟪α s - α t, J (deriv α t)⟫ ≤ 0)

end RegularCurve

end DifferentialGeometry
