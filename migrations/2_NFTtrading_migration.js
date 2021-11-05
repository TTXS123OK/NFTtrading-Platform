var myContract = artifacts.require('./NFTtrading.sol');
module.exports = function(deployer) {
	deployer.deploy(myContract);
}