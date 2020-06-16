//
//  main.swift
//  BlackJack
//
//  Created by 김현인 on 2020/06/16.
//  Copyright © 2020 HyunInKim. All rights reserved.
//
//딜러와 게이머 단 2명만 존재한다.
/*카드는 조커를 제외한 52장이다. (즉, 카드는 다이아몬드,하트,스페이드,클럽 무늬를 가진 A,2~10,K,Q,J 으로 이루어져있다.)
- 2~10은 숫자 그대로 점수를, K/Q/J는 10점으로, A는 1로 계산한다. (기존 규칙은 A는 1과 11 둘다 가능하지만 여기선 1만 허용하도록 스펙아웃) //clear
- 딜러와 게이머는 순차적으로 카드를 하나씩 뽑아 각자 2개의 카드를 소지한다. //clear
- 게이머는 얼마든지 카드를 추가로 뽑을 수 있다.
- 딜러는 2카드의 합계 점수가 16점 이하이면 반드시 1장을 추가로 뽑고, 17점 이상이면 추가할 수 없다.
- 양쪽다 추가 뽑기 없이, 카드를 오픈하면 딜러와 게이머 중 소유한 카드의 합이 21에 가장 가까운 쪽이 승리한다.
- 단 21을 초과하면 초과한 쪽이 진다.*/
import Foundation

let shape:Array<String> = ["D","H","C","S"]
let number:Array<String> = ["2","3","4","5","6","7","8","9","10","A","K","Q","J"]
var deck:Array<String> = []
class Card {
    func makeDeck(){
        for shapes in 0..<shape.count{
            for numbers in 0..<number.count{
                deck.append(shape[shapes] + number[numbers])
            }
        }
        deckCount()
        showDeck()
    }
    func deckCount(){
        print(deck.count)
    }
    func showDeck(){
        print("Deck:",deck)
    }
   
}

class receivedCard:Card {
    var playerDeck:Array<String> = []
    var dealerDeck:Array<String> = []
    
    func receiveCard(_ who:String){
        let randomnumber:UInt32 = arc4random_uniform(UInt32(deck.count))
        if who == "player" {
            playerDeck.append(deck[Int(randomnumber)])
            showPlayerDeck()
        }else if who == "dealer"{
            dealerDeck.append(deck[Int(randomnumber)])
            showDealerDeck()
        }
        deck.remove(at: Int(randomnumber))
    }
    
    func showPlayerDeck(){
        print("playerDeck: ",playerDeck)
    }
    func showDealerDeck(){
        print("dealerDeck: ",dealerDeck)
    }
}

//

func main(){
    //MARK:--카드생성
    let cards:Card = Card()
    cards.makeDeck()
    //MARK:--기본카드 분배
    let distribution:receivedCard = receivedCard()
    distribution.receiveCard("player")
    distribution.receiveCard("dealer")
    distribution.receiveCard("player")
    distribution.receiveCard("dealer")
    
    
}
main()



//class Player:Card {
//    var playerDeck:Array<String> = []
//
//    func reciveCard(){
//        let randomnumber:UInt32 = arc4random_uniform(UInt32(deck.count))
//        print(randomnumber)
//        playerDeck.append(deck[Int(randomnumber)])
//        deck.remove(at: Int(randomnumber))
//        showPlayerDeck()
//    }
//    func showPlayerDeck(){
//        print(playerDeck)
//    }
//
//}
//
//class Dealer:Card {
//    var dealerDeck:Array<String> = []
//
//    func reciveCard(){
//        let randomNumber:UInt32 = arc4random_uniform(UInt32(deck.count))
//        dealerDeck.append(deck[Int(randomNumber)])
//        deck.remove(at: Int(randomNumber))
//        showdealerDeck()
//    }
//    func showdealerDeck(){
//        print(dealerDeck)
//    }
//}




