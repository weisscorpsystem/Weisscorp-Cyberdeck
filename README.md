# WEISSCORP SYSTEM - Industrial Edition v8.0 (Hybrid)
## Project: Open Deck Terminal - Radxa Platform

### Technical Overview
A field-ready portable terminal enclosure (cyberdeck) optimized for mobile operations. Specifically engineered for the **Radxa Zero 3W** SBC. The architectural design follows industrial brutalist principles, prioritizing structural integrity, component protection, and thermal management.

### Mechanical Specifications
* **Computing Unit:** Radxa Zero 3W.
* **Display System:** 3.5" IPS LCD (Active Area: 73x54 mm, 1.2 mm recessed impact protection).
* **Input Interface:** 10x3 tactile switch matrix (6x6x6 mm switches).
* **Power Management:** Dual USB module (Type-A + Type-C) with a dedicated mechanical Rocker Switch.
* **Envelope:** 130 x 130 mm wedge profile with ergonomic tilt geometry.

### Design Features
* **Material Compliance:** Optimized for PETG, ABS, or ASA. (PLA is deprecated due to thermal deformation risks).
* **Assembly System:** 4-point PCB constraint via integrated cylindrical standoffs. Chassis secured by 4x M2.5 x 8 mm machine screws.
* **Cooling:** Passive thermal dissipation via a parametric ventilation grill integrated into the chassis base.

### Manufacturing Protocol (FDM)
* **Layer Height:** 0.2 mm (Chassis), 0.1-0.12 mm (Keycaps).
* **Perimeters:** 3–4 wall loops.
* **Infill:** 15–30% (Gyroid or Cubic pattern).
* **Tolerances:** XY Compensation +0.1 mm recommended for precision component fitment.

### Assembly Protocol
1. Install the Rocker Switch and USB power module into the Back Shell.
2. Mount the Radxa Zero 3W and display controller to the underside of the PCB.
3. Align the PCB assembly onto the Back Shell standoffs.
4. Seat the LCD module into the Front Shell recessed cavity.
5. Install keycaps onto the tactile switch matrix.
6. Mate the shells and secure via 4x M2.5 fasteners.
