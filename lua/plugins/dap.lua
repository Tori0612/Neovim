return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require('dap')
    dap.configurations.java = {
      {
        type = 'java',
        request = 'launch',
        name = 'Debug Java',
        program = '${file}',
        javaPath = '/usr/lib/jvm/java-21-openjdk/bin/java',
      },
    }
  end
}
