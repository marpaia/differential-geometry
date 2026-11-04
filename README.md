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

| Module | Contents |
| --- | --- |
| [`Notation`](DifferentialGeometry/Notation.lean) | `ℝ²`, `ℝ³`, `e₁`, `e₂`, `∂ᵤ`, `∂ᵥ`, `σᵤ`, `σᵥ`, `σᵤᵤ`, `σᵤᵥ`, `σᵥᵥ`, `cross` |
| [`Surfaces.Patch`](DifferentialGeometry/Surfaces/Patch.lean) | `SurfacePatch`, `IsSmoothSurface` |
| [`Surfaces.TangentPlane`](DifferentialGeometry/Surfaces/TangentPlane.lean) | `tangentPlane`, its agreement with Mathlib's tangent cone |
| [`Surfaces.Orientation`](DifferentialGeometry/Surfaces/Orientation.lean) | `normal`, `orientedAngle`, `IsOrientable` |
| [`Surfaces.AreaElement`](DifferentialGeometry/Surfaces/AreaElement.lean) | `E`, `F`, `G`, `areaElement` |
| [`Surfaces.GaussianCurvature`](DifferentialGeometry/Surfaces/GaussianCurvature.lean) | `L`, `M`, `N`, `K` |
| [`Surfaces.GeodesicCurvature`](DifferentialGeometry/Surfaces/GeodesicCurvature.lean) | `geodesicCurvature`, `OrthonormalFrame`, the tangent angle |
| [`Surfaces.GaussBonnet.Local`](DifferentialGeometry/Surfaces/GaussBonnet/Local.lean) | `CurvilinearPolygon`, Green's theorem, Hopf's Umlaufsatz, local Gauss–Bonnet |
| [`Surfaces.GaussBonnet.Global`](DifferentialGeometry/Surfaces/GaussBonnet/Global.lean) | `Triangulation`, the Euler number, global Gauss–Bonnet |

`DifferentialGeometryTest/` holds files that use the library from outside, as a downstream project would. `lake test` builds them.

## Notation

| On paper | In Lean | Mathlib |
| --- | --- | --- |
| `ℝ²`, `ℝ³` | `ℝ²`, `ℝ³` | `EuclideanSpace ℝ (Fin 2)`, `EuclideanSpace ℝ (Fin 3)` |
| `∂f/∂u`, `∂f/∂v` | `∂ᵤ f`, `∂ᵥ f` | `lineDeriv ℝ f q e₁`, `lineDeriv ℝ f q e₂` |
| `σᵤ`, `σᵥ`, `σᵤᵤ`, `σᵤᵥ`, `σᵥᵥ` | the same | derivatives of the patch `σ` in scope |
| `a × b` | `cross a b` | `crossProduct` on coordinates |
| `a · b` | `⟪a, b⟫` | `inner ℝ a b`, with `open scoped RealInnerProductSpace` |
| `E`, `F`, `G`, `L`, `M`, `N`, `K` | `σ.E q`, …, `σ.K q` | |
| `∫∫_R f du dv` | `∫ x in R, f x` | the Lebesgue integral over `R ⊆ ℝ²` |

## Status

Each module states its definitions and theorems in full. A theorem whose proof is `sorry` is stated but not yet proved, and `lake build` reports every one of them as a `declaration uses 'sorry'` warning. When the library is free of them, CI builds with `--wfail`.

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
