import { Room, Client } from "@colyseus/core";
import { Enemy, MyRoomState, OtherPlayer } from "./schema/MyRoomState";
import { MyRoom } from "./MyRoom";

export class TutorialRoom extends MyRoom {
    onCreate (options: any) {
        super.onCreate(options);
        this.maxClients = 1;
    }
    tick() {
        if (this.state.state == 0) {
            if (this.state.players.size == 1) {
              this.broadcast("startGame");
              this.state.state = 1;
            }
          }
          this.state.players.forEach((plr) => {
            if (this.state.state == 1) {
                plr.y += 2;
                plr.points += 1;
            } else {
              plr.points = 999;
            }
            if (this.state.state == 1) {
              if (this.state.players.size == 1) {
                this.broadcast("winner", plr.pname);
                this.state.state = 2;
                setTimeout(() => {this.reset()}, 3000);
              }
            }
            if (plr.x < -31) {
              plr.x = 599;
              plr.points -= 300;
            }
            if (plr.x > 600) {
              plr.x = 0;
              plr.points -= 300;
            }
            if (plr.y > 700-20) {
              plr.y = -32;
              plr.points += 300;
              plr.enemies.forEach((en) => {
              en.x = Math.random() * 680;
              en.y = 300 + Math.random() * 200;
              });
            }
            if (plr.points >= 1000) {
              this.state.players.forEach((plr2) => {
                if (plr2 != plr) {
                plr2.enemycount++;
                const enemy = new Enemy();
                enemy.x = Math.random() * 680;
                enemy.y = 300 + Math.random() * 200;
                plr2.enemies.set(plr2.enemycount.toString(),enemy);
                }
              });
              plr.points -= 1000;
            }
            let i:Boolean = false;
            plr.enemies.forEach((en) => {
              if (en.x > plr.x) {
                en.x -= 2;
              }
              if (en.x < plr.x) {
                en.x += 2;
              }
              if (en.x+48 > plr.x && en.x < plr.x + 48 
                && en.y+48 > plr.y && en.y < plr.y + 48 ) {
                  plr.points += 15;
                  plr.isGrazing = true;
                  i = true;
                } else {
                  if (!i) {
                  plr.isGrazing = false;
                  }
                }
              if (en.x+24 > plr.x  && en.x < plr.x + 24 
                && en.y+24 > plr.y  && en.y < plr.y + 24 ) {
                if (this.state.state == 1) {
                    this.state.players.forEach((plr2) => {
                      if (plr2 != plr) {
                        this.broadcast("winner", plr2.pname);
                        this.state.state = 2;
                        setTimeout(() => {this.reset()}, 3000);
                      }
                    }); 
                  }
                }
            });
          });
    }
    onJoin (client: Client, options: any) {
        super.onJoin(client, options);
        const player = new OtherPlayer();
        player.x = -6969696969696;
        player.y = 32;
        player.pname = "Coach"
        this.state.players.set(client.sessionId, player);
    
      }
}