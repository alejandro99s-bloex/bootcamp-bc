import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-foundry";
import "hardhat-abi-exporter";

import dotenv from "dotenv";
dotenv.config();

const privateKey = process.env.PRIVATE_KEY || "";
const mumbaiRpcUrl = process.env.MUMBAI_RPC_URL || "";
const mumbaiExplorer = process.env.POLYGONSCAN_API_KEY || "";

const config: HardhatUserConfig = {
	solidity: {
		version: "0.8.16",
		settings: {
			optimizer: {
				enabled: true,
				runs: 2000,
			},
		},
	},
	defaultNetwork: "localhost",
	networks: {
		polygon_mumbai: {
			url: mumbaiRpcUrl,
			accounts: [privateKey],
		},
	},
	etherscan: {
		apiKey: mumbaiExplorer,
	},
	abiExporter: {
		path: "./data/abi",
		runOnCompile: true,
		clear: true,
		spacing: 2,
		pretty: true,
	},
};

export default config;
