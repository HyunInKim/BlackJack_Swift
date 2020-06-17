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
var playerDeck:Array<String> = []
var dealerDeck:Array<String> = []
class Card {
    func makeDeck(){
        for shapes in 0..<shape.count{
            for numbers in 0..<number.count{
                deck.append(shape[shapes] + number[numbers])
            }
        }
//        deckCount()
//        showDeck()
    }
    func deckCount(){
        print(deck.count)
    }
    func showDeck(){
        print("Deck:",deck)
    }
   
}
enum ShapeCheck: Int {
    case A = 1
    case K,Q,J = 10
    
}
class receivedCard:Card {
    func receiveCard(_ who:String){
        let randomnumber:UInt32 = arc4random_uniform(UInt32(deck.count))
        let giveCard = deck[Int(randomnumber)]
        let slice = giveCard.index(after: giveCard.startIndex)..<giveCard.endIndex
             
        if who == "player" {
            playerDeck.append(String(giveCard[slice]))
            showPlayerDeck()
        }else if who == "dealer"{
            dealerDeck.append(String(giveCard[slice]))
            
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

class SumOfCard {
    var playerCardValue:Int = 0
    var dealerCardValue:Int = 0
    func PlayerCardAdd() -> Int{
        playerCardValue = 0
        for i in 0..<playerDeck.count{
            if playerDeck[i] == "A"{
                playerCardValue += 1
            }else if playerDeck[i] == "K" || playerDeck[i] == "Q" || playerDeck[i]  == "J"{
                playerCardValue += 10
            }else{
                playerCardValue += Int(playerDeck[i])!
            }
        }
        //print("playerCardValue: ",playerCardValue)
        return playerCardValue
    }
    func DealerCardAdd() -> Int{
        dealerCardValue = 0
        for i in 0..<dealerDeck.count{
            if dealerDeck[i] == "A"{
                dealerCardValue += 1
            }else if dealerDeck[i] == "K" || dealerDeck[i] == "Q" || dealerDeck[i]  == "J"{
                dealerCardValue += 10
            }else{
                dealerCardValue += Int(dealerDeck[i])!
            }
        }
        //print("dealerCardValue: ",dealerCardValue)
        return dealerCardValue
    }
    func JudgeMent() -> Bool{
        if dealerCardValue <= 16{
            return true
        } else{
            return false
        }
    }
    func finalJudgeMent() {
        if playerCardValue > 21{
            print("딜러가 승리하였습니다.")
        } else if dealerCardValue > 21{
            print("플레이어가 승리하였습니다.")
        } else if (21-playerCardValue) > (21 - dealerCardValue) {
            print("딜러가 승리하였습니다.")
        } else if (21-playerCardValue) < (21 - dealerCardValue){
            print("플레이어가 승리하였습니다.")
        } else {
            print("무승부입니다.")
        }
        
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
    //MARK:--카드더하기
    let cardSum:SumOfCard = SumOfCard()
    cardSum.PlayerCardAdd()
    cardSum.DealerCardAdd()
    //MARK:--판별
    while cardSum.JudgeMent(){
        distribution.receiveCard("dealer")
        cardSum.DealerCardAdd()
    }
}
func main2(){
    var loop:Bool = true
    print("----------------")
    print("게임을 시작하겠습니다.")
    print("----------------")
    print("딜러와 플레이어는 각각 두장의 카드를 받습니다.")
    let cards:Card = Card()
    cards.makeDeck()
    let distribution:receivedCard = receivedCard()
    distribution.receiveCard("player")
    distribution.receiveCard("dealer")
    distribution.receiveCard("player")
    distribution.receiveCard("dealer")
    let cardSum:SumOfCard = SumOfCard()
    while cardSum.JudgeMent(){
        print("딜러 카드의 합계가 16이하여서 한장 더 뽑습니다.")
        distribution.receiveCard("dealer")
        cardSum.DealerCardAdd()
    }
    while loop {
        print("플레이어께서 카드를 한장더 뽑으실려면 1번을, 게임을 종료하고 결과를 확인할경우 2번을 눌러주세요.")
        let playerChoice = readLine()
        if let player = playerChoice{
            if player == "1" {
                distribution.receiveCard("player")
            }else if player == "2"{
                loop = false
                cardSum.finalJudgeMent()
                distribution.showPlayerDeck()
                distribution.showDealerDeck()
            }
            
        }
    }
}
main2()



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




