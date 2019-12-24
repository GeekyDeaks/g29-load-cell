# G29 Load Cell

WIP on replacing the stock brake pedal sensor on a Logitech G29 pedal set with a load cell

# Get Started

1. `git clone https://github.com/GeekyDeaks/g29-load-cell.git`
2. Install EAGLE https://www.autodesk.co.uk/products/eagle/free-download


# G29 brake levels

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