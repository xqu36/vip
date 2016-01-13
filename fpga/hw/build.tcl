# Set the reference directory for source file relative paths (by default the value is script directory path)
set origin_dir [file dirname [info script]]

# Set the directory path for the original project from where this script was exported
set orig_proj_dir "[file normalize "$origin_dir/project"]"

# Create project 
create_project zedboard_baseline $origin_dir/project

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [get_projects zedboard_baseline]
set_property "board_part" "em.avnet.com:zed:part0:1.2" $obj
set_property "default_lib" "xil_defaultlib" $obj
set_property "simulator_language" "Mixed" $obj
set_property "target_language" "VHDL" $obj

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set IP repository paths
set obj [get_filesets sources_1]
set_property "ip_repo_paths" "[file normalize "$origin_dir/ip_repo"]" $obj

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set_property "top" "zedboard_baseline_wrapper" $obj

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Add/Import constrs file and set constrs file properties
set file "[file normalize "$origin_dir/src/bd/ZED_Master.xdc"]"
set file_added [add_files -norecurse -fileset $obj $file]
set file "$origin_dir/src/bd/ZED_Master.xdc"

set file [file normalize $file]

set file_obj [get_files -of_objects [get_filesets constrs_1] [list "*$file"]]
set_property "file_type" "XDC" $file_obj

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property "top" "zedboard_baseline_wrapper" $obj

# Create 'synth_1' run (if not found)
if {[string equal [get_runs -quiet synth_1] ""]} {
  create_run -name synth_1 -part xc7z020clg484-1 -flow {Vivado Synthesis 2014} -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2014" [get_runs synth_1]
}
set obj [get_runs synth_1]

# set the current synth run
current_run -synthesis [get_runs synth_1]

# Create 'impl_1' run (if not found)
if {[string equal [get_runs -quiet impl_1] ""]} {
  create_run -name impl_1 -part xc7z020clg484-1 -flow {Vivado Implementation 2014} -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2014" [get_runs impl_1]
}
set obj [get_runs impl_1]

set_property "part" "xc7z020clg484-1" $obj

# set the current impl run
current_run -implementation [get_runs impl_1]

# Update repo catalog
update_ip_catalog -rebuild

# Create Block Design
source $origin_dir/src/bd/zedboard_baseline.tcl
regenerate_bd_layout

# Generate Wrapper 
make_wrapper -files [get_files $design_name.bd] -top -import
validate_bd_design

# Generate output products
generate_target all [get_files $origin_dir/project/zedboard_baseline.srcs/sources_1/bd/zedboard_baseline/zedboard_baseline.bd]

# Run synthesis
launch_runs synth_1
wait_on_run synth_1

# run impl
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

# Export HW
file mkdir $origin_dir/project/zedboard_baseline.sdk
file copy -force $origin_dir/project/zedboard_baseline.runs/impl_1/zedboard_baseline_wrapper.sysdef $origin_dir/project/zedboard_baseline.sdk/zedboard_baseline_wrapper.hdf

puts "INFO: Project built:zedboard_baseline"
