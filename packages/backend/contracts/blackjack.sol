// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Blackjack {
    // game structure

    struct Card {
        uint8 cardNumber;
        uint8 cardValue;
        string cardSuit;
    }

    uint8[13] cardNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
    uint8[13] cardValues = [11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10];
    string[4] cardSuits = ["clubs", "diamonds", "hearts", "spades"];

    uint256 playersCard1;
    uint256 playersCard2;
    uint256 playersCard3;
    uint256 playersCard4;
    uint256 playersCard5;
    uint256 dealersCard1;

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
        dealCards();

        //give the option to bet
        //deal the cards
    }

    function dealCards() public {
        // shuffle the deck - clears out booleans
        // deal 2 cards to each player
        // generate random number
        playersCard1 = cardValues[generateRandomNumber() % 13];
        playersCard2 = cardValues[generateRandomNumber() % 13];
        // deal 1 card to the dealer (top card)
        dealersCard1 = cardValues[generateRandomNumber() % 13];

        // check for blackjack
        //check for splits
        //check for insurance
    }

    function generateRandomNumber() public returns (uint256) {
        //chainlink or api3
        uint256 randomnumber = uint256(
            keccak256(
                abi.encodePacked(block.timestamp, block.difficulty, msg.sender)
            )
        ) % 13;
        return randomnumber;
    }

    // hit or stand
    function hit() public {
        playersCard3 = cardValues[generateRandomNumber() % 13];
        //check for bust
        //check for win

        //option to hit again or stand
    }

    // player can hit or stand - check for bust
    // after all stands, dealer reveals their 2nd card (bottom card)
    // pay tx
    // dealer can hit or stand (dealer must hit on 16 or less)
    // event for every hit

    function checkForBust() public {}

    function checkForWin() public {}

    // see who wins
    function claimWin() public {}
    //payout the winner or keep funds in pot

    //withdrawing funds for owner

    /* Logic issues */

    // // [1,2,3,4][1,2,3,4,5,6,7,8,9,10,10,10,10,11]
    // [1h, 2h, 3h,4h, 1s, 2s,  1c, 2, 1d, 2d, 3d,] - 52 array
    // request  number %52 = [card]
    //  if > 21 11 = 1
}
