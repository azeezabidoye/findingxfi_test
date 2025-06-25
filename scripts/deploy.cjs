const { ethers } = require("hardhat");

async function main() {
  // Get the contract factory
  const FundingXFI = await ethers.getContractFactory("FundingXFI");

  console.log("Deploying contract...");
  const fundingxfi = await FundingXFI.deploy(); // No constructor args needed
  await fundingxfi.waitForDeployment();
  const deployedFundingxfi = await fundingxfi.getAddress();

  console.log(`✅ Contract deployed at: ${deployedFundingxfi}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
