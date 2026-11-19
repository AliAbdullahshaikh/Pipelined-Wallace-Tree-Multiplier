# Hardware Synthesis & Performance Analysis

## 1. Objective
The objective of this analysis is to quantify the architectural trade-offs (Area vs. Speed) of transforming a purely combinational (unpipelined) 4-bit Wallace Tree Multiplier into a 3-stage pipelined architecture. 

## 2. Experimental Setup
*   **Hardware Description Language:** Verilog
*   **Synthesis & Implementation Tool:** Xilinx ISE Design Suite 14.7
*   **Target FPGA Device:** Spartan-3E (xc3s500e, fg320, -4 speed grade)
*   **Analysis Method:** Post-Place & Route (PAR) Static Timing Analysis. *(Note: Post-PAR analysis is utilized instead of simple Synthesis estimates to account for real physical wire routing delays on the FPGA silicon).*

## 3. Raw Data (Post-PAR Reports)

| Performance Metric | Unpipelined (Baseline) | Pipelined (3-Stage) |
| :--- | :--- | :--- |
| **Minimum Clock Period** | 7.428 ns | 4.014 ns |
| **Maximum Frequency** | 134.626 MHz | 249.128 MHz |
| **Slice LUTs (Logic)** | 36 | 35 |
| **Slice Flip-Flops (Registers)**| 16 | 37 |

## 4. Data Analysis & Calculations

### 4.1 Critical Path Reduction
By inserting pipeline registers, the long combinational path of the Wallace tree was divided into three shorter stages.
*   Unpipelined Delay: 7.428 ns
*   Pipelined Delay: 4.014 ns
*   **Delay Reduction:** `((7.428 - 4.014) / 7.428) * 100` = **45.96% faster**

### 4.2 Throughput Improvement (Max Frequency)
Because the critical path was shortened, the maximum clock frequency at which the FPGA can safely operate increased significantly.
*   **Formula:** `((Pipelined MHz - Unpipelined MHz) / Unpipelined MHz) * 100`
*   **Math:** `((249.128 - 134.626) / 134.626) * 100`
*   **Result:** **85.05% Throughput Improvement**

### 4.3 Area-Speed Trade-off
*   **Logic LUTs:** Remained virtually identical (36 vs 35), proving that the pipeline does not increase the core logic gate count.
*   **Registers:** Increased by 21 Flip-Flops (from 16 to 37). This is the expected overhead of adding a 3-stage pipeline.
*   **Conclusion:** The design successfully traded a minor increase in register area (Flip-Flops) for an **85% increase in computational throughput**.

## 5. Conclusion
The synthesis results validate the theoretical benefits of pipelining. By breaking the combinational critical path of the Wallace Tree Multiplier, the system achieved a maximum operating frequency of **249.12 MHz**, operating nearly twice as fast as the unpipelined baseline with negligible logic overhead.
