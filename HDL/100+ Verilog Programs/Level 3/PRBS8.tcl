# Make sure you run this from inside vivado, you will get error if you run from standard tcl shell 


puts "Running PRBS_G8b Test Script"
cd {-- Your working directory, where the .v file is present }
set module_name "PRBS_G8b"
set source_file {PRBS_G8b.v}
set clk_period_ns 1
set buffer_file ./PRBS_G8b_output.txt
set count_buffer {}

add_files $source_file
set_property top $module_name [current_fileset]
launch_simulation

puts "Initializing signals..."
add_force {/PRBS_G8b/clk} -radix hex {1 0ns} {0 500ps} -repeat_every 1000ps
add_force {/PRBS_G8b/rst_} -radix hex {0 0ns}
add_force {/PRBS_G8b/ld} -radix hex {1 0ns}
set seed 11010011
add_force {/PRBS_G8b/data} -radix bin $seed 0ns

run 1ns
add_force {/PRBS_G8b/rst_} -radix hex {1 0ns}
add_force {/PRBS_G8b/ld} -radix hex {1 0ns}

run 1ns
add_force {/PRBS_G8b/rst_} -radix hex {1 0ns}
add_force {/PRBS_G8b/ld} -radix hex {0 0ns}

puts "Running Simulation for 255 Sequences"

lappend count_buffer "255 Sequences of PRBS8 (L=8) for Initial seed : $seed\n"

for {set i 0} {$i < 256} {incr i} {
    
    set PRN_value [get_value PRN -radix bin]
set PRN1_value [get_value PRN1 -radix bin]
set result " PRN : $PRN_value \t PRN1 : $PRN1_value "
    lappend count_buffer  $result
    
     
    run 1ns
}

 
puts "Writing buffer values to file..."
set fp [open $buffer_file w]
foreach value $count_buffer {
    puts $fp $value
}
close $fp

 
puts "Simulation complete. Results saved in $buffer_file"

close_sim

exec notepad.exe ./PRBS_G8b_output.txt

exit
quit
