# Differential Geometry

A Lean 4 library of definitions and theorems from differential geometry, built on [Mathlib](https://github.com/leanprover-community/mathlib4).

## Layout

Everything lives in the `DifferentialGeometry` namespace. Notation is scoped to it, so a file that uses the library opens both:

```lean
import DifferentialGeometry

open DifferentialGeometry
open scoped DifferentialGeometry
```

[`DifferentialGeometry.lean`](DifferentialGeometry.lean) imports every module in reading order.

### Curves

A regular curve is a smooth map `α` from an open interval `I ⊆ ℝ` into `ℝⁿ` whose velocity `α'(t)` never vanishes. A closed curve is a regular curve on `ℝ` with a period `T`, a simple closed curve is one-to-one on a period, and a plane curve is convex when its trace lies on one side of each of its tangent lines. The structures extend one another as the definitions do.

| Module | Contents |
| --- | --- |
| [`Curves.RegularCurve`](DifferentialGeometry/Curves/RegularCurve.lean) | `RegularCurve`, a smooth map `α : I → ℝⁿ` from an open interval with `α'(t) ≠ 0` |
| [`Curves.ClosedCurve`](DifferentialGeometry/Curves/ClosedCurve.lean) | `ClosedCurve`, a regular curve on `ℝ` with period `T`; `SimpleClosedCurve`, one-to-one on `[0, T)` |
| [`Curves.PlaneCurve`](DifferentialGeometry/Curves/PlaneCurve.lean) | `J`, the quarter turn of `ℝ²`; `IsConvex`, the trace lies on one side of every tangent line |

### Manifolds

A smooth `n`-manifold is a pair `(M, A)`. The modules follow the five parts of the definition: a topological space, local coordinates, the Hausdorff and second countable conditions, a smooth atlas, and maximality.

| Module | Contents |
| --- | --- |
| [`Manifolds.TopologicalManifold`](DifferentialGeometry/Manifolds/TopologicalManifold.lean) | `Chart`, `IsLocallyEuclidean`, `IsTopologicalManifold` |
| [`Manifolds.SmoothManifold`](DifferentialGeometry/Manifolds/SmoothManifold.lean) | `transition`, `SmoothlyCompatible`, `IsAtlas`, `IsSmoothAtlas`, `IsMaximalSmoothAtlas`, `SmoothManifold` |

### Surfaces

A regular surface is a smooth `2`-manifold `S ⊆ ℝ³`, with the subspace topology, whose inclusion into `ℝ³` is smooth with a one-to-one derivative in every smooth chart. do Carmo's parametrization `x` is the inclusion read in a chart, `φ⁻¹`.

| Module | Contents |
| --- | --- |
| [`Notation`](DifferentialGeometry/Notation.lean) | `ℝ^n`, `ℝ²`, `ℝ³` |
| [`Surfaces.RegularSurface`](DifferentialGeometry/Surfaces/RegularSurface.lean) | `RegularSurface`, a smooth `2`-manifold `S ⊆ ℝ³` whose inclusion is smooth and regular in every smooth chart |

`DifferentialGeometryTest/` holds files that use the library from outside, as a downstream project would. `lake test` builds them.

## Notation

| On paper | In Lean | Mathlib |
| --- | --- | --- |
| `ℝⁿ`, `ℝ²`, `ℝ³` | `ℝ^n`, `ℝ²`, `ℝ³` | `EuclideanSpace ℝ (Fin n)` |
| `(U, φ)`, `φ⁻¹`, `ψ ∘ φ⁻¹` | `φ : Chart n M`, `φ⁻¹`, `φ.transition ψ` | |
| `A`, a smooth structure | `A : Set (Chart n M)` | |
| `α(t)`, `α'(t)`, a curve and its velocity | `α : RegularCurve n`, `α t`, `deriv α t` | |
| `T`, the period of a closed curve | `α : ClosedCurve n`, `α.T` | |
| `Jv`, `v` rotated a quarter turn; `⟪v, w⟫` | `J v`, `⟪v, w⟫` | `inner ℝ v w`, with `open scoped RealInnerProductSpace` |
| `x = φ⁻¹`, the parametrization of a surface in the chart `φ` | `φ.parametrization` | |

## Status

The library is definitions, in the notation of the books, with the theorems to come. The one theorem present, that a smooth atlas determines a smooth structure, is stated with a `sorry` proof because `SmoothManifold.ofAtlas` needs it; `lake build` reports it as a `declaration uses 'sorry'` warning. When the library is free of them, CI builds with `--wfail`.

## Building

Install Lean with [elan](https://github.com/leanprover/elan). The toolchain is pinned in `lean-toolchain`, and Mathlib is pinned to a release tag in `lakefile.toml`.

```sh
lake exe cache get   # prebuilt Mathlib, once per Mathlib version
lake build           # the library
lake lint            # the Batteries environment linters
lake test            # DifferentialGeometryTest
```

To move to a newer Mathlib, set `lean-toolchain` and the `rev` in `lakefile.toml` to the same release tag, then run `lake update mathlib` and `lake exe cache get`.

Conventions for writing new modules are in [STYLE.md](STYLE.md).
