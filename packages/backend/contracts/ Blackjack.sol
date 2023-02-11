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

    // Card[] public cards;

    // Card[] public gameDeck;

    Card[] public usedCards;

    uint8[] public usedCardsList;

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
        // generateDeck();
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

    // function generateDeck() private {
    //     for (uint256 i = 0; i < cardNumbers.length; ++i) {
    //         for (uint256 j = 0; j < cardSuits.length; ++j) {
    //             Card memory card = Card({
    //                 cardNumber: cardNumbers[i],
    //                 cardValue: cardValues[i],
    //                 cardSuit: cardSuits[j]
    //             });

    //             cards.push(card);
    //         }
    //     }
    // }

    // cards
    // gameDeck -> copy of cards
    // deal -> selects from gameDeck and removes the selected
    // hit -> selects from gameDeck and removes the selected
    // function removeCard(uint256 index) public {
    //     console.log(
    //         "cards[index]",
    //         cards[index].cardNumber,
    //         cards[index].cardValue,
    //         cards[index].cardSuit
    //     );
    //     console.log(
    //         "cards[cards.length - 1]",
    //         cards[cards.length - 1].cardNumber,
    //         cards[cards.length - 1].cardValue,
    //         cards[cards.length - 1].cardSuit
    //     );
    //     for (uint256 i = index; i < cards.length - 1; i++) {
    //         cards[i] = cards[i + 1];
    //         //cards[index] = cards[cards.length - 1]; // take the card to be deleted to the last spot
    //         console.log(
    //             "after adjusment cards[index]",
    //             cards[index].cardNumber,
    //             cards[index].cardValue,
    //             cards[index].cardSuit
    //         );
    //         console.log(
    //             "cards[cards.length - 1]",
    //             cards[cards.length - 1].cardNumber,
    //             cards[cards.length - 1].cardValue,
    //             cards[cards.length - 1].cardSuit
    //         );
    //     }
    //     cards.pop();
    // }

    function getCard() public returns (Card memory) {
        uint8 randomNum = uint8(generateRandomNumber() % 51);
        console.log("Used cards List length", usedCardsList.length);
        if (usedCardsList.length == 0) {
            usedCardsList.push(randomNum);
            console.log("Used cards List length renewed", usedCardsList.length);
        } else {
            for (uint8 i = 0; i < usedCardsList.length; ++i) {
                console.log(
                    "============================Index Numbers:",
                    i,
                    randomNum,
                    usedCardsList.length
                );
                if (randomNum == usedCardsList[i]) {
                    console.log("Number already in use");
                    randomNum += 1;
                }
            }
            usedCardsList.push(randomNum);
        }
        Card memory card = Card({
            cardNumber: cardNumbers[randomNum % 12],
            cardValue: cardValues[randomNum % 12],
            cardSuit: cardSuits[randomNum % 3]
        });
        usedCards.push(card);
        return card;
    }

    function dealCards() public {
        // shuffle the deck - clears out booleans
        // deal 2 cards to each player
        // generate random number
        // gameDeck = cards;

        playersCard1 = getCard();
        console.log(
            "playersCard1",
            playersCard1.cardNumber,
            playersCard1.cardValue,
            playersCard1.cardSuit
        );
        // console.log("usedCardsList", usedCardsList[0]);

        playersCard2 = getCard();
        console.log(
            "playersCard2",
            playersCard2.cardNumber,
            playersCard2.cardValue,
            playersCard2.cardSuit
        );

        // deal 1 card to the dealer (top card)
        dealersCard1 = getCard();
        console.log(
            "dealersCard1",
            dealersCard1.cardNumber,
            dealersCard1.cardValue,
            dealersCard1.cardSuit
        );

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
        playersCard3 = getCard();
        if (playersCard3.cardNumber > 0) {
            playersCard4 = getCard();
            // removeCard(randomNum);
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
