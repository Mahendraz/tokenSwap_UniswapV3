import { ethers } from "hardhat";

async function main() {

  const SimpleSwap = await ethers.getContractFactory("SimpleSwap");
  const simpleSwap = await SimpleSwap.deploy();

  await simpleSwap.deployed();

  console.log("SimpleSwap deployed to:", simpleSwap.address);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
