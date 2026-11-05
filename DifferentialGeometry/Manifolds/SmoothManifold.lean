module

public import DifferentialGeometry.Manifolds.TopologicalManifold /- Chart, IsTopologicalManifold -/
public import Mathlib.Analysis.Calculus.ContDiff.Defs /- ContDiffOn, ∞ -/

/-!
# Smooth manifolds

Wherever two charts overlap, a point has two coordinate descriptions. Calculus on `M` needs to
pass between them without changing whether a function is smooth. The smooth branch of the
definition has two parts (Lee, Smooth Manifolds, Chapter 1).

4. A smooth atlas: a covering family of charts whose changes of coordinates are smooth.
5. Maximality: every chart compatible with that family is included.

For charts `(U, φ)` and `(W, ψ)`, the *transition map* from `φ`-coordinates to `ψ`-coordinates is

  `T_{ψφ} = ψ ∘ φ⁻¹ : φ(U ∩ W) → ψ(U ∩ W)`,

read from right to left: start with `x = φ(p)`, recover `p` by `φ⁻¹`, then apply `ψ`. No point of
`M` moves. The overlap is open in `M`, and both charts send it to open subsets of `ℝ^n`, so the
transition map is a map between Euclidean open sets, and ordinary partial derivatives apply. It is
*smooth* if its components have continuous partial derivatives of every order, Mathlib's
`ContDiffOn ℝ ∞`.

Two charts are *smoothly compatible* if the transition map and its inverse are both smooth (p. 12).
Both directions are needed. On the line, `φ(p) = p` and `ψ(p) = p³` have the smooth transition
`u ↦ u³`, but the inverse `v ↦ ∛v` has no derivative at `0`, and the two charts would disagree
about whether `f(p) = p` is smooth. Charts with no overlap are compatible without a test, because
every map is smooth on the empty set.

An *atlas* is a collection of charts whose domains cover `M`, and a *smooth atlas* is one any two
of whose charts are smoothly compatible (p. 12). A smooth atlas is *maximal* if it contains every
chart smoothly compatible with all of its charts; Lee also says *complete*. A *smooth structure*
on `M` is a maximal smooth atlas, its charts are the *smooth charts*, and a *smooth manifold* is a
pair `(M, A)` of a topological manifold and a smooth structure on it (p. 13).

A maximal atlas contains very many charts, so a smooth structure is specified by any smooth atlas
`A₀` that covers `M`: the charts compatible with every chart of `A₀` form the unique maximal
smooth atlas containing `A₀` (Proposition 1.17). The choice of `A₀` still matters. On the line,
the identity chart and the cubic chart each generate a smooth structure, but their
incompatibility keeps them out of the same one.
-/

@[expose] public section

open scoped ContDiff

namespace DifferentialGeometry

namespace Chart

variable {n : ℕ} {M : Type*} [TopologicalSpace M] (φ ψ : Chart n M)

/-- **The overlap** `φ(U ∩ W)` of the charts `(U, φ)` and `(W, ψ)`, in `φ`-coordinates -/
def overlap : Set (ℝ^n) :=
  φ '' (φ.U ∩ ψ.U)

/-- **The transition map** `T_{ψφ} = ψ ∘ φ⁻¹` from `φ`-coordinates to `ψ`-coordinates (Lee, Smooth
Manifolds, p. 12) -/
def transition : ℝ^n → ℝ^n :=
  ψ ∘ φ⁻¹

/-- **Smoothly compatible charts** (Lee, Smooth Manifolds, p. 12). The transition map from `φ` to
`ψ` and the one from `ψ` to `φ` are both smooth. -/
def SmoothlyCompatible : Prop :=
  ContDiffOn ℝ ∞ (φ.transition ψ) (φ.overlap ψ) ∧ ContDiffOn ℝ ∞ (ψ.transition φ) (ψ.overlap φ)

end Chart

variable {n : ℕ} {M : Type*} [TopologicalSpace M]

/-- **Atlases** (Lee, Smooth Manifolds, p. 12). A collection `A` of charts whose domains cover
`M`. -/
def IsAtlas (A : Set (Chart n M)) : Prop :=
  ∀ p : M, ∃ φ ∈ A, p ∈ φ.U

/-- **Smooth atlases** (Lee, Smooth Manifolds, p. 12). An atlas any two of whose charts are
smoothly compatible. -/
def IsSmoothAtlas (A : Set (Chart n M)) : Prop :=
  IsAtlas A ∧ ∀ φ ∈ A, ∀ ψ ∈ A, φ.SmoothlyCompatible ψ

/-- **Maximal smooth atlases** (Lee, Smooth Manifolds, p. 13). A smooth atlas that contains every
chart smoothly compatible with all of its charts. -/
def IsMaximalSmoothAtlas (A : Set (Chart n M)) : Prop :=
  IsSmoothAtlas A ∧ ∀ φ : Chart n M, (∀ ψ ∈ A, φ.SmoothlyCompatible ψ) → φ ∈ A

/-- **Smooth manifolds** (Lee, Smooth Manifolds, p. 13). A pair `(M, A)` of a topological manifold
and a smooth structure, a maximal smooth atlas. The charts of `A` are the smooth charts. -/
structure SmoothManifold (n : ℕ) (M : Type*) [TopologicalSpace M] where
  /-- `M` is a topological `n`-manifold -/
  topologicalManifold : IsTopologicalManifold n M
  /-- `A`, the smooth structure -/
  A : Set (Chart n M)
  /-- `A` is a maximal smooth atlas -/
  maximal : IsMaximalSmoothAtlas A

/-- **The smooth structure determined by an atlas** `A₀` (Lee, Smooth Manifolds,
Proposition 1.17). The charts smoothly compatible with every chart of `A₀`. -/
def smoothStructure (A₀ : Set (Chart n M)) : Set (Chart n M) :=
  {φ | ∀ ψ ∈ A₀, φ.SmoothlyCompatible ψ}

/-- **Every smooth atlas determines a smooth structure** (Lee, Smooth Manifolds,
Proposition 1.17 (a)). Two charts compatible with `A₀` are compatible with each other: near any
point of their overlap, `η ∘ ψ⁻¹ = (η ∘ φ⁻¹) ∘ (φ ∘ ψ⁻¹)` for a chart `φ` of `A₀` around that point,
and both factors are smooth. Any chart compatible with the result was already included. -/
theorem isMaximalSmoothAtlas_smoothStructure {A₀ : Set (Chart n M)} (smooth : IsSmoothAtlas A₀) :
    IsMaximalSmoothAtlas (smoothStructure A₀) :=
  sorry

/-- **A smooth manifold from a covering smooth atlas** (Lee, Smooth Manifolds, Proposition 1.17).
The usual way to specify one: a few charts, and the structure they determine. -/
def SmoothManifold.ofAtlas (manifold : IsTopologicalManifold n M) {A₀ : Set (Chart n M)}
    (smooth : IsSmoothAtlas A₀) : SmoothManifold n M where
  topologicalManifold := manifold
  A := smoothStructure A₀
  maximal := isMaximalSmoothAtlas_smoothStructure smooth

end DifferentialGeometry
