# PCB

Upload `gerber_plaid.zip` and `gerber_plaid_bottom.zip`
to [JLCPCB](https://jlcpcb.com/) (by far the cheapest PCB printing service,
even with the minimum order quantity of 5).

Gerber files were generated according to the instructions
[here](https://support.jlcpcb.com/article/44-how-to-export-kicad-pcb-to-gerber-files).

Go into the `pcb/gerber` folder and generate `gerber_plaid.zip` with:
```bash
zip -r gerber_plaid.zip plaid/
```
and similarity, for `gerber_plaid_bottom.zip`:
```bash
zip -r gerber_plaid_bottom.zip plaid_bottom/
```

Use these settings when ordering:
- PCB thickness: 1.6mm
- Surface finish: HASL (with lead) [can change according to preference]
- Remove order number
- PCB color: white looks nice

