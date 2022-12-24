require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
require( "@nomiclabs/hardhat-ethers");
require("dotenv").config({ path: ".env" });


module.exports = {
  solidity: {
    version: "0.7.6",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    testnet: {
      url: process.env.TESTNET_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan:{
    apiKey: process.env.API_KEY
  },
  namedAccounts: {
  deployer: {
    default: 0, // here this will by default take the first account as deployer
    1: 0, // similarly on mainnet it will take the first account as deployer. Note though that depending on how hardhat network are configured, the account 0 on one network can be different than on another
  },
  },
  mocha: {
    timeout: 200000, // 200 seconds max for running tests
  },
};