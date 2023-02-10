// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Blackjack is Ownable {
    // game structure

    struct Card {
        uint8 cardNumber;
        uint8 cardValue;
        string cardSuit;
    }

    uint256 private seed;

    Card[] public cards;

    Card[] public gameDeck;

    uint8[13] cardNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
    uint8[13] cardValues = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10];
    string[4] cardSuits = ["clubs", "diamonds", "hearts", "spades"];

    event Status(string _message);

    Card playersCard1;
    Card playersCard2;
    Card playersCard3;
    Card playersCard4;
    Card playersCard5;
    Card dealersCard1;

    constructor() {
        generateDeck();
    }

    //start a game - front end
    // iniiliaze the deck/wallets
    //click start game - check for balance (base deposit) - 1 ether
    // players - tbd

    //bet - then the blockchain game begins
    function bet(uint256 _betAmount) public payable {
        require(
            msg.value >= _betAmount,
            "Bet amount must be equal to msg.value"
        );
        // generateDeck();
        dealCards();

        //give the option to bet
        //deal the cards
    }

    function generateDeck() private {
        for (uint256 i = 0; i < cardNumbers.length; ++i) {
            for (uint256 j = 0; j < cardSuits.length; ++j) {
                Card memory card = Card({
                    cardNumber: cardNumbers[i],
                    cardValue: cardValues[i],
                    cardSuit: cardSuits[j]
                });

                cards.push(card);
            }
        }
    }

    // cards
    // gameDeck -> copy of cards
    // deal -> selects from gameDeck and removes the selected
    // hit -> selects from gameDeck and removes the selected

    function dealCards() public {
        // shuffle the deck - clears out booleans
        // deal 2 cards to each player
        // generate random number
        gameDeck = cards;
        playersCard1 = cards[uint8(generateRandomNumber() % 51)];
        console.log("playersCard1", playersCard1.cardNumber);
        playersCard2 = cards[uint8(generateRandomNumber() % 51)];
        console.log("playersCard2", playersCard2.cardNumber);
        // deal 1 card to the dealer (top card)
        dealersCard1 = cards[uint8(generateRandomNumber() % 51)];
        console.log("dealersCard1", dealersCard1.cardNumber);

        // check for blackjack
        //check for splits
        //check for insurance
    }

    function generateRandomNumber() public returns (uint256) {
        //chainlink or api3
        seed = (block.prevrandao + seed) % 77;
        uint256 randomnumber = uint256(
            keccak256(
                abi.encodePacked(
                    block.timestamp,
                    /*block.difficulty*/
                    block.prevrandao,
                    msg.sender
                )
            )
        ) + (seed % 13);
        return randomnumber;
    }

    // hit or stand
    function hit() public {
        playersCard3 = cards[uint8(generateRandomNumber() % 51)];
        if (playersCard3.cardNumber > 0) {
            playersCard4 = cards[uint8(generateRandomNumber() % 51)];
        }
        //check for bust
        bool checker = checkForBust();
        if (checker) {
            console.log("Busted");
            // emit event and game stops
        }
        console.log("checker", checker);
        //check for win

        //option to hit again or stand
    }

    // player can hit or stand - check for bust
    // after all stands, dealer reveals their 2nd card (bottom card)
    // pay tx
    // dealer can hit or stand (dealer must hit on 16 or less)
    // event for every hit

    function checkForBust() public returns (bool) {
        uint8 sum = 0;
        for (uint8 i = 0; i < 4; ++i) {
            Card[] memory temp = playerHand();
            sum += temp[i].cardNumber;
            console.log("sum", sum);
            if (sum > 21) {
                return true;
            } else false;
        }
    }

    function checkForWin() public {}

    // see who wins
    function claimWin() public {}

    //payout the winner or keep funds in pot

    //withdrawing funds for owner

    function playerHand() public view returns (Card[] memory) {
        Card[] memory playerHand = new Card[](4);
        playerHand[0] = playersCard1;
        playerHand[1] = playersCard2;
        playerHand[2] = playersCard3;
        playerHand[3] = playersCard4;
        return playerHand;
    }

    function dealerHand() public view returns (Card[] memory) {
        Card[] memory dealerHand = new Card[](1);
        dealerHand[0] = dealersCard1;
        return dealerHand;
    }

    /* Logic issues */

    // // [1,2,3,4][1,2,3,4,5,6,7,8,9,10,10,10,10,11]
    // [1h, 2h, 3h,4h, 1s, 2s,  1c, 2, 1d, 2d, 3d,] - 52 array
    // request  number %52 = [card]
    //  if > 21 11 = 1
}
