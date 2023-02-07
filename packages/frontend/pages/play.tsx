import React, { useState } from "react";
import { generateDeck, getRandomPairs } from '../utils/generate'
export interface Card {
  card: number;
  suit: string;
}

const Play: React.FC = () => {
  const [deck, setDeck] = useState<any>([]);
  const [initialDeal, setInitialDeal] = useState<boolean>(false)
  const [playerHand, setPlayerHand] = useState<Card[]>([]);
  const [dealerHand, setDealerHand] = useState<Card[]>([]);
  const [gameOver, setGameOver] = useState<boolean>(false);

  const handleDeal = () => {
    const deck = generateDeck()
    const dealt = getRandomPairs(deck as any)
    // logic to deal cards to player and dealer
    // ...
    setPlayerHand([...playerHand, dealt.pCard1, dealt.pCard2]);
    setDealerHand([...dealerHand, dealt.dCard1, dealt.dCard2]);
    setDeck(dealt.deck)
    setInitialDeal(true)
    // setDeck(deck.slice(4));
  };

  const handleHit = () => {
    // logic to add a card to player's hand
    // ...
    setInitialDeal(false)
    setPlayerHand([...playerHand, deck[0]]);
    setDeck(deck.slice(1));
  };

  const handleStand = () => {
    // logic to end player's turn and start dealer's turn
    // ...
    setGameOver(true);
  };

  return (
    <div className="flex min-h-screen flex-col items-center p-10 bg-gray-200">
      {!gameOver && (
        <div className="flex mt-4">
          <button className="bg-blue-500 text-white p-2 rounded mr-2" onClick={handleDeal}>
            Deal
          </button>
          <button className="bg-green-500 text-white p-2 rounded mr-2" onClick={handleHit}>
            Hit
          </button>
          <button className="bg-red-500 text-white p-2 rounded" onClick={handleStand}>
            Stand
          </button>
        </div>
      )}
      {
        initialDeal && (
          <div>
            <div className="text-lg font-medium text-gray-600">Player's Hand:</div>
            <div className="text-sm text-gray-600 flex gap-2">
              {playerHand.map(card => <img src={`cards/${card.card}_of_${card.suit}.svg`} />)}
            </div>
            <div className="text-lg font-medium text-gray-600 mt-4">Dealer's Hand:</div>
            <div className="text-sm text-gray-600 flex  gap-2">
              {dealerHand.map((card, idx) =>
                <img className={initialDeal && idx > 0 ? "hidden" : ""} src={`cards/${card.card}_of_${card.suit}.svg`} />
              )}
            </div>
          </div>
        )
      }
      {gameOver && <div className="mt-4 text-lg font-medium text-gray-600">Game Over!</div>}
    </div>
  );
};

export default Play;
