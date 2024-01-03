; Pause macro file
if !exists(global.cancel_statistics)
  global cancel_statistics = ""
set global.cancel_statistics = """" ^ job.file.fileName ^ """," ^ state.time ^ "," ^ job.duration ^ ",0," ^ job.rawExtrusion

M83					; relative extruder moves
G1 E-3 F2500		; retract 3mm
G91					; relative moves
G1 Z2 F5000			; raise nozzle 2mm
G90					; absolute moves
M98 P"k/purge-bucket.g"
;G1 X0 Y85 F5000		; move head out of the way of the print
M150 E1 R255 B255 P192 S1 F0