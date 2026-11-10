module

public import DifferentialGeometry.Manifolds.SmoothManifold /- SmoothManifold -/
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic /- Real.sin, π -/

/-!
# Manifold examples

Two planar traces, each carrying the subspace topology from `ℝ²`. The exercises concern the
existence of an abstract smooth `1`-manifold structure on each trace. The proofs are left open.
-/

@[expose] public section

open scoped Real

namespace DifferentialGeometry

/-- The graph of `x ↦ |x|`, for all real `x`, admits a smooth `1`-manifold structure. -/
theorem absTrace_admits_smoothStructure :
    let trace : Set ℝ² := Set.range (fun x : ℝ => !₂[x, |x|])
    Nonempty (SmoothManifold 1 trace) := by
  sorry

/-- The trace of `t ↦ (sin(2t), sin(t))`, for `-π ≤ t ≤ π`, admits no smooth `1`-manifold
structure. -/
theorem figureEightTrace_not_admits_smoothStructure :
    let trace : Set ℝ² :=
      (fun t : ℝ => !₂[Real.sin (2 * t), Real.sin t]) '' Set.Icc (-π) π
    ¬ Nonempty (SmoothManifold 1 trace) := by
  sorry

end DifferentialGeometry
