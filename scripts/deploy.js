// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Governor = await ethers.getContractFactory("Governor");
  const governor = await Governor.deploy();

  await governor.deployed();
  console.log("Governor deployed to:", governor.address);

  const TimelockControl = await ethers.getContractFactory("TimelockControl");
  const timelockControl = await TimelockControl.deploy();

  await timelockControl .deployed();
  console.log("timelockControl deployed to:", timelockControl.address);

  const GovernorFactory = await ethers.getContractFactory("GovernorFactory");
  const governorFactory = await GovernorFactory.deploy(governor.address, timelockControl.address);

  await governorFactory.deployed();
  console.log("governorFactory deployed to:", governorFactory.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
