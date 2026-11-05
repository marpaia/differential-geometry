module

public import Mathlib.Analysis.InnerProductSpace.PiL2 /- EuclideanSpace -/

/-!
# Notation

The notation used throughout the library, so that statements read as they do on paper. It is
scoped to the `DifferentialGeometry` namespace: `open scoped DifferentialGeometry` turns it on.

* `ℝ^n`, the model space of an `n`-manifold
* `ℝ²` and `ℝ³`, the parameters of a surface and the space containing it

The inverses `φ⁻¹` and `ψ⁻¹` of charts are declared beside `Chart`, in `TopologicalManifold`.
-/

@[expose] public section

namespace DifferentialGeometry

/-- `ℝ^n`, the model space of an `n`-manifold. Mathlib calls it `EuclideanSpace ℝ (Fin n)`. Its
points are functions from `Fin n = {0, …, n - 1}` to `ℝ`, and `‖·‖` is the Euclidean norm. -/
scoped notation "ℝ^" n:max => EuclideanSpace ℝ (Fin n)

/-- `ℝ²`, the plane of parameters `(u, v)` of a surface. It is the same term as `ℝ^2`. -/
scoped notation "ℝ²" => EuclideanSpace ℝ (Fin 2)

/-- `ℝ³`, the space that contains a surface. It is the same term as `ℝ^3`. -/
scoped notation "ℝ³" => EuclideanSpace ℝ (Fin 3)

end DifferentialGeometry
