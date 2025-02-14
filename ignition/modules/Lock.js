const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");



module.exports = buildModule("LocModule", (m) => {
  const address1 = m.getParameter("address1","0x8D5F686e8d3F91678a8E2F3B327eFD8533567146");
  
  const weth = m.contract("WETH9")
  const lock = m.contract("UniswapV2Factory", [address1,address1], {
    
  });

  return { lock };
});
