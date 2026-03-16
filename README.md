# Lab 2
**Group 1**

March 16, 2026

*Arjun Babu Anand, s252759*

*Benedicte Manon Elgaard Jensen, s201905*

*Ibtihal Alkaseb, s215513*

*Rose Carbery Timlin, s260105*

***
## Work distribution
Each person does both parts of work on two components.
### Arjun
- **Initial-token buffer**, *Arjun*
- **two-way copy**, *Arjun*
### Benedicte
- **Source**, *Benedicte*
- **two-way demux**, *Benedicte*
### Ibtihal
- **Sink**, *Ibtihal*
- **two-way mux**, *Ibtihal*
### Rose
- **One-place-buffer**, *Rose*
- **two-input function**, *Rose*

***
The goal of this lab is to write ACT-CHP descriptions of data flow elements, run synthesis and simulate them to verify correct behavior.
***

# Arjun Babu Anand, s252759
### Part 1: CHP

ACT descriptions of dataflow components Twoway Copy and token buff:
```
tokenbuf_2waycopy.act
```
Test files :
```
test_tokenbuf_2waycopy.act
```
scripts used for simulations:
```
test_tokenbuf_2waycopy.scr
```

### Part 2: Synthesis
ACT synthesis of sink and mux:
```
twoway_copy_prs.act
token_buf_prs.act
```
Datapath files for sink and mux:
```
datapath_token_buf.act
datapath_twoway_copy.act
```
scripts used for simulations:
```
test_twoway_copy_prs.scr
test_token_buf_prs.scr
```

## How to run## Testing

### Part 1

1. **Test `test_token_buff`**

Run:
``` 
actsim test_tokenbuf_2waycopy.act 'test_token_buff'
```

Then in the CLI run:
```
source test_tokenbuf_2waycopy.scr
```

2. **Test `test_twoway_copy`**

Run:
```
actsim test_tokenbuf_2waycopy.act 'test_twoway_copy'
```

Then in the CLI run:
```
source test_tokenbuf_2waycopy.scr
```

---

### Part 2

1. **Test `sdt_test_token_buff`**

Run:
```
actsim -ref=1 -Tsky130l token_buf_prs.act 'sdt_test_token_buff'
```

Then in the CLI run:
```
source test_token_buf_prs.scr
```

2. **Test `sdt_test_twoway_copy`**

Run:
```
actsim -ref=1 -Tsky130l twoway_copy_prs.act 'sdt_test_twoway_copy'
```

Then in the CLI run:
```
source test_twoway_copy_prs.scr
```
***

***

# Benedicte Manon Elgaard Jensen, s201905

***

# Ibtihal Alkaseb, s215513

## Files included
### Part 1: CHP

ACT descriptions of dataflow components sink and mux:
```
sink.act
mux.act
```
Test files for sink and mux:
```
test_sink.act
test_mux.act
```
scripts used for simulations:
```
test_sink.scr
test_mux.scr
```

### Part 2: Synthesis
ACT synthesis of sink and mux:
```
sink_prs.act
mux_prs.act
```
Datapath files for sink and mux:
```
sink_datapath.act
mux_datapath.act
```
scripts used for simulations:
```
test_sink_prs.scr
test_mux_prs.scr
```
***

## Testing

### Part 1: CHP

**Sink**

To verify sink at CHP level, run
```actsim -Wlang_subst:off test_sink.act test``` then load the script ```test_sink.scr```.

The source sends incrementing 8-bit values to the sink, and the sink receives and prints them.

Expected output:
```
[                  10] <si>  c: recv-blocked
[                  20] <so>  c : send value: 0 (0x0)
[                  20] <si>  c: recv-wakeup value: 0 (0x0)   [by so]
[                  20] <si>  Sink received the following value from source: 0
[                  30] <si>  c: recv-blocked
[                  40] <so>  c : send value: 1 (0x1)
[                  40] <si>  c: recv-wakeup value: 1 (0x1)   [by so]
[                  40] <si>  Sink received the following value from source: 1
.                   .                                                       .                                                         
.                   .                                                       .
.                   .                                                       .
[                1970] <si>  c: recv-blocked
[                1980] <so>  c : send value: 98 (0x62)
[                1980] <si>  c: recv-wakeup value: 98 (0x62)   [by so]
[                1980] <si>  Sink received the following value from source: 98
[                1990] <si>  c: recv-blocked
[                2000] <so>  c : send value: 99 (0x63)
[                2000] <si>  c: recv-wakeup value: 99 (0x63)   [by so]
[                2000] <si>  Sink received the following value from source: 99
```
This verifies that the sink `si` receives the correct values from the source `so` in order.


