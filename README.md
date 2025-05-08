# 🎳 Bowling Scorekeeping System

This Verilog project implements a **digital bowling scorekeeping system**, including support for strikes, spares, and bonus frames using an FSM-based architecture and seven-segment display decoding.

---

## 🧩 Included Modules

- `bowling_score_system.v`: Core FSM logic for frame-based scoring, including bonus logic.
- `BowlingGameSystem.v`: Top-level controller managing input/output and APD logic.
- `binary_to_bcd_decoder.v`: Binary to BCD converter using Double Dabble algorithm.
- `BCD_to_Seven_Segment.v`: Converts BCD output to 7-segment signals.

---

## 🧪 Testbenches

- `tb_bowling_score_system.v`: Unit test for the scoring module.
- `tb_BowlingGameSystem.v`: System-level testbench verifying end-to-end I/O behavior.

Test scenarios include:
- Strike (e.g., 10 pins down)
- Spare (e.g., 4 + 6)
- Normal frame (e.g., 3 + 4)
- Bonus frame logic (frame 10)
- Multi-frame combos and edge cases

---

## 📐 Features

- Frame-based FSM design
- Handles all standard bowling rules
- Bonus calculation for strike/spare combos
- Supports up to 12 throws with automatic bonus handling in the 10th frame
- 7-segment display integration
- Modular & testbench-ready

---

## ▶️ Simulation

Recommended tools: ModelSim / Vivado / Quartus

```bash
# Example simulation (ModelSim)
vlog bowling_score_system.v BowlingGameSystem.v binary_to_bcd_decoder.v BCD_to_Seven_Segment.v tb_bowling_score_system.v
vsim tb_bowling_score_system
```

## 📁 Folder Structure
```
bowling-scorekeeping-system/
├── bowling_score_system.v
├── BowlingGameSystem.v
├── binary_to_bcd_decoder.v
├── BCD_to_Seven_Segment.v
├── tb_bowling_score_system.v
├── tb_BowlingGameSystem.v
└── README.md
```
---

## 👨‍💻 Author

**Kuan-Yu (Eric) Liao**  
B.Sc. in Electrical Engineering, NTUST  
[LinkedIn Profile](https://www.linkedin.com/in/kuan-yu-liao-a58452235)

---

## 📜 License

This project is licensed under the **MIT License**.  
You are free to use, modify, and distribute this code with proper attribution.
