# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param chipscope.maxJobs 1
create_project -in_memory -part xc7a200tfbg676-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/incolore/corewave/vivado/cpu/cpu.cache/wt [current_project]
set_property parent.project_path /home/incolore/corewave/vivado/cpu/cpu.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/incolore/corewave/vivado/cpu/cpu.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog /home/incolore/corewave/src/defines.v
set_property file_type "Verilog Header" [get_files /home/incolore/corewave/src/defines.v]
read_verilog -library xil_defaultlib {
  /home/incolore/corewave/src/cpu/ctrl.v
  /home/incolore/corewave/src/cpu/div.v
  /home/incolore/corewave/src/cpu/ex.v
  /home/incolore/corewave/src/cpu/ex_mem.v
  /home/incolore/corewave/src/cpu/hilo_reg.v
  /home/incolore/corewave/src/cpu/id.v
  /home/incolore/corewave/src/cpu/id_ex.v
  /home/incolore/corewave/src/cpu/if_id.v
  /home/incolore/corewave/src/cpu/inst_rom.v
  /home/incolore/corewave/src/cpu/mem.v
  /home/incolore/corewave/src/cpu/mem_wb.v
  /home/incolore/corewave/src/cpu/openmips.v
  /home/incolore/corewave/src/cpu/pc_reg.v
  /home/incolore/corewave/src/cpu/regfile.v
  /home/incolore/corewave/src/cpu/openmips_min_sopc.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/incolore/corewave/vivado/cpu/cpu.srcs/constrs_1/new/fpga_pins.xdc
set_property used_in_implementation false [get_files /home/incolore/corewave/vivado/cpu/cpu.srcs/constrs_1/new/fpga_pins.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top openmips_min_sopc -part xc7a200tfbg676-2


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef openmips_min_sopc.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file openmips_min_sopc_utilization_synth.rpt -pb openmips_min_sopc_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
