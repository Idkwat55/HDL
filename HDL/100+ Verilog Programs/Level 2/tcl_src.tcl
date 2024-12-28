# TCL Script for Vivado Simulation (xsim)

# Set parameters
#cd {%userprofile%\Documents\Me\Project\100 program Level 2\100 program Level 2.srcs\sources_1\new}

#use cd to set your working dir, an example is given above

set module_name "grayCode_counter"
set source_file {grayCode_counter.v}
set clk_period_ns 1
set buffer_file ./grayCode_counter_output.txt
set count_buffer {}

# Compile the design and launch simulation
add_files $source_file
set_property top $module_name [current_fileset]
launch_simulation

# Force signals: Initialize clk, rst_, and d
puts "Initializing signals..."
add_force {/grayCode_counter/clk} -radix hex {1 0ns} {0 500ps} -repeat_every 1000ps
add_force {/grayCode_counter/rst_} -radix hex {0 0ns}
add_force {/grayCode_counter/d} -radix hex {1 0ns}

# Run for one clock cycle
run 1ns

# Set rst_ to 1 and run simulation for 16 clock cycles
puts "Setting rst_ to 1 and capturing count values..."
add_force {/grayCode_counter/rst_} -radix hex {1 0ns}

for {set i 0} {$i < 16} {incr i} {
    # Capture the value of 'count'
    set count_value [get_value count -radix bin]
    lappend count_buffer $count_value
    
    # Run for one clock cycle
    run 1ns
}

# Write the count buffer to a text file
puts "Writing buffer values to file..."
set fp [open $buffer_file w]
foreach value $count_buffer {
    puts $fp $value
}
close $fp

# Finish simulation
puts "Simulation complete. Results saved in $buffer_file"
 
