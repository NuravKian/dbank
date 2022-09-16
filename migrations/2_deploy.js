const Token = artifacts.require("Token");
const dBank = artifacts.require("dBank");

module.exports = async function(deployer) {
	//deploy Token
	await deployer.deploy(Token);
	const token = await Token.deployed();

	await deployer.deploy(dBank, token.address);

	const dbank = await dBank.deployed();

	await token.passMinterRole(dbank.address);
	//assign token into variable to get it's address
	
	//pass token address for dBank contract(for future minting)

	//assign dBank contract into variable to get it's address

	//change token's owner/minter from deployer to dBank
};