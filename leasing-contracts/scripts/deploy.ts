import { ethers } from "hardhat";

async function main() {
	const [deployer] = await ethers.getSigners();

	const LeasgingManager = await ethers.getContractFactory("LeasingManager");
	const leasingManager = await LeasgingManager.connect(deployer).deploy();
	await leasingManager.deployed();

	console.log("LeasingManager deployed to:", leasingManager.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
	console.error(error);
	process.exitCode = 1;
});
