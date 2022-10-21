local groups = require("groups-highlight")

return function()
  return {
    DiagnosticError = groups.Error,
    DiagnosticWarn = groups.Warn,
    DiagnosticHint = groups.Hint,
    DiagnosticInfo = groups.Info,
  }
end
