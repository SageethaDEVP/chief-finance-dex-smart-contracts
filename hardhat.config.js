// const { version } = require("hardhat");

require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const mnemonic = process.env.mnemonic


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  
  solidity: {
    compilers: [{ version: "0.5.0",settings: {
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    } }, { version: "0.5.16",settings: {
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    } }, { version: "0.6.0",settings: {
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    } }, { version: "0.6.2",settings: {
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    } }, { version: "0.6.6",settings: {
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    } }, { version: "0.8.24",settings: {
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    } }],
    settings: {
      optimizer: {
        enabled: true,
        runs: 10000,
      },
    }
  },
  allowUnlimitedContractSize: true,
  etherscan: {
    "apiKey":
      "BD5NNA18K4YEI2RIR2JSKM6GXDFWDAFGXF"
  },
  networks: {
    bsc: {
      url: "https://data-seed-prebsc-1-s1.bnbchain.org:8545",
      accounts: {"mnemonic":mnemonic},
      gas: "auto",
      gasPrice: "auto",
      saveDeployments: true,
    },
    mumbai : {
      url:"https://polygon-mumbai.g.alchemy.com/v2/hML_HRNy_LEP9hIU3JkDgpnw0eVcM6hV",
      accounts:[PRIVATE_KEY],
      gas : 400000000000000
    },
    sepolia:{
      url:"https://sepolia.infura.io/v3/6a862ce0da644115ad4e2f4696516800",
      accounts:[PRIVATE_KEY]
    }
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: true,
    disambiguatePaths: false,
  },
}
