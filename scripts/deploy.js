const main = async () => {
  const brainlyContractFactory = await hre.ethers.getContractFactory("Brainly");
  const brainlyContract = await brainlyContractFactory.deploy();
  await brainlyContract.deployed();
  console.log("Contract deployed to:", brainlyContract.address);
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
