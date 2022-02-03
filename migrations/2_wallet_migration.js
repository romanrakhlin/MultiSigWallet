const WalletMigrations = artifacts.require("MultiSigWallet");

module.exports = function (deployer) {
  deployer.deploy(WalletMigrations);
};
