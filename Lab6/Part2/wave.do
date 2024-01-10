# set the working dir, where all compiled verilog goes

vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.v

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# Start Clock
force {Clock} 0 0ns, 1 {5ns} -r 10ns

# Input A = 2
force Resetn 0
force {DataIn[0]} 0
force {DataIn[1]} 1
force {DataIn[2]} 0
force {DataIn[3]} 0
force {DataIn[4]} 0
force {DataIn[5]} 0
force {DataIn[6]} 0
force {DataIn[7]} 0
run 10 ns


force Resetn 1
force Go 1
run 10 ns

# Input B = 1
force Go 0
force {DataIn[0]} 1
force {DataIn[1]} 0
force {DataIn[2]} 0
force {DataIn[3]} 0
force {DataIn[4]} 0
force {DataIn[5]} 0
force {DataIn[6]} 0
force {DataIn[7]} 0
run 10 ns

force Go 1
run 10 ns

# Input C = 2
force Go 0
force {DataIn[0]} 0
force {DataIn[1]} 1
force {DataIn[2]} 0
force {DataIn[3]} 0
force {DataIn[4]} 0
force {DataIn[5]} 0
force {DataIn[6]} 0
force {DataIn[7]} 0
run 10 ns

force Go 1
run 10 ns

# Input X = 2
force Go 0
force {DataIn[0]} 1
force {DataIn[1]} 1
force {DataIn[2]} 0
force {DataIn[3]} 0
force {DataIn[4]} 0
force {DataIn[5]} 0
force {DataIn[6]} 0
force {DataIn[7]} 0
run 10 ns

force Go 1
run 10 ns

# run
force Go 0
run 100 ns

# A = 2, X = 2, B = 1, C = 3 -> 9
# A = 2, X = 3, B = 1, C = 3 -> 12
# A = 0, X = 3, B = 1, C = 3 -> 6

# issue is x^2 operation - fixed