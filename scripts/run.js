const main = async () => {
  const marketContractFactory = await hre.ethers.getContractFactory("Market");
  const marketContract = await marketContractFactory.deploy();
  await marketContract.deployed();
  console.log("Contract deployed to:", marketContract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
