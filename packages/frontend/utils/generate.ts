import { Card } from '../pages/play'

interface Deck {
  [key: number]: Card;
}

export const generateDeck = () => {
  let cards: Card[] = []

  const suits: object = { 1: "clubs", 2: "diamonds", 3: "hearts", 4: "spades" };
  const figures: object = { "ace": 11, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "jack": 10, "queen": 10, "king": 10 };

  for (let key in figures) {
    for (let suit in suits) {
      cards.push({
        card: key,
        suit: (suits as any)[suit]
      })
    }
  }

  return cards
}

export const getRandomPairs = (deck: Deck) => {
  const pCard1: any = deck[Math.floor(Math.random() * Object.keys(deck).length)]
  delete deck[deck.indexOf(pCard1)]
  const pCard2: any = deck[Math.floor(Math.random() * Object.keys(deck).length)]
  delete deck[deck.indexOf(pCard2)]

  const dCard1: any = deck[Math.floor(Math.random() * Object.keys(deck).length)]
  delete deck[deck.indexOf(dCard1)]
  const dCard2: any = deck[Math.floor(Math.random() * Object.keys(deck).length)]
  delete deck[deck.indexOf(dCard2)]


  return { pCard1, pCard2, dCard1, dCard2, deck }
}