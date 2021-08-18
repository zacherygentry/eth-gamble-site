const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: '127.0.0.1',
      port: 7545,
      network_id: '*', // Match any network id
    },
    rinkeby: {
      provider: () => new HDWalletProvider('mnemonic here', 'url here'),
      network_id: 4, // Rinkeby's id
    },
  },
  contracts_directory: './contracts/',
  contracts_build_directory: './abis/',
  compilers: {
    solc: {
      version: '^0.8.2',
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
