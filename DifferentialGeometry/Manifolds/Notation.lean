module

public import DifferentialGeometry.Manifolds.TopologicalManifold /- Chart, Chart.inv -/

/-!
# Manifold notation

The inverse coordinate maps of charts named `φ` and `ψ` are written `φ⁻¹` and `ψ⁻¹`. The chart
names are resolved where the notation is used; the unexpander restores it when printing.

This notation uses the `DifferentialGeometry` scope, like the general notation in `Notation`.
-/

@[expose] public section

namespace DifferentialGeometry

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

end DifferentialGeometry
