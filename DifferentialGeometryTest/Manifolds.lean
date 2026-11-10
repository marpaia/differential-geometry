import DifferentialGeometry

/-!
# Manifolds

The definitions of `DifferentialGeometry.Manifolds`, used from outside the library.
-/

open DifferentialGeometry
open scoped DifferentialGeometry

/-- The identity chart on `ℝ^n`, with `U = V = ℝ^n` and `φ(x) = x` -/
def euclideanChart (n : ℕ) : Chart n (ℝ^n) where
  toFun := id
  U := Set.univ
  open_U := isOpen_univ
  open_image := by simp
  inv := id
  inv_apply _ _ := rfl
  continuous := continuousOn_id
  continuous_inverse := continuousOn_id

/-- `ℝ^n` is a topological `n`-manifold. -/
example (n : ℕ) : IsTopologicalManifold n (ℝ^n) where
  secondCountable := inferInstance
  hausdorff := inferInstance
  locallyEuclidean p := ⟨euclideanChart n, Set.mem_univ p⟩

/-- `ℝ^2` is `ℝ²`. -/
example : Chart 2 ℝ² = Chart 2 (ℝ^2) := rfl

/-- The inverse of a chart named `φ` is written `φ⁻¹`, in statements and in goals. -/
example {n : ℕ} {M : Type*} [TopologicalSpace M] (φ ψ : Chart n M) :
    φ.transition ψ = ψ ∘ φ⁻¹ := by
  guard_target =ₛ φ.transition ψ = ψ ∘ φ⁻¹
  rfl

/-- A smooth manifold is specified by a topological manifold and a covering smooth atlas. -/
example {n : ℕ} {M : Type*} [TopologicalSpace M] (manifold : IsTopologicalManifold n M)
    {A₀ : Set (Chart n M)} (smooth : IsSmoothAtlas A₀) : SmoothManifold n M :=
  SmoothManifold.ofAtlas manifold smooth
