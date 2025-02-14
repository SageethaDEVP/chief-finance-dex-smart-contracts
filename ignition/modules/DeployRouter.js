const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");



module.exports = buildModule("LocModule", (m) => {
  const address1 = m.getParameter("address1","0x8D5F686e8d3F91678a8E2F3B327eFD8533567146");
  
  const lock = m.contract("SwapRouterV2", ["0x46e1443bF8F2c1F57dCC093bd29188087D7B71B7","0xC532a74256D3Db42D0Bf7a0400fEFDbad7694008","0xCa3949080ce2c1134dbc0BEf36F0cB49f44B918D"], {
    
  });

  return { lock };
});
