module

public import DifferentialGeometry.Notation /- ℝ^n -/
public import Mathlib.Topology.Bases /- SecondCountableTopology -/
public import Mathlib.Topology.ContinuousOn /- ContinuousOn -/
public import Mathlib.Topology.Separation.Hausdorff /- T2Space -/

/-!
# Topological manifolds

A topological `n`-manifold is a topological space that is second countable, Hausdorff, and locally
Euclidean of dimension `n` (Lee, Topological Manifolds, p. 39).

`TopologicalSpace M` supplies the topology. The three conditions are the fields of
`IsTopologicalManifold n M`. A coordinate chart is a homeomorphism from an open subset of `M`
onto an open subset of `ℝ^n`.
-/

@[expose] public section

namespace DifferentialGeometry

/-- **Coordinate charts** (Lee, Topological Manifolds, p. 38). A homeomorphism from an open
subset of `M` onto an open subset of `ℝ^n`. -/
structure Chart (n : ℕ) (M : Type*) [TopologicalSpace M] where
  /-- The coordinate map `φ`, used on `U`. -/
  toFun : M → ℝ^n
  /-- The coordinate domain `U ⊆ M`. -/
  U : Set M
  /-- The coordinate domain is open. -/
  open_U : IsOpen U
  /-- The coordinate image `φ(U)` is open. -/
  open_image : IsOpen (toFun '' U)
  /-- The inverse coordinate map `φ⁻¹`, used on `φ(U)`. -/
  inv : ℝ^n → M
  /-- The inverse recovers every point of `U`. -/
  inv_apply : ∀ p ∈ U, inv (toFun p) = p
  /-- The coordinate map is continuous on `U`. -/
  continuous : ContinuousOn toFun U
  /-- The inverse is continuous on `φ(U)`. -/
  continuous_inverse : ContinuousOn inv (toFun '' U)

attribute [coe] Chart.toFun

/-- A chart `φ` can be applied to a point `p` and written `φ p`, as in the books. -/
instance {n : ℕ} {M : Type*} [TopologicalSpace M] : CoeFun (Chart n M) fun _ => M → ℝ^n :=
  ⟨Chart.toFun⟩

/-- **Locally Euclidean of dimension `n`** (Lee, Topological Manifolds, p. 38). Every point has a
coordinate chart into `ℝ^n`. -/
def IsLocallyEuclidean (n : ℕ) (M : Type*) [TopologicalSpace M] : Prop :=
  ∀ p : M, ∃ φ : Chart n M, p ∈ φ.U

/-- **Topological manifolds** (Lee, Topological Manifolds, p. 39). A topological space that is
second countable, Hausdorff, and locally Euclidean of dimension `n`. -/
structure IsTopologicalManifold (n : ℕ) (M : Type*) [TopologicalSpace M] : Prop where
  /-- there is a countable basis of open sets -/
  secondCountable : SecondCountableTopology M
  /-- distinct points have disjoint open neighborhoods -/
  hausdorff : T2Space M
  /-- every point lies in a coordinate domain -/
  locallyEuclidean : IsLocallyEuclidean n M

end DifferentialGeometry
