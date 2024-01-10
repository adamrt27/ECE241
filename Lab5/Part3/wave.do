# set the working dir, where all compiled verilog goes

vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.v

#load simulation using mux as the top level simulation module
vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# Start Clock
force {ClockIn} 0 0ms, 1 {5ms} -r 10ms

# Reset
force Reset 0
force {Letter[0]} 0
force {Letter[1]} 0
force {Letter[2]} 0
force Start 1

run 10ms

force Reset 0
force Start 0

run 120ms
