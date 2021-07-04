const { projectId, mnemonic } = require('./secret.json');
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      protocol: 'http',
      host: 'localhost',
      port: 8545,
      gas: 5000000,
      gasPrice: 5e9,
      networkId: '*',
    },
    rinkeby: {
      provider: () => new HDWalletProvider(
          mnemonic, `https://rinkeby.infura.io/v3/${projectId}`
      ),
      networkId: 4,
    },
    mainnet: {
      provider: () => new HDWalletProvider(
          mnemonic, `https://mainnet.infura.io/v3/${projectId}`
      ),
      network_id: "1",
      skipDryRun: false,
      confirmations: 2,
    },
    heco: {
      provider: () => new HDWalletProvider(
          mnemonic, `https://http-mainnet.hecochain.com`
      ),
      network_id: "128",
      skipDryRun: false,
      confirmations: 2,
    },
    bsc: {
      provider: () => new HDWalletProvider(
          mnemonic, `https://bsc-dataseed.binance.org`
      ),
      network_id: "56",
      skipDryRun: false,
      confirmations: 2,
    },
  },
};
