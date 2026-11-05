module

public import DifferentialGeometry.Notation /- ℝ^n -/
public import Mathlib.Topology.Bases /- SecondCountableTopology -/
public import Mathlib.Topology.ContinuousOn /- ContinuousOn -/
public import Mathlib.Topology.Separation.Hausdorff /- T2Space -/

/-!
# Topological manifolds

A manifold is a space that looks locally like `ℝ^n`. The definition has two branches. The
*topological manifold*, here, supplies local coordinates and controls the topology of the whole
space. The *smooth structure*, in `SmoothManifold`, chooses coordinates whose changes support
calculus. The topological branch has three parts (Lee, Topological Manifolds, Chapter 2).

1. `M` is a topological space.
2. Every point of `M` lies in the domain of a coordinate chart.
3. `M` is Hausdorff and second countable.

Part 1 is Mathlib's `TopologicalSpace M`: a choice of the *open sets* of `M`, closed under unions
and finite intersections. An *open neighborhood* of `p` is an open set containing `p`. A subset of
`ℝ^N` carries the *subspace topology*, whose open sets are its intersections with open sets of
`ℝ^N`, which is Mathlib's topology on a subtype.

Part 2 is the *coordinate chart* `(U, φ)` (p. 38). `U ⊆ M` is open, the *coordinate domain*, and
`φ`, the *coordinate map*, is a homeomorphism from `U` onto an open set `V ⊆ ℝ^n`: a continuous
bijection whose inverse `φ⁻¹` is continuous, so that for `A ⊆ U`, `A` is open in `M` exactly when
`φ(A)` is open in `ℝ^n`. The coordinates of `p ∈ U` are the `n` numbers `φ(p)`. The space is
*locally Euclidean of dimension `n`* if every point belongs to a coordinate domain. A coordinate
domain containing `p` is a *coordinate neighborhood* of `p`.

Part 3 controls how the coordinate neighborhoods fit into the whole space. `M` is *Hausdorff* if
distinct points have disjoint open neighborhoods, Mathlib's `T2Space M`. The line with two origins
is locally Euclidean but its two origins cannot be separated. `M` is *second countable* if it has
a countable *basis*, a collection of open sets of which every open set is a union, Mathlib's
`SecondCountableTopology M`. The disjoint union of uncountably many lines is locally Euclidean and
Hausdorff but needs uncountably many basic sets. A subspace of `ℝ^N` inherits both conditions,
which is why the definition of a surface did not need them.

An *`n`-dimensional topological manifold* is a second countable Hausdorff space that is locally
Euclidean of dimension `n` (p. 39). The dimension is determined by the space (Theorem 2.55,
invariance of dimension), and the empty space is a manifold of every dimension.
-/

@[expose] public section

namespace DifferentialGeometry

/-- **Coordinate charts** (Lee, Topological Manifolds, p. 38). A homeomorphism `φ` from an open set
`U ⊆ M` onto an open set `V ⊆ ℝ^n`: a continuous map with a continuous inverse `φ⁻¹`. -/
structure Chart (n : ℕ) (M : Type*) [TopologicalSpace M] where
  /-- `φ`, the coordinate map -/
  toFun : M → ℝ^n
  /-- `U ⊆ M`, the coordinate domain -/
  U : Set M
  /-- `U` is open -/
  open_U : IsOpen U
  /-- `φ(U) = V` is open in `ℝ^n`, where `φ '' U` is Mathlib's notation for the image `φ(U)` -/
  open_image : IsOpen (toFun '' U)
  /-- `φ⁻¹`, the inverse of `φ`. Its values off `V` are irrelevant. -/
  inv : ℝ^n → M
  /-- `φ⁻¹(φ(p)) = p` for `p ∈ U`, so `φ` is one-to-one on `U` -/
  inv_apply : ∀ p ∈ U, inv (toFun p) = p
  /-- `φ` is continuous -/
  continuous : ContinuousOn toFun U
  /-- `φ⁻¹` is continuous -/
  continuous_inverse : ContinuousOn inv (toFun '' U)

attribute [coe] Chart.toFun

/-- A chart `φ` can be applied to a point `p` and written `φ p`, as in the books. -/
instance {n : ℕ} {M : Type*} [TopologicalSpace M] : CoeFun (Chart n M) fun _ => M → ℝ^n :=
  ⟨Chart.toFun⟩

/-! ## The inverse of a chart

Lean's `⁻¹` belongs to the `Inv` class, whose inverse has the same type as its argument, and the
inverse of a chart is a function, not a chart. So, as with `σᵤ` for the patch `σ`, each of the
following is notation for the inverse of whatever is named `φ` or `ψ` where it is used, which
throughout this library are the charts. Turning off hygiene is what lets the notation refer to
those names. The unexpander prints the inverses back in the same notation. -/

set_option hygiene false in
/-- `φ⁻¹`, the inverse of the chart `φ` -/
scoped notation "φ⁻¹" => Chart.inv φ

set_option hygiene false in
/-- `ψ⁻¹`, the inverse of the chart `ψ` -/
scoped notation "ψ⁻¹" => Chart.inv ψ

open Lean PrettyPrinter in
/-- Prints `Chart.inv φ` as `φ⁻¹` and `Chart.inv ψ` as `ψ⁻¹` -/
@[app_unexpander Chart.inv] meta def unexpandChartInv : Unexpander
  | `($_ $f:ident) =>
    if f.getId == `φ then `(φ⁻¹) else if f.getId == `ψ then `(ψ⁻¹) else throw ()
  | _ => throw ()

/-- **Locally Euclidean of dimension `n`** (Lee, Topological Manifolds, p. 38). Every point lies in
the domain of a coordinate chart. -/
def IsLocallyEuclidean (n : ℕ) (M : Type*) [TopologicalSpace M] : Prop :=
  ∀ p : M, ∃ φ : Chart n M, p ∈ φ.U

/-- **Topological manifolds** (Lee, Topological Manifolds, p. 39). A second countable Hausdorff
space that is locally Euclidean of dimension `n`. The topology is the instance
`TopologicalSpace M`. -/
structure IsTopologicalManifold (n : ℕ) (M : Type*) [TopologicalSpace M] : Prop where
  /-- every point lies in a coordinate domain -/
  locallyEuclidean : IsLocallyEuclidean n M
  /-- distinct points have disjoint open neighborhoods -/
  hausdorff : T2Space M
  /-- there is a countable basis of open sets -/
  secondCountable : SecondCountableTopology M

end DifferentialGeometry