**Mux**

To verify mux at CHP level, run
``` actsim -Wlang_subst:off test_mux.act test``` then load the script ```test_mux.scr```.

Expected output:
```
[                  10] <si>  y: recv-blocked
[                  10] <m>  s: recv-blocked
[                  10] <sa>  a : send-blocked value: 10 (0xa)
[                  10] <sb>  b : send-blocked value: 20 (0x14)
[                  10] <ss>  s : send value: 0 (0x0)
[                  10] <m>  s: recv-wakeup value: 0 (0x0)   [by ss]
[                  20] <ss>  s : send-blocked value: 1 (0x1)
[                  20] <m>  a: recv value: 10 (0xa)
[                  20] <sa>  a : send complete   [by m]
[                  30] <sa>  a : send-blocked value: 100 (0x64)
[                  30] <m>  y : send value: 10 (0xa)
[                  30] <si>  y: recv-wakeup value: 10 (0xa)   [by m]
[                  30] <si>  mux output: 10
.                    .                                             .
.                    .                                             .
.                    .                                             .
[                 100] <si>  y: recv-blocked
[                 100] <m>  s: recv value: 1 (0x1)
[                 100] <ss>  s : send complete   [by m]
[                 110] <m>  b: recv value: 200 (0xc8)
[                 110] <sb>  b : send complete   [by m]
[                 120] <m>  y : send value: 200 (0xc8)
[                 120] <si>  y: recv-wakeup value: 200 (0xc8)   [by m]
[                 120] <si>  mux output: 200

```
This verifies that the mux `m` correctly forwards data from the selected input channel to the output. When the select `ss` sends 0, values from input `a` are sent to the sink `si`, and when `ss` sends 1, values from input `b` are sent instead.

### Part 2: Synthesis
**Sink**

The sink was sythesized by runing the following command:

```chp2prs -b -o abc -e sink_datapath.act test_sink.act test sink_prs.act```

To verify sink at PRS level, run
``` actsim -ref=1 -Tsky130l sink_prs.act sdt_test```
then load the script ```test_sink_prs.scr```.

Expected output:
```
[                2940] <so.delayblk10.d[0].inx2>  c.r := 1
[                3200] <si.var_x.ports.w.iy>  c.a := 1
[                3250] <so.delayblk10.d[0].inx2>  c.r := 0
[                3510] <si.var_x.ports.w.iy>  c.a := 0
[                4840] <so.e9._passthru_.g0>  c.d[0] := 1
[                6800] <so.delayblk10.d[0].inx2>  c.r := 1
[                7060] <si.var_x.ports.w.iy>  c.a := 1
[                7110] <so.delayblk10.d[0].inx2>  c.r := 0
[                7370] <si.var_x.ports.w.iy>  c.a := 0
.                    .                                   .
.                    .                                   .
.                    .                                   .
```
This verifies that channel c performs repeated four-phase handshakes:

- source raises request `(c.r := 1)`

- sink raises acknowledge `(c.a := 1)`

- source lowers request `(c.r := 0)`

- sink lowers acknowledge `(c.a := 0)`

The data bits `c.d[0]` to `c.d[7]` represent the transmitted 8-bit values.

Obs. Internal warnings such as unstable transition and weak-interference may appear during PRS simulation, but correct operation is verified by the successful repeated request/acknowledge handshake.

**Mux**

The mux was sythesized by runing the following command:

```chp2prs -b -o abc -e mux_datapath.act test_mux.act test mux_prs.act```

