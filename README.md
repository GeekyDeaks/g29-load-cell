# G29 Load Cell Mod

WIP on replacing the stock brake pedal sensor on a Logitech G29 pedal set with a load cell

It uses one or two cheap load cells arranged in a [wheatstone bridge](https://en.wikipedia.org/wiki/Wheatstone_bridge)
and a small circuit using a Instrumentation Op-Amp.  The cells are mounted in a 3D printed
model that replaces the lower half of the brake piston assembly

# Software used

1. EAGLE https://www.autodesk.co.uk/products/eagle/free-download
2. Fusion 360 https://www.autodesk.com/campaigns/fusion-360-for-hobbyists

# Load Cells

The load cells are cheap bathroom scale variety.  I got mine from amazon:

https://www.amazon.co.uk/gp/product/B07TWLP3X8

![load cell dimensions](img/loadcell.png)

Each cell is comprised of two resistors one which increases under load (white) and the 
other which decreases (black).  Zero load is approx 1k, with about 2-3 Ohm change under heavy load

# Wheatstone Bridge

The circuit allows for running the mod in either a dual or single load cell
configuration. 

For the cells above there are three wires

1. white - increasing resistance under load
2. red - common
3. black - decreasing resistance under load

## Single Load Cell

In a single load cell configuration, the load cell is used as the top portion of the wheatstone
bridge.  R1, R2 and R_BAL need to be populated in order to construct the lower half of the bridge 
and R_REF should be replaced with a link to GND to run the amp in positive gain mode

The 1k resistors for R1 and R2 should be measured and the larger of the two should
be used for R1 to allow R_BAL to adjust the link with R2 and force the bridge out of 
blance with no load

## Dual Load Cell

If two load cells are used then R1, R2 and R_BAL should be left empty and R_REF
should be populated with a 2K pot.  R_REF will allow the INA122P to be run in
reverse gain mode by ensuring that the higher side of the bridge is connected to
v- on the LOAD_CELL connector (J1)

# Amplifier Schematic

![amp schematic](img/amp_schematic.png)

Since we need to output a higher voltage with no load on the cells 
we have two choices:

1. unblance the bridge so that load brings it back into balance
2. invert the gain

Unblancing the bridge is the intended approach for a single load cell configuration
and involves tweaking one side of the bridge by a very small
resistance via R_BAL.

Inverting the gain is intended for the dual load cell configuation.  Fortunately, the INA122 is
rail to rail, so you can have `Vout` go all the way to `V+` by tying `ref` to `V+`
and ensuring the higher potential side of the bridge is connected to `V-in` on the amp

For our purposes, we actually want zero load to be a little less than `V+`, so we 
use another trimpot to bring `ref` down to reduce the upper deadzone. Unfortunately,
this causes the common mode rejection to degrade as we have a high 
impedence on `ref`.  As per the datasheet, we should really put a unity gain op-amp
in place to act as a buffer, but since we do not require high precision, we can 
simply reduce `ref` lower as required and not worry too much about it's precise value

## Clutch

The circuit also allows for simulating a clutch, allowing it to be removed if desired.
The G29 has been known to glitch if the clutch is disconnected and the leads left hanging

# PCB

![amp pcb top](img/amp_pcb_top.png)
![amp pcb bottom](img/amp_pcb_bottom.png)

# STL models

## Single Load Cell

The single load cell holder should fit in the standard pedal case
[stl/single_holder.stl](stl/single_holder.stl) 

## Dual Load Cell

There are two separate bodies for the dual confifguration.  [stl/dual_holder.stl](stl/dual_holder.stl) contains
the model for the load cell holder that mounts into the pedal frame and [stl/dual_spacer.stl](stl/dual_spacer.stl
contains the model for the small spacer that sits between the two cells.

NOTE: this model will not fit inside the stadard pedal case

# G29 brake levels

From reading around it seems that there is not an agreed set of values for what represents
min and max braking.  Below is a table I took from attaching an AVO directly to the middle pin 
of the brake potentiometer on my set and monitoring the output on the PS4:

| Level | Voltage |
|------:|---------|
| 0%    | 3.0     |
| 25%   | 2.5     |
| 50%   | 2.2     |
| 75%   | 2.0     |
| 100%  | 1.9     |

# Pedal Pin Outs

    -----------------------
    \  1   2   3   4   5  /
     \   6   7   8   9   /
       -----------------

| Pin | Role      | Colour
| --- | --------- | ------
| 1   | Gnd       | Black
| 2   | Throttle  | Orange
| 3   | Brake     | White
| 4   | Clutch    | Green
| 5   | NC        |
| 6   | +3.3v     | Red
| 7   | NC        |
| 8   | NC        |
| 9   | +3.3v     | Red

The above values were taken by removing the wiring loom from the pedal set
and measuring at the spade connectors.
Note that these pin outs are different to those reported by others for the G27
with +3.3v and Gnd switched

# Inspiration

This is a popular mod and others have come before with interesting designs that you may also
want to take a look at:

- https://www.reddit.com/r/simracing/comments/92exmk/diy_load_cell_brake_for_g29_with_native_ps4/
- https://www.racedepartment.com/threads/low-budget-load-cell-mod-for-logitech-g25-g27-g29.167760/
- https://imgur.com/gallery/gOjAf#SXX5zrY
- https://www.racedepartment.com/threads/logitech-g25-g27-g29-g920-load-cell-diy-project.174623/
