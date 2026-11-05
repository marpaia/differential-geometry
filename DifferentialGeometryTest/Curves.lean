import DifferentialGeometry

/-!
# Curves

The definitions of curves, used from outside the library the way a downstream file would use them:
the names are reached by opening the namespace, and the notation by opening it as a scope.
-/

open DifferentialGeometry
open scoped DifferentialGeometry

/-- A curve `α` in `ℝ³` is applied to a parameter `t` as `α t`, and its velocity is `deriv α t`. -/
noncomputable example (α : RegularCurve 3) (t : ℝ) : ℝ³ × ℝ³ :=
  (α t, deriv α t)

/-- A simple closed curve is a closed curve, which is a regular curve. -/
example {n : ℕ} (α : SimpleClosedCurve n) : RegularCurve n :=
  α.toRegularCurve

/-- A closed curve repeats with its period. -/
example {n : ℕ} (α : ClosedCurve n) (t : ℝ) : α (t + α.T) = α t :=
  α.periodic t

/-- The hypotheses of the four vertex theorem, a simple closed convex plane curve, are stated
about a `SimpleClosedCurve 2`, with convexity reached through the parent `RegularCurve 2`. -/
example (α : SimpleClosedCurve 2) (_ : α.IsConvex) : RegularCurve 2 :=
  α.toRegularCurve

/-- `J` is a quarter turn counterclockwise: `J(1, 0) = (0, 1)`. -/
example : J !₂[1, 0] = !₂[0, 1] := by
  ext i; fin_cases i <;> simp [J]
