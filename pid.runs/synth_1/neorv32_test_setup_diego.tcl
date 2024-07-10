# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "C:/Users/diego/TFG/pid/pid.runs/synth_1/neorv32_test_setup_diego.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

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
OPTRACE "synth_1" START { ROLLUP_AUTO }
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/diego/TFG/pid/pid.cache/wt [current_project]
set_property parent.project_path C:/Users/diego/TFG/pid/pid.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/diego/TFG/pid/pid.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_vhdl -library neorv32 {
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_package.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/rtl/core/neorv32_application_image.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_boot_rom.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_bootloader_image.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_intercon.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cache.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cfs.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_clockgate.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_fifo.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_decompressor.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_control.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_regfile.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_cp_shifter.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_cp_muldiv.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_cp_bitmanip.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_cp_fpu.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_cp_cfu.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_cp_cond.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_alu.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_lsu.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu_pmp.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_cpu.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_crc.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_debug_dm.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_debug_dtm.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_dma.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_dmem.entity.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/mem/neorv32_dmem.default.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_gpio.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_gptmr.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_imem.entity.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/mem/neorv32_imem.default.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_mtime.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_neoled.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_onewire.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_pwm.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_sdi.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_slink.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_spi.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_sysinfo.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_xip.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_xbus.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_wdt.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_uart.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_twi.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_trng.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_xirq.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/core/neorv32_top.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/Filter_HALL.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/PID_HALLFSM.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/PID_TOPSENSOR.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/new/RampGenerator.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/SYNCHRNZR.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/cambio_digsel.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/decoder.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/new/gen_frec.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/pid_gen.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/new/pid_top.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/new/pulse_counter.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/pwm_decod.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/pwm_gen.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/pwm_top.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/new/ralent.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/separator.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/imports/new/top_display.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/new/control_top.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/new/top_gpio.vhd
  C:/Users/diego/TFG/pid/pid.srcs/sources_1/imports/sources_1/new/neorv32_test_setup_diego.vhd
}
OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/diego/TFG/pid/pid.srcs/constrs_1/imports/Downloads/Nexys-4-DDR-Master.xdc
set_property used_in_implementation false [get_files C:/Users/diego/TFG/pid/pid.srcs/constrs_1/imports/Downloads/Nexys-4-DDR-Master.xdc]

set_param ips.enableIPCacheLiteLoad 1

read_checkpoint -auto_incremental -incremental C:/Users/diego/TFG/pid/pid.srcs/utils_1/imports/synth_1/pid_gen.dcp
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top neorv32_test_setup_diego -part xc7a100tcsg324-1
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef neorv32_test_setup_diego.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
create_report "synth_1_synth_report_utilization_0" "report_utilization -file neorv32_test_setup_diego_utilization_synth.rpt -pb neorv32_test_setup_diego_utilization_synth.pb"
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
