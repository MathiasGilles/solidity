const nftContract = artifacts.require("NFT_contract");

module.exports = function(deployer) {
    deployer.deploy(nftContract);
}