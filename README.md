# G29 Load Cell

WIP on replacing the stock brake pedal sensor on a Logitech G29 pedal set with a load cell

# Software used

1. EAGLE https://www.autodesk.co.uk/products/eagle/free-download
2. Fusion 360 https://www.autodesk.com/campaigns/fusion-360-for-hobbyists

# G29 brake levels

From reading around it seems that there is not an agreed set of values for what represents
min and max braking.  Below is a table I took from attaching an AVO directly to the middle pin 
of the brake potentiometer

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

| Pin | Role
| --- | ---------
| 1   | Gnd
| 2   | Throttle
| 3   | Brake
| 4   | Clutch
| 5   | NC
| 6   | +3.3v
| 7   | NC
| 8   | NC
| 9   | +3.3v

The above values were taken by removing the wiring loom from the pedal set.
Note that these pin outs are different to those reported by others for the G27
with +3.3v and Gnd switched

# INA122P

Since we need to output a higher voltage with no load on the cells and we
have them arranged in a wheatstone bridge, we have two choices:

1. unblance the bridge
2. invert the gain

Unblancing the bridge would involve tweaking one side of the bridge by a very small
resistance, so I decided to just invert the gain instead.  Fortunately the INA122 is
rail to rail, so you can have `Vout` go all the way to `V+` by tying `ref` to `V+`.

For out purposes, we actually want zero load to be a little less, so we use another trimpot
to bring `ref` a little lower.  Unfortunately, this causes the common mode rejection to
degrade as we have a high impedence on `ref`.  As per the datasheet, we should really put 
a unity gain op-amp in place to act as a buffer, but since we do not require high precision, 
we can simply reduce `ref` lower as required and not worry too much about it's precise value

# STL models

There are two separate bodies.  [stl/holder.stl](stl/holder.stl) contains the model for the load cell holder
that mounts into the pedal frame and [stl/spacer.stl](stl/spacer.stl) contains the model for the small 
spacer that sits between the two cells