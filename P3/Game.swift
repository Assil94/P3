//
//  Game.swift
//  P3
//
//  Created by Assil Heddar on 23/02/2020.
//  Copyright © 2020 Assil Heddar. All rights reserved.
//

import Foundation

class Game {
    // initialisation des propriétés qui vont nous servir pour le jeu
    var turn = 0
    let player1 = Player()
    let player2 = Player()
    let character = Character()
    
    // La méthode start permet de demander aux joueurs leur nom et de préparer la partie.
    func start() {
        print("Bienvenue aux 2 joueurs qui vont s'affronter ! Joueur 1, choisis un nom" )
        if let player1 = readLine() {
            let trimmed = player1.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty {
                print("Entrez quelquechose")
                start()
            } else {
                self.player1.namePlayer1 = player1
                print("Tu es \(player1). \n1 Au tour du joueur 2 de choisir un nom.")
                if let player2 = readLine() {
                    let trimmed = player2.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmed.isEmpty {
                        print("Entrez quelque chose.")
                        start()
                    } else if player1 == player2 {
                        print("Vous ne pouvez pas avoir le même nom.")
                        start()
                    } else {
                        self.player2.namePlayer2 = player2
                        print("Tu es \(player2)")
                        characterAvailable()
                        makeBattle()
                    }
                }
            }
        }
    }
    // Cette méthode est là pour affiché les personnages disponibles.
       func characterAvailable() {
           print("Les Personnages disponibles sont :")
           for character in Character.characterList {
               character.presentation()
           }
           Player.firstTeam = selectCharacter(for: player1.namePlayer1)
           Player.secondTeam = selectCharacter(for: player2.namePlayer2)
       }
       func selectCharacter(for name: String) -> [Character] {
           print("Ok \(name) constitues ton équipe."
               +  "\n Tapez 1 pour Soldier \n Tapez 2 pour Officier"
               + "\n Tapez 3 pour Recruit \n Tapez 4 pour Chef \n Tapez 5 pour Colonel \n Tapez 6 pour Président")
           var team: [Character] = []
           while team.count < 3 {
               
               if let choice = readLine() {
                   switch choice {
                   case "1":
                       print("Vous avez choisis le personnage Soldat, choisissez un autre personnage.")
                       team.append(Soldier())
                   case "2":
                       print("Vous avez choisis le personnage Commandant, choisissez un autre personnage.")
                       team.append(Officier())
                   case "3":
                       print("Vous avez choisis le personnage Recrue, choisissez un autre personnage.")
                       team.append(Recruit())
                   case "4":
                       print("Vous avez choisis le personnage Chef, choisissez un autre personnage.")
                       team.append(Chief())
                   case "5":
                       print("Vous avez choisis le personnage Colonel, choisissez un autre personnage.")
                       team.append(Colonel())
                   case "6":
                       print("Vous avez choisis le personnage Président, choisissez un autre personnage.")
                       team.append(President())
                       
                   default:
                       print("Recommencez")
                       return selectCharacter(for: name)
                   }
               }
           }
           print("Bravo \(name) tu as 3 personnages :), Voici ton équipe")
           for character in team {
               print(character.name)
           }
           return team
       }
    // Cette méthode nous permet de choisir qui attaquer.
    func attack(by attacker: Character, on attacked: Character, team: [Character], player: Player) -> [Character] {
        attacked.lifePoints -= attacker.weapon.dammage
        print("Ll lui reste \(attacked.lifePoints) de vie")
        if attacked.lifePoints < 0 {
            attacked.lifePoints = 0
            print("Ton personnage est mort")
        }
        let team = player.removeCharacterIfDead(in: team)
        return team
    }
    // Cette méthode est celle du soin pour les personnages.
    func heal(for fighter: Character, team: [Character]) {
        var fighter = fighter
        print("Quel personnage voulez vous soigner?")
        for i in 0..<team.count {
            if i == 0 {
                print("pour \(team[i]) Tape 1")
            }
            if i == 1 {
                print("pour \(team[i]) Tape 2")
            }
            if i == 2 {
                print("pour \(team[i]) Tape 3")
            }
        }
        if let choice = readLine() {
            switch choice {
            case "1" : print("Vous avez Selectionné \(team[0]) pour être soigné")
            fighter = team[0]
            case "2" : print("Vous avez Selectionné \(team[1]) pour être soigné")
            fighter = team[1]
            case "3" : print("Vous avez Selectionné \(team[2]) pour être soigné")
            fighter = team[2]
            default:
                print("Erreur dans votre selection")
                heal(for: fighter, team: team)
            }
        }
        fighter.lifePoints += 15
        if fighter.lifePoints > 100 {
            fighter.lifePoints = 100
        }
        print("Bravo vous avez soigné \(fighter.name). Il a deseromais \(fighter.lifePoints) points de vie")
    }
    // Cette méthode nous permet determiner le tour de chacun.
    func Turn(of player: String, against: String, choose: Character, team: [Character]) -> [Character] {
        let team = team
        var choose = choose
        print("place au combat, \(player) vs \(against). \n \(player) Choissis un personnage parmis ton équipe")
        for i in 0..<team.count {
            if i == 0 {
                print("pour \(team[i]) Tappe 1")
            }
            if i == 1 {
                print("pour \(team[i]) Tappe 2")
            }
            if i == 2 {
                print("pour \(team[i]) Tappe 3")
            }
        }
        if let choice = readLine() {
            switch choice {
            case "1" : print("Vous avez Selectionné \(team[0]) pour combattre")
            choose = team[0]
            case "2" : print("Vous avez Selectionné \(team[1]) pour combattre")
            choose = team[1]
            case "3" : print("Vous avez Selectionné \(team[2]) pour combattre")
            choose = team[2]
            default:
                print("Erreur dans votre selection")
                return Turn(of: player, against: against, choose: choose, team: team)
            }
        }
        return team
    }
    // Cette méthode sert à nous affiché qui est la cible
    func showTarget(is name: String, team: [Character]) -> [Character] {
        var team = team
        print("Maintenant Choissisez un Personnage à attaquer parmis l'équipe de \(name)")
        for i in 0..<team.count {
            if i == 0 {
                if team.indices.contains(0) {
                    print("pour attaquer \(team[i]) Tappe 1 ")
                    if (team[i] ).lifePoints == 0 {
                        team.remove(at: i)
                        print("Ce personnage est mort")
                    }
                }
            }
            if i == 1 {
                if team.indices.contains(1) {
                    print("pour attaquer \(team[i]) Tappe 2")
                    if (team[i] ).lifePoints == 0 {
                        team.remove(at: i)
                        print("Ce personnage est mort")
                    }
                }
            }
            if i == 2 {
                if team.indices.contains(2) {
                    print("pour attaquer \(team[i]) Tappe 3")
                    if (team[i] ).lifePoints == 0 {
                        team.remove(at: i)
                        print("Ce personnage est mort")
                    }
                }
            }
        }
        return team
    }
    // Cette méthode nous permet de determiner une cible à attaquer.
    func target(is name: String, attacking: Character, on attacked: Character, team: [Character], player: Player) {
        var team = team
        if let choice = readLine() {
            switch choice {
            case "1" : print("Vous attaquez \(team[0]) !!")
            let attacked = team[0]
            team = attack(by: attacking, on: attacked, team: team, player: player)
            case "2" : print("Vous avez Selectionné \(team[1]) pour combattre")
            let attacked = team[1]
            team = attack(by: attacking, on: attacked, team: team, player: player)
            case "3" : print("Vous avez Selectionné \(team[2]) pour combattre")
            let attacked = team[2]
            team = attack(by: attacking, on: attacked, team: team, player: player)
            default:
                print("Erreur dans votre selection")
                return target(is: name, attacking: attacking, on: attacked, team: team, player: player)
            }
        }
    }
    // La méthode healForTeam est là pour demander aux joueurs si ils veulent utiliser le soin.
    func healForTeam(for fighter: Character, team: [Character]) {
        let fighter = fighter
        print("Voulez vous soigner un personnage? \n Tape 1 pour Oui, Tape 2 pour Non")
        if let choice = readLine() {
            switch choice {
            case "1" :
                heal(for: fighter, team: team)
            case "2" :
                print("Très bien.")
            default:
                healForTeam(for: fighter, team: team)
            }
        }
    }
    //Cette méthode affiche les statistiques.
    func whoWON() {
        if Player.firstTeam.count > Player.secondTeam.count {
            print("\(player1.namePlayer1) à gagné !! Felicitions, \(player2.namePlayer2) ce n'est pas grave retente t'as chance")
        } else {
            print("\(player2.namePlayer2) à gagné !! Felicitions, \(player1.namePlayer1) ce n'est pas grave retente t'as chance")
        }
        print("Il y a eu \(turn) tour")
    }
    //C'est une boucle au tour par tour jusqu'à qu'il n'y ai plus de personnage disponible pour l'un des deux joueurs.
    func makeBattle() {
        let player = Player()
        while Player.firstTeam.count > 0 && Player.secondTeam.count > 0 {
            Player.firstTeam = Turn(of: player1.namePlayer1, against: player2.namePlayer2, choose: player.premierCombattant, team: Player.firstTeam)
            Player.secondTeam = showTarget(is: player2.namePlayer2, team: Player.secondTeam)
            target(is: player2.namePlayer2, attacking: player.premierCombattant, on: player.secondCombattant, team: Player.secondTeam, player: player2)
            Player.secondTeam = player.removeCharacterIfDead(in: Player.secondTeam)
            healForTeam(for: player.premierCombattant, team: Player.firstTeam)
            Player.secondTeam = Turn(of: player2.namePlayer2, against: player1.namePlayer1, choose: player.secondCombattant, team: Player.secondTeam)
            Player.firstTeam = showTarget(is: player1.namePlayer1, team: Player.secondTeam)
            target(is: player1.namePlayer1, attacking: player.secondCombattant, on: player.premierCombattant, team: Player.firstTeam, player: player1)
            Player.firstTeam = player.removeCharacterIfDead(in: Player.firstTeam)
            healForTeam(for: player.secondCombattant, team: Player.secondTeam)
            turn += 1
        }
        whoWON()
    }
}
