local ambitionsPrint = require ('Ambitions.shared.lib.log.print')

MySQL.ready(function()
  ambitionsPrint.debug("MySQL is ready, messsage sent from multicharacter")
end)