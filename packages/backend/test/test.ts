import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
// import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("BlackJack", function () {

  async function beforeEachFunction() {
    // Contracts are deployed using the first signer/account by default
    const [owner, auctionCreator, bidder1, bidder2, bidder3, auctionCreator2] = await ethers.getSigners();

    const BlackJack = await ethers.getContractFactory("Blackjack");
    const blackjack = await BlackJack.deploy();
    await blackjack.deployed();

    // const currentTime = await time.latest();
    // const zeroAddress = '0x0000000000000000000000000000000000000000';
    // const minBid = ethers.utils.parseEther("1");
    // const minIncBid = ethers.utils.parseEther("0.5");


    return { blackjack, owner };
  }

  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      const { blackjack, owner } = await loadFixture(beforeEachFunction);
      //   console.log("owner: " , owner.address)
      //   console.log("nftContract: " , nftContract.address)
      //   console.log("degenContract: " , degenContract.address)
      expect(await blackjack.owner()).to.equal(owner.address);
    });
  });

});
