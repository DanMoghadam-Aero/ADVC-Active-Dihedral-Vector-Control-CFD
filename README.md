# Active Dihedral Vector Control (ADVC)

## Preliminary parametric CFD investigation of side-force-dominated yaw control

This repository documents an independent computational investigation of the **Active Dihedral Vector Control (ADVC)** concept: a rear-wing architecture intended to generate aerodynamic yaw authority through independently actuated, full-chord dihedral outboard sections.

Conventional aerodynamic yaw-control devices often rely on asymmetric drag. The ADVC instead redirects part of the local aerodynamic loading laterally, producing a side force behind a proposed vehicle centre of gravity and therefore a yaw moment. The study evaluates whether this mechanism can provide measurable, bidirectional yaw authority while limiting changes in longitudinal force, downforce, pitch moment, and roll moment.

> **Research question:** Can independently actuated dihedral outer sections generate measurable, bidirectional aerodynamic yaw authority primarily through lateral side force, while limiting changes in the remaining aerodynamic loads?

The work is presented as a preliminary isolated-wing proof of concept, not as a grid-independent validation or a prediction of complete vehicle behaviour.

## Concept and geometry

The investigated assembly uses an inverted NACA 4415 profile with a fixed central section and two independently actuated outboard sections. Either outboard section can rotate upward in dihedral while its corresponding endplate moves with it.

| Parameter | Value |
| --- | ---: |
| Nominal chord | 0.30 m |
| Fixed central-section span | 0.60 m |
| Outboard-section span | 0.45 m per side |
| Clearance gap | 0.020 m per side |
| Reference span | 1.54 m |
| Reference area | 0.45 m^2 |
| Profile | Inverted NACA 4415 |
| Maximum investigated deployment | 15 deg |
| Maximum investigated sideslip | 5 deg |

## CFD methodology

The aerodynamic response was evaluated using a 14-case three-dimensional steady Reynolds-averaged Navier-Stokes (RANS) CFD sweep. Loads were processed as matched-baseline increments at each sideslip condition.

| Setting | Value or method |
| --- | --- |
| Solver | ANSYS Fluent, steady pressure-based |
| Turbulence model | k-omega SST with production limiter |
| Pressure-velocity coupling | Coupled |
| Spatial discretization | Second-order schemes |
| Freestream speed | 40 m/s |
| Chord Reynolds number | Approximately 8.22 x 10^5 |
| Angle of attack | 0 deg |
| Sideslip conditions | 0 deg, approximately 2.5 deg, and approximately 5 deg |
| Volume mesh | 1,633,519 polyhedral cells |
| Near-wall mesh | Three prism layers; maximum y+ approximately 78 |
| Iteration limit | 300 iterations per design point |

## Principal findings

- At zero sideslip, increasing deployment produced monotonic and approximately linear lateral-force and yaw-moment increments, with R^2 greater than 0.9998 for both quantities over the sampled deployment range.
- At 15 deg deployment, the incremental side force was 8.081 N and the directly computed yaw-moment increment had a magnitude of 13.507 N m.
- The apparent effective longitudinal lever arm, `-DeltaMy/DeltaFz`, remained between 1.666 m and 1.671 m. This agrees with the geometrically plausible 1.5-1.8 m range and supports, but does not uniquely prove, side-force-dominated yaw generation.
- The isolated wing retained approximately 98.4% of its zero-sideslip baseline downforce at maximum deployment.
- The resolved longitudinal-force increment remained close to zero, indicating no discernible drag penalty at the present numerical fidelity. Sub-percent drag changes, however, remain within the numerical uncertainty of the steady-RANS analysis.
- Bidirectional yaw authority was retained under the investigated sideslip conditions. At approximately 5 deg sideslip, the windward and leeward deployment limits reached yaw-moment coefficient increments of approximately -0.0215 and +0.0180, respectively.
- The accompanying pitch- and roll-moment increments remained smaller than the primary yaw response. At maximum zero-sideslip deployment, their coefficient increments were approximately 0.004 and 0.006, respectively, compared with a yaw-moment coefficient magnitude of approximately 0.020.

## Repository contents

The repository is organized into three main folders:

```text
.
|-- README.md
|-- Post_processing/
|-- Report/
`-- Visuals/
```

### `Post_processing/`

Contains the exported numerical results and the MATLAB post-processing material developed during the project. This includes the complete simulation-results matrix, sectional static-pressure data, and the scripts used to access, process, and visualize the data. The folder is provided as a working research archive rather than a packaged software distribution.

### `Report/`

Contains the complete methodology, coordinate definitions, mathematical formulation, results, flow interpretation, limitations, references, and exported case table:

- [ADVC Preliminary CFD Report](Report/ADVC_Preliminary_CFD_Report.pdf)

### `Visuals/`

Contains the principal CFD and CAD images used in the report, including geometry views, mesh and near-wall-resolution images, pressure fields, pathlines, Q-criterion iso-surfaces, and sectional-flow visualizations. These images provide qualitative context for the integrated load trends and should not be interpreted as independent validation of attachment, vortex strength, or drag.

## Using the archived data

The post-processing files are included to document the numerical results and the workflow used to produce the report figures. The MATLAB scripts may contain project-specific filenames or paths and may therefore require minor adjustment when run on another system. ANSYS Fluent was used to generate the original CFD solutions; this repository provides the processed aerodynamic outputs rather than the complete Fluent case and data files.

## Scope and limitations

This project should be interpreted as a **preliminary comparative RANS investigation**. Its main limitations are:

- no formal mesh-refinement or domain-size sensitivity study;
- only three near-wall prism layers and a maximum reported y+ of approximately 78;
- a fixed limit of 300 steady-solver iterations per case, with bounded residual plateaus and approximately stationary force monitors;
- an isolated-wing domain excluding the vehicle body, wheels, moving ground, suspension response, structural behaviour, actuator dynamics, and wing-body interference; and
- qualitative use of pressure contours, pathlines, and Q-criterion iso-surfaces.

The most defensible outcomes are therefore the direction, approximate magnitude, monotonicity, and internal force-moment consistency of the incremental aerodynamic loads. Sub-percent longitudinal-force changes and complete vehicle-handling benefits are outside the established numerical accuracy and scope.

## Citation

If you reference or build upon this project, the following BibTeX entry may be used:

```bibtex
@techreport{moghadam2026advc,
  author      = {Moghadam, Danial},
  title       = {Computational Investigation of an Active Dihedral Vector Control Mechanism for Decoupled Yaw Authority in Motorsport Applications},
  institution = {Independent Research},
  year        = {2026},
  month       = {September},
  type        = {Preliminary CFD Report}
}
```

## Author

**Danial Moghadam**  
M.Sc. in Aerodynamics  
Independent Research  
[GitHub portfolio](https://github.com/DanMoghadam-Aero)  
Email: dan998m@gmail.com

## Disclaimer

This repository presents an independent research and portfolio project. The ADVC geometry has not been experimentally validated, structurally assessed, or evaluated as part of a complete vehicle, and the results should not be treated as a production-component design specification.
