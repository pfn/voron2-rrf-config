var begin = 0.030
var end = 0.060
var increment = 0.003
var layer_count = 0

if !exists(job.file.numLayers)
  if !exists(param.L)
    abort "Missing layer count"
  set var.layer_count = param.L

var step_count = {floor((var.end - var.begin) / var.increment)}
var layer_step_size = {floor(var.layer_count / var.step_count)}
if mod(job.layer, var.layer_step_size) == 0
  var steps = job.layer / var.layer_step_size
  var pa_value = {var.steps * var.increment + var.begin}
  echo "Pressure advance set to " ^ {var.pa_value} ^ " at layer=" ^ {job.layer} ^ " for " ^ {var.layer_step_size} ^ " layers"
  M572 D0 S{var.pa_value}