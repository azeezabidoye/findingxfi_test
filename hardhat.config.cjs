require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
require("hardhat-deploy");
require("hardhat-gas-reporter");
require("solidity-coverage");

const { PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    hardhat: { chainId: 1337 },
    crossfiTestnet: {
      url: "https://crossfi-testnet.g.alchemy.com/v2/QvGoIVVwyzXDCki9k_BIt",
      accounts: [PRIVATE_KEY],
      chainId: 4157,
    },
    // namedAccounts: {
    //   deployer: {
    //     default: 0,
    //   },
    // },
    // gasReporter: {
    //   enabled: true,
    //   currency: "USD",
    //   coinmarketcap: COINMARKETCAP_API_KEY, // Optional if you want real cost estimate
    //   showTimeSpent: true,
    //   excludeContracts: [],
    //   noColors: false,
    // },
  },
};
