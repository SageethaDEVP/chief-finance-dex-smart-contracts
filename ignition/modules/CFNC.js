const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");



module.exports = buildModule("CFNC", (m) => {
  const address1 = m.getParameter("address1","0x8D5F686e8d3F91678a8E2F3B327eFD8533567146");
  

  const CFNC = m.contract("CFNC", ["1000000000000000000000000000000"], {
    
  });

  return { CFNC };
});
