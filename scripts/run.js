const main = async () => {
  const [owner, superCoder] = await hre.ethers.getSigners();
  const brainlyContractFactory = await hre.ethers.getContractFactory("Brainly");
  const brainlyContract = await brainlyContractFactory.deploy();
  await brainlyContract.deployed();
  console.log("Contract deployed to:", brainlyContract.address);
  console.log("Contract owner:", owner.address);

  // let txn = await nftContract.makeAnEpicNFT();
  // // Wait for it to be mined.
  // await txn.wait();

  let txn = await brainlyContract.connect(superCoder).mintToken();
  console.log(txn);
  txn = await brainlyContract.connect(superCoder).isMember();
  console.log(txn);
  txn = await brainlyContract.fetchUsers();
  console.log(txn);
  // Wait for it to be mined.
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
