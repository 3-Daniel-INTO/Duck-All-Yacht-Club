const hre = require("hardhat");

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Desplegando Patocoin con la cuenta:", deployer.address);

    const Patocoin = await hre.ethers.getContractFactory("Patocoin");
    const pato = await Patocoin.deploy();

    await pato.waitForDeployment();

    console.log("Patocoin ($PATO) desplegado en:", await pato.getAddress());
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
