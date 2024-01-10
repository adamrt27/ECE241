# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part1.v

#load simulation using mux as the top level simulation module
vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# first test case
#set input values using the force command, signal names need to be in {} brackets
force {a[0]} 0
force {a[1]} 1
force {a[2]} 1
force {a[3]} 0
force {b[0]} 0
force {b[1]} 1
force {b[2]} 1
force {b[3]} 0
force {c_in} 0
#run simulation for a few ns
run 10ns

force {a[0]} 0
force {a[1]} 0
force {a[2]} 0
force {a[3]} 0
force {b[0]} 0
force {b[1]} 0
force {b[2]} 0
force {b[3]} 0
force {c_in} 0
#run simulation for a few ns
run 10ns

force {a[0]} 1
force {a[1]} 0
force {a[2]} 0
force {a[3]} 0
force {b[0]} 0
force {b[1]} 0
force {b[2]} 0
force {b[3]} 0
force {c_in} 0
#run simulation for a few ns
run 10ns

force {a[0]} 0
force {a[1]} 1
force {a[2]} 0
force {a[3]} 0
force {b[0]} 0
force {b[1]} 0
force {b[2]} 0
force {b[3]} 0
force {c_in} 1
#run simulation for a few ns
run 10ns

force {a[0]} 0
force {a[1]} 1
force {a[2]} 1
force {a[3]} 1
force {b[0]} 1
force {b[1]} 0
force {b[2]} 0
force {b[3]} 0
force {c_in} 0
#run simulation for a few ns
run 10ns


