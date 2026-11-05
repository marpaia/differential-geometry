module

public import DifferentialGeometry.Manifolds.SmoothManifold /- SmoothManifold -/
public import DifferentialGeometry.Notation /- ℝ², ℝ³ -/
public import Mathlib.Analysis.Calculus.ContDiff.Defs /- ContDiffOn, ∞ -/
public import Mathlib.Analysis.Calculus.FDeriv.Defs /- fderiv -/

/-!
# Regular surfaces

A *regular surface* is a set `S ⊆ ℝ³` that is a smooth `2`-manifold in the subspace topology and
sits smoothly in `ℝ³`. The definition has three parts.

1. `S` is a smooth `2`-manifold.
2. In every smooth chart `(U, φ)`, the map `x = φ⁻¹ : φ(U) → ℝ³` is smooth.
3. In every smooth chart, the derivative `dx_q` is one-to-one at every parameter `q ∈ φ(U)`.

The map `x` in parts 2 and 3 is the inclusion `S ⊆ ℝ³` read in the chart `φ`. It is do Carmo's
*parametrization*, or *system of local coordinates* (Section 2-2, Definition 1): a map from an open
set of parameters in `ℝ²` onto a *coordinate neighborhood* `V ∩ S` cut out by an open `V ⊆ ℝ³`,
differentiable as a map into `ℝ³`, a homeomorphism onto `V ∩ S`, and with `dx_q` one-to-one. The
last is do Carmo's *regularity condition* and is part 3. The homeomorphism onto `V ∩ S` is already
in part 1, because the open subsets of `S` in the subspace topology are exactly the sets `V ∩ S`.
do Carmo's "differentiable" means `C^∞`, which is `smooth` here. Pressley's *surface patch*
(Definitions 4.1.1 and 4.2.1) is the same map, with the regularity condition stated as linear
independence of `x_u` and `x_v`.

do Carmo defines a regular surface from the parametrizations up: `S` is a regular surface when
every point lies in a coordinate neighborhood. Lee's view, that a surface is a `2`-manifold embedded
in `ℝ³` (Smooth Manifolds, Chapter 5), is the one taken here. Parts 2 and 3 are stated for every
smooth chart, which costs nothing: they hold in every smooth chart as soon as they hold in the
charts of one atlas, because the transition to any other smooth chart is a diffeomorphism.
-/

@[expose] public section

open scoped ContDiff

namespace DifferentialGeometry

/-- `x = φ⁻¹ : φ(U) → ℝ³`, the inclusion of `S` read in the chart `φ`. This is do Carmo's
*parametrization*, or *system of local coordinates*, of the coordinate neighborhood `U`.

The inverse `φ⁻¹` is a map into `S`, and `S` is a subset of `ℝ³` with no calculus of its own:
`ContDiffOn` and `fderiv` need a map into `ℝ³`. So `x` is `φ⁻¹` followed by the inclusion `S ⊆ ℝ³`,
which Lean writes as the coercion `(φ⁻¹ q : ℝ³)`. Naming the composite lets the conditions on a
surface, and the theorems about one, speak of `x` as the book does instead of spelling out the
coercion each time. Its values off `φ(U)` are irrelevant. -/
def Chart.parametrization {S : Set ℝ³} (φ : Chart 2 S) : ℝ² → ℝ³ :=
  fun q => (φ⁻¹ q : ℝ³)

/-- **Regular surfaces** (do Carmo, Section 2-2, Definition 1). A smooth `2`-manifold `S ⊆ ℝ³`
whose parametrizations `x = φ⁻¹` are smooth with one-to-one derivatives. -/
structure RegularSurface (S : Set ℝ³) extends SmoothManifold 2 S where
  /-- `x` is smooth on the parameters `φ(U)`, in every smooth chart `φ` -/
  smooth : ∀ φ ∈ A, ContDiffOn ℝ ∞ φ.parametrization (φ '' φ.U)
  /-- `dx_q` is one-to-one at every parameter `q ∈ φ(U)`, in every smooth chart `φ`, where
  `fderiv ℝ x q : ℝ² → ℝ³` is the linear map that best approximates `x` near `q` -/
  regular : ∀ φ ∈ A, ∀ q ∈ φ '' φ.U, Function.Injective (fderiv ℝ φ.parametrization q)

end DifferentialGeometry
