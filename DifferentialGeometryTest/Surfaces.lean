import DifferentialGeometry

/-!
# Surfaces

The definition of a surface, used from outside the library the way a downstream file would use
it: the names are reached by opening the namespace, and the notation by opening it as a scope.
-/

open DifferentialGeometry
open scoped DifferentialGeometry

/-- A regular surface is a smooth `2`-manifold. -/
example {S : Set ℝ³} (surface : RegularSurface S) : SmoothManifold 2 S :=
  surface.toSmoothManifold

/-- In a chart `φ` of a surface, the parametrization `x = φ⁻¹` sends parameters in `ℝ²` to points
of `ℝ³`. -/
example {S : Set ℝ³} (φ : Chart 2 S) (q : ℝ²) : φ.parametrization q = (φ⁻¹ q : ℝ³) :=
  rfl
