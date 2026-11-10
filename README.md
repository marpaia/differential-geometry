# Differential Geometry

Differential geometry in Lean 4, written to be readable.

This is a library for learning differential geometry with Lean. The definitions follow do Carmo, Pressley, and Lee closely, with the same letters, the same order of ideas, and a citation to the page, so you can read the book and the Lean side by side. It is built on [Mathlib](https://github.com/leanprover-community/mathlib4), which already has a great deal of differential geometry. The aim here is not to add to that, but to write the subject down in a way that is a pleasure to read.

## An excerpt

Lee defines a topological `n`-manifold as a second countable Hausdorff space that is locally Euclidean of dimension `n`. In the library it looks like this.

```lean
/-- **Topological manifolds** (Lee, Topological Manifolds, p. 39). A topological space that is
second countable, Hausdorff, and locally Euclidean of dimension `n`. -/
structure IsTopologicalManifold (n : ℕ) (M : Type*) [TopologicalSpace M] : Prop where
  /-- there is a countable basis of open sets -/
  secondCountable : SecondCountableTopology M
  /-- distinct points have disjoint open neighborhoods -/
  hausdorff : T2Space M
  /-- every point lies in a coordinate domain -/
  locallyEuclidean : IsLocallyEuclidean n M
```

A topological manifold has coordinates but no calculus. A chart `φ` lets you read a function on `M` as a function on `ℝⁿ` and differentiate it there, but two charts can disagree about whether the result is smooth. So Lee asks for charts that agree. Two charts `φ` and `ψ` are smoothly compatible when the transition map `ψ ∘ φ⁻¹` between their coordinates is smooth. An atlas is smooth when any two of its charts are compatible, and a smooth atlas is maximal when it already contains every chart compatible with it. Lee calls a maximal smooth atlas a smooth structure, and a smooth manifold is a topological manifold together with one.

That is the definition, with the topological manifold as its first field:

```lean
/-- **Smooth manifolds** (Lee, Smooth Manifolds, p. 13). A topological `n`-manifold equipped with
a maximal atlas whose transition maps are smooth. -/
structure SmoothManifold (n : ℕ) (M : Type*) [TopologicalSpace M] where
  /-- `M` is a topological `n`-manifold -/
  topological : IsTopologicalManifold n M
  /-- `A`, the smooth structure -/
  A : Set (Chart n M)
  /-- `A` is a maximal smooth atlas -/
  smoothStructure : IsMaximalSmoothAtlas A
```

A regular surface builds on `SmoothManifold` the same way.

To see how this definition gets used, here is a small theorem about it. `smoothStructure A` is the set of all charts that are smoothly compatible with every chart of `A`. Lee uses this in Proposition 1.17 to build a smooth structure out of a handful of charts. If `A` is already a smooth structure, you get `A` back.

```lean
/-- **A smooth structure is determined by itself** (Lee, Smooth Manifolds, p. 13). The maximal
extension of a maximal smooth atlas is itself. -/
theorem SmoothManifold.smoothStructure_A (manifold : SmoothManifold n M) :
    DifferentialGeometry.smoothStructure manifold.A = manifold.A := by
  ext φ
  rw [DifferentialGeometry.smoothStructure, Set.mem_ofPred_eq]
  constructor
  · intro compatible
    exact manifold.smoothStructure.maximal φ compatible
  · intro φ_in_A ψ ψ_in_A
    exact manifold.smoothStructure.compatible φ φ_in_A ψ ψ_in_A
```

Two sets are equal when they have the same members, so `ext φ` picks a chart and asks for both inclusions. The `rw` unfolds what it means for `φ` to be in `smoothStructure A`: it is compatible with every chart of `A`. Then `constructor` splits the two directions. If `φ` is compatible with all of `A`, it is in `A`, which is `manifold.smoothStructure.maximal`. If `φ` is in `A`, it is compatible with every chart of `A`, which is `manifold.smoothStructure.compatible`. Hypotheses are named for what they say, `φ_in_A` for `φ ∈ A`, so each line reads as plain English.

## Contents

The library has three areas, each in its own directory under [`DifferentialGeometry/`](DifferentialGeometry/), and the root module [`DifferentialGeometry.lean`](DifferentialGeometry.lean) imports them in reading order. Each module starts with a docstring that explains the mathematics at the level of the book, so you can read the modules in order like a short set of notes.

**Curves** follow do Carmo's first chapter and Pressley's first three. A [regular curve](DifferentialGeometry/Curves/RegularCurve.lean) is a smooth map from an open interval into `ℝⁿ` whose velocity never vanishes. A [closed curve](DifferentialGeometry/Curves/ClosedCurve.lean) is a regular curve on `ℝ` with a period, and a simple closed curve is one-to-one on a period. A [plane curve](DifferentialGeometry/Curves/PlaneCurve.lean) is convex when its trace lies on one side of each of its tangent lines. The structures extend one another as the definitions do.

**Manifolds** follow Lee. A [topological manifold](DifferentialGeometry/Manifolds/TopologicalManifold.lean) is a second countable Hausdorff space in which every point lies in a coordinate chart `(U, φ)`. A [smooth manifold](DifferentialGeometry/Manifolds/SmoothManifold.lean) is a topological manifold with a maximal atlas `A` of smoothly compatible charts.

**Surfaces** follow do Carmo's second chapter, but are defined the way Lee would define them. A [regular surface](DifferentialGeometry/Surfaces/RegularSurface.lean) is a smooth `2`-manifold `S ⊆ ℝ³` whose inclusion into `ℝ³` is smooth with a one-to-one derivative. do Carmo's parametrization `x` is that inclusion read in a chart, `φ⁻¹`.

## The books

- Manfredo P. do Carmo, *Differential Geometry of Curves and Surfaces*, revised edition. Curves and surfaces, and the terminology for both.
- Andrew Pressley, *Elementary Differential Geometry*, second edition. Cited alongside do Carmo where the two state a definition differently, and the source of the periodic form of a closed curve.
- John M. Lee, *Introduction to Topological Manifolds*, second edition. Charts and topological manifolds.
- John M. Lee, *Introduction to Smooth Manifolds*, second edition. Atlases, smooth structures, and the view of a surface as a `2`-manifold sitting in `ℝ³`.

Citations give the book, then the section or page and the definition or proposition number, as in `(do Carmo, Section 2-2, Definition 1)` or `(Lee, Smooth Manifolds, p. 12)`.

## Notation

Everything is in the namespace `DifferentialGeometry`, and the notation is scoped to it. General notation is defined in [`Notation.lean`](DifferentialGeometry/Notation.lean); chart inverse notation and its printer are defined in [`Manifolds/Notation.lean`](DifferentialGeometry/Manifolds/Notation.lean).

| On paper | In Lean |
| --- | --- |
| `ℝⁿ`, `ℝ²`, `ℝ³` | `ℝ^n`, `ℝ²`, `ℝ³` |
| `α(t)`, `α'(t)` | `α t`, `deriv α t` |
| `T`, the period of a closed curve | `α.T` |
| `Jv`, the quarter turn of `v ∈ ℝ²` | `J v` |
| `⟪v, w⟫` | `⟪v, w⟫` |
| `(U, φ)`, a chart | `φ : Chart n M`, `φ.U` |
| `φ⁻¹`, `ψ ∘ φ⁻¹` | `φ⁻¹`, `φ.transition ψ` |
| `A`, a smooth structure | `A : Set (Chart n M)` |
| `x = φ⁻¹`, a parametrization of a surface | `φ.parametrization` |

Behind the notation, `ℝ^n` is Mathlib's `EuclideanSpace ℝ (Fin n)` and `⟪v, w⟫` is `inner ℝ v w`. The conventions for names, docstrings, and proofs are in [STYLE.md](STYLE.md).

## Using it

A file that uses the library opens the namespace and its notation.

```lean
import DifferentialGeometry

open DifferentialGeometry
open scoped DifferentialGeometry
```

[`DifferentialGeometryTest/`](DifferentialGeometryTest/) holds files of this kind, one per area, that use the library the way a downstream project would.

To build, install Lean with [elan](https://github.com/leanprover/elan). The toolchain is pinned in `lean-toolchain` and Mathlib to a release tag in `lakefile.toml`, so the two always agree.

```sh
lake exe cache get   # prebuilt Mathlib, once per Mathlib version
lake build
lake lint
lake test
```

To move to a newer Mathlib, set `lean-toolchain` and the `rev` in `lakefile.toml` to the same release tag, then run `lake update mathlib` and `lake exe cache get`.