To verify sink at PRS level, run
``` actsim -ref=1 -Tsky130l mux_prs.act sdt_test```
then load the script ```test_mux_prs.scr```.

Expected output:
```
.                    .                                                                                                      .  
.                    .                                                                                                      .  
.                    .                                                                                                      .  
[                1200] <sb.b_muxo.dly_req.d[19].inx2>  b.r := 1
[                1200] <sa.a_muxo.dly_req.d[19].inx2>  a.r := 1
[                1200] <ss.sel_muxo.dly_req.d[19].inx2>  s.r := 1
[                1460] <m.var_s.w.iy>  s.a := 1
[                1950] <ss.sel_muxo.dly_req.d[19].inx2>  s.r := 0
[                2210] <m.var_s.w.iy>  s.a := 0
[                2300] <ss.sel_muxo._mux[0][1]>  WARNING: weak-interference on `_Y'   [by ss.s_6.f[1].r.d.d[0] <- 1]
[                2301] <ss.sel_muxo._mux[0][1]>  WARNING: weak-interference on `Y'   [by ss.sel_muxo._mux[0][1]._Y <- X]
[                2302] <ss.sel_muxo.ortr[0]>  WARNING: weak-interference on `tmp[6]'   [by ss.sel_muxo._mux[0][1].Y <- X]
[                2303] <ss.sel_muxo.ortr[0]>  WARNING: weak-interference on `out'   [by ss.sel_muxo.ortr[0].tmp[6] <- X]
[                2304] <ss.sel_muxo.ortr[0]>  s.d[0] := X   [by ss.sel_muxo.ortr[0].tmp[6] <- X]
[                2304] <m.var_s.w.id[0]>  WARNING: weak-interference on `Y'   [by ss.sel_muxo.ortr[0].out <- X]
[                2720] <ss.sel_muxo.dly_req.d[19].inx2>  s.r := 1
[                2941] <m.var_xa.w.gwt[1]>  WARNING: weak-interference on `Y'   [by m.var_xa.w.gwt[1].A <- X]
[                2941] <m.var_xa.w.gwf[1]>  WARNING: weak-interference on `Y'   [by m.var_xa.w.gwf[1].A <- X]
[                2941] <m.var_xa.w.gwf[3]>  WARNING: weak-interference on `Y'   [by m.var_xa.w.gwf[3].A <- X]
[                2941] <m.var_xa.w.gwt[3]>  WARNING: weak-interference on `Y'   [by m.var_xa.w.gwt[3].A <- X]
[                2942] <m.var_xa.x.bits[3]>  WARNING: weak-interference on `df'   [by m.var_xa.w.gwt[3].Y <- X]
[                2942] <m.var_xa.x.bits[1]>  WARNING: weak-interference on `df'   [by m.var_xa.w.gwt[1].Y <- X]
[                2943] <m.var_xa.x.bits[3]>  WARNING: weak-interference on `dt'   [by m.var_xa.x.bits[3].df <- X]
[                2943] <m.var_xa.x.bits[1]>  WARNING: weak-interference on `dt'   [by m.var_xa.x.bits[1].df <- X]
[                2944] <m.var_xa.x.bits[3]>  WARNING: weak-interference on `df'   [by m.var_xa.x.bits[3].dt <- X]
[                2944] <m.e12._passthru_.g3>  WARNING: weak-interference on `_Y'   [by m.var_xa.x.bits[3].dt <- X]
[                2944] <m.var_xa.x.bits[1]>  WARNING: weak-interference on `df'   [by m.var_xa.x.bits[1].dt <- X]
[                2944] <m.e12._passthru_.g1>  WARNING: weak-interference on `_Y'   [by m.var_xa.x.bits[1].dt <- X]
[                2945] <m.e12._passthru_.g3>  WARNING: weak-interference on `Y'   [by m.e12._passthru_.g3._Y <- X]
[                2945] <m.e12._passthru_.g1>  WARNING: weak-interference on `Y'   [by m.e12._passthru_.g1._Y <- X]
[                3160] <m.var_xa.w.iy>  a.a := 1
[                3650] <sa.a_muxo.dly_req.d[19].inx2>  a.r := 0
[                3710] <m.var_xa.x.bits[1]>  WARNING: weak-interference on `df'   [by m.var_xa.w.gwt[1].Y <- 0]
[                3710] <m.var_xa.x.bits[3]>  WARNING: weak-interference on `df'   [by m.var_xa.w.gwt[3].Y <- 0]
[                3710] <m.var_xa.x.bits[3]>  WARNING: weak-interference on `dt'   [by m.var_xa.w.gwf[3].Y <- 0]
[                3710] <m.var_xa.x.bits[1]>  WARNING: weak-interference on `dt'   [by m.var_xa.w.gwf[1].Y <- 0]
[                3910] <m.var_xa.w.iy>  a.a := 0
[                3980] <m.y_muxo._mux[3][0]>  WARNING: weak-interference on `_Y'   [by m.delayblk13.d[0].inx2.Y <- 1]
[                3980] <m.y_muxo._mux[1][0]>  WARNING: weak-interference on `_Y'   [by m.delayblk13.d[0].inx2.Y <- 1]
[                3981] <m.y_muxo._mux[3][0]>  WARNING: weak-interference on `Y'   [by m.y_muxo._mux[3][0]._Y <- X]
[                3981] <m.y_muxo._mux[1][0]>  WARNING: weak-interference on `Y'   [by m.y_muxo._mux[1][0]._Y <- X]
[                3982] <m.y_muxo.ortr[3]>  WARNING: weak-interference on `tmp[2]'   [by m.y_muxo._mux[3][0].Y <- X]
[                3982] <m.y_muxo.ortr[1]>  WARNING: weak-interference on `tmp[2]'   [by m.y_muxo._mux[1][0].Y <- X]
[                3983] <m.y_muxo.ortr[3]>  WARNING: weak-interference on `out'   [by m.y_muxo.ortr[3].tmp[2] <- X]
[                3983] <m.y_muxo.ortr[1]>  WARNING: weak-interference on `out'   [by m.y_muxo.ortr[1].tmp[2] <- X]
[                3984] <si.var_x.ports.w.id[3]>  WARNING: weak-interference on `Y'   [by m.y_muxo.ortr[3].out <- X]
[                3984] <si.var_x.ports.w.id[1]>  WARNING: weak-interference on `Y'   [by m.y_muxo.ortr[1].out <- X]
[                4000] <sa.a_muxo._mux[2][1]>  WARNING: weak-interference on `_Y'   [by sa.s_3.f[1].r.d.d[0] <- 1]
[                4000] <sa.a_muxo._mux[5][1]>  WARNING: weak-interference on `_Y'   [by sa.s_3.f[1].r.d.d[0] <- 1]
[                4000] <sa.a_muxo._mux[6][1]>  WARNING: weak-interference on `_Y'   [by sa.s_3.f[1].r.d.d[0] <- 1]
[                4001] <sa.a_muxo._mux[6][1]>  WARNING: weak-interference on `Y'   [by sa.a_muxo._mux[6][1]._Y <- X]
[                4001] <sa.a_muxo._mux[2][1]>  WARNING: weak-interference on `Y'   [by sa.a_muxo._mux[2][1]._Y <- X]
[                4001] <sa.a_muxo._mux[5][1]>  WARNING: weak-interference on `Y'   [by sa.a_muxo._mux[5][1]._Y <- X]
[                4002] <sa.a_muxo.ortr[2]>  WARNING: weak-interference on `tmp[3]'   [by sa.a_muxo._mux[2][1].Y <- X]
[                4002] <sa.a_muxo.ortr[5]>  WARNING: weak-interference on `tmp[3]'   [by sa.a_muxo._mux[5][1].Y <- X]
[                4002] <sa.a_muxo.ortr[6]>  WARNING: weak-interference on `tmp[3]'   [by sa.a_muxo._mux[6][1].Y <- X]
[                4003] <sa.a_muxo.ortr[5]>  WARNING: weak-interference on `out'   [by sa.a_muxo.ortr[5].tmp[3] <- X]
[                4003] <sa.a_muxo.ortr[6]>  WARNING: weak-interference on `out'   [by sa.a_muxo.ortr[6].tmp[3] <- X]
[                4003] <sa.a_muxo.ortr[2]>  WARNING: weak-interference on `out'   [by sa.a_muxo.ortr[2].tmp[3] <- X]
[                4004] <m.var_xa.w.id[6]>  WARNING: weak-interference on `Y'   [by sa.a_muxo.ortr[6].out <- X]
[                4004] <m.var_xa.w.id[2]>  WARNING: weak-interference on `Y'   [by sa.a_muxo.ortr[2].out <- X]
[                4004] <m.var_xa.w.id[5]>  WARNING: weak-interference on `Y'   [by sa.a_muxo.ortr[5].out <- X]
[                4400] <m.y_muxo.dly_req.d[19].inx2>  y.r := 1
[                4420] <sa.a_muxo.dly_req.d[19].inx2>  a.r := 1
[                4441] <si.var_x.ports.w.gwt[1]>  WARNING: weak-interference on `Y'   [by si.var_x.ports.w.gwt[1].A <- X]
[                4441] <si.var_x.ports.w.gwf[1]>  WARNING: weak-interference on `Y'   [by si.var_x.ports.w.gwf[1].A <- X]
[                4441] <si.var_x.ports.w.gwf[3]>  WARNING: weak-interference on `Y'   [by si.var_x.ports.w.gwf[3].A <- X]
[                4441] <si.var_x.ports.w.gwt[3]>  WARNING: weak-interference on `Y'   [by si.var_x.ports.w.gwt[3].A <- X]
[                4442] <si.var_x.ports.x.bits[3]>  WARNING: weak-interference on `df'   [by si.var_x.ports.w.gwt[3].Y <- X]
[                4442] <si.var_x.ports.x.bits[1]>  WARNING: weak-interference on `df'   [by si.var_x.ports.w.gwt[1].Y <- X]
[                4443] <si.var_x.ports.x.bits[3]>  WARNING: weak-interference on `dt'   [by si.var_x.ports.x.bits[3].df <- X]
[                4443] <si.var_x.ports.x.bits[1]>  WARNING: weak-interference on `dt'   [by si.var_x.ports.x.bits[1].df <- X]
[                4444] <si.var_x.ports.x.bits[3]>  WARNING: weak-interference on `df'   [by si.var_x.ports.x.bits[3].dt <- X]
[                4444] <si.var_x.ports.x.bits[1]>  WARNING: weak-interference on `df'   [by si.var_x.ports.x.bits[1].dt <- X]
[                4660] <si.var_x.ports.w.iy>  y.a := 1
[                5170] <m.y_muxo.dly_req.d[19].inx2>  y.r := 0
.                    .                                                                                                      .  
.                    .                                                                                                      .  
.                    .                                                                                                      . 
```
This verifies that the select `s` and data channels `a, b, y` perform repeated four-phase handshakes:

- b, a, and s sources raises request `(b.r := 1)`, `(a.r := 1)`, `(s.r := 1)`

- s raises acknowledge `(s.a := 1)`

- a raises acknowledge `(a.a := 1)`

- a lowers request `(a.r := 0)`

- y raises request `(y.r := 1)`

- y lowers acknowledge `(y.a := 0)`

and so on.

Obs. Internal warnings such as weak-interference and temporary unknown values (X) may appear during PRS simulation.
These occur due to transient signal conflicts and gate-level timing effects in the synthesized asynchronous circuit, where internal nodes may momentarily drive different values before the handshake protocol stabilizes.
***

# Rose Carbery Timlin, s260105

## Files included

ACT descriptions of dataflow components one-place buffer and adder:
```
src/adder.act
src/oneplace.act
```
Testing ACT code:
```
test.act
test_prs.act
```
Final testing scripts:
```
test_pt1.sh 
test_pt2.sh
```
***

## How to run:
Make the two testing scripts executable with `chmod +x <script>`, then run them with 
`./test_pt1.sh` and `./test_pt2.sh`. 
The testing script for part 1 will automatically run the testing routines for each part,
and the script for part two will first synthesize prs code for each component, 
then test it under the same scenarios.
