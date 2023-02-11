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

  describe("Play", function () {
    it("Deal Cards", async function () {
      const { blackjack, owner } = await loadFixture(beforeEachFunction);

      await blackjack.bet(2, { value: ethers.utils.parseEther("2") });


      let playerHand = await blackjack.playerHand();
      console.log("playerHand: ", playerHand)

      let dealerHand = await blackjack.dealerHand();
      //  console.log("dealerHand: " , dealerHand)

      await blackjack.hit();
      await blackjack.hit();
      playerHand = await blackjack.playerHand();
      console.log("playerHand: ", playerHand)
      //await blackjack.logUsedCardsList();
      // for (let i = 0; i < 8; i++) {
      //   console.log("usedCardsList: ", await blackjack.usedCardsList(i));
      // }
      // let playerHandValue = await blackjack.playerHandValue();
      // let dealerHandValue = await blackjack.dealerHandValue();
      // let playerHandCount = await blackjack.playerHandCount();
      // let dealerHandCount = await blackjack.dealerHandCount();
      // let playerHandAceCount = await blackjack.playerHandAceCount();
      // let dealerHandAceCount = await blackjack.dealerHandAceCount();


    });
  });

});
