module

public import DifferentialGeometry.Curves.RegularCurve /- RegularCurve -/
public import Mathlib.Algebra.Ring.Periodic /- Function.Periodic -/
public import Mathlib.Data.Set.Operations /- Set.InjOn -/
public import Mathlib.Order.Interval.Set.Defs /- Set.Ico -/

/-!
# Closed curves

A *closed curve* is a regular curve that comes back to where it started and keeps going: it is
defined on all of `ℝ` and repeats with a *period* `T > 0`, so that `α(t + T) = α(t)` for every
`t`. A *simple closed curve* is a closed curve with no self-intersections: on one period `[0, T)`
it is one-to-one, so the only way `α(s) = α(t)` is for `s` and `t` to differ by a multiple of `T`.

This is Pressley's definition (Definition 3.1.1 and Section 3.1). do Carmo instead takes a regular
curve `α : [a, b] → ℝ³` on a closed interval with `α` and all its derivatives agreeing at `a` and
`b` (Section 1-7). The two agree: such an `α` extends to a periodic curve on `ℝ` with period
`b - a`, and conversely a periodic curve restricted to `[0, T]` is closed in do Carmo's sense.
Pressley's form is the one taken here because the interval of a regular curve is open, and `ℝ`
is an open interval while `[a, b]` is not.

The circle `α(t) = (cos t, sin t)` is a simple closed curve with period `2π`. A figure eight is
closed but not simple.
-/

@[expose] public section

namespace DifferentialGeometry

/-- **Closed curves** (Pressley, Definition 3.1.1; do Carmo, Section 1-7). A regular curve on all
of `ℝ` that repeats with period `T > 0`. -/
structure ClosedCurve (n : ℕ) extends RegularCurve n where
  /-- `T`, the period -/
  T : ℝ
  /-- `T > 0` -/
  pos : 0 < T
  /-- `I = ℝ` -/
  I_univ : I = Set.univ
  /-- `α(t + T) = α(t)` for every `t` -/
  periodic : Function.Periodic toFun T

/-- A closed curve `α` can be applied to a parameter `t` and written `α t`, as in the books. -/
instance {n : ℕ} : CoeFun (ClosedCurve n) fun _ => ℝ → ℝ^n :=
  ⟨fun α => α.toFun⟩

/-- **Simple closed curves** (Pressley, Section 3.1; do Carmo, Section 1-7). A closed curve with
no self-intersections. -/
structure SimpleClosedCurve (n : ℕ) extends ClosedCurve n where
  /-- `α` is one-to-one on one period `[0, T)` -/
  oneToOne : Set.InjOn toFun (Set.Ico 0 T)

/-- A simple closed curve `α` can be applied to a parameter `t` and written `α t`, as in the
books. -/
instance {n : ℕ} : CoeFun (SimpleClosedCurve n) fun _ => ℝ → ℝ^n :=
  ⟨fun α => α.toFun⟩

end DifferentialGeometry
