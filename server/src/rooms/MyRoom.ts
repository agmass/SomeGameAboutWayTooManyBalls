import { Room, Client } from "@colyseus/core";
import { Enemy, MyRoomState, OtherPlayer, Power, Powerup } from "./schema/MyRoomState";

export class MyRoom extends Room<MyRoomState> {
  maxClients = 2  ;

  reset() {
    this.state.players.forEach((plr) => {
      plr.enemies.clear();
      plr.lives = 3;
      plr.enemycountscr = 0;
      plr.enemycount = 0;
      plr.isGrazing = false;
      plr.x = 300 - 16;
      plr.y = 32;
      plr.points = 999;
    });
    setTimeout(() => {
      this.state.state = 0;
    }, 3000);
  }

  tick() {
    if (this.state.state == 0) {
      if (this.state.players.size == 2) {
        this.broadcast("startGame");
        this.state.state = 1;
      }
    }
    this.state.players.forEach((plr, client) => {
      var pointmulti = 1;
      plr.currentpowers.forEach((cp) => {
        if (cp.name == "2x Points") {
          pointmulti++;
        }
      });
      var candie = 1;
      plr.currentpowers.forEach((cp) => {
        if (cp.name == "Invicibility") {
          candie = 0;
        }
      });
      var isfroze = 1;
      plr.currentpowers.forEach((cp) => {
        if (cp.name == "Time Freeze") {
          isfroze = 0;
        }
      });
      if (this.state.state == 1) {
        
      plr.y += 2;
      plr.points += 2 * pointmulti;
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
        plr.points -= 300 / pointmulti;
      }
      if (plr.x > 600) {
        plr.x = 0;
        plr.points -= 300 / pointmulti;
      }
      if (plr.y > 700-20) {
        plr.y = -32;
        plr.powerups.clear();
        if (1 == 1) {
          const pu = new Powerup();
          pu.x = Math.random() * 680;
          pu.y = 200 + Math.random() * 200;
          plr.powerupcount++;
          pu.key = plr.powerupcount.toString();
          plr.powerups.set(plr.powerupcount.toString(),pu);
        }
        this.clients.getById(client).send("finish");
        plr.points += 700 * pointmulti;
        plr.enemies.forEach((en) => {
        en.x = Math.random() * 680;
        en.y = 300 + Math.random() * 200;
        });
      }
      if (plr.points >= 1000) {
        this.state.players.forEach((plr2) => {
          if (plr2 != plr) {
          plr2.enemycountscr++;
          plr2.enemycount++;
          const enemy = new Enemy();
          enemy.x = Math.random() * 680;
          enemy.y = 300 + Math.random() * 200;
          if (plr.y > enemy.y && plr.y > 300) {
              enemy.y = plr.y - 100;
          }
          plr2.enemies.set(plr2.enemycountscr.toString(),enemy);
          }
        });
        plr.points -= 1000 / pointmulti;
      }
      let i:Boolean = false;
      plr.powerups.forEach((pu) => {
        if (pu.x+24 > plr.x  && pu.x < plr.x + 24 
          && pu.y+24 > plr.y  && pu.y < plr.y + 24 ) {
          if (this.state.state == 1) {
            plr.powerups.delete(pu.key);
            const n =  Math.round(Math.random() * 4);
            console.log(n);
            switch (n) {
              case 0:
                const newPower:Power = new Power();
                newPower.asset = "assets/images/-3_balls.png";
                newPower.name = "Less Enemies";
                const ee = (plr.currentpowers.size+1).toString();
                plr.currentpowers.set((plr.currentpowers.size+1).toString(), newPower);
                setTimeout(() => {
                  plr.currentpowers.delete(ee);
                }, 3000);
                for (let i = plr.enemycount; i > plr.enemycount - 3; i--) {
                  console.log(i);
                  if (i > 0) {
                    plr.enemycount--;
                    if (plr.enemies.has(i.toString()))
                    plr.enemies.delete(i.toString());
                  }
                }
                break;
              case 1:
                const newPower2:Power = new Power();
                newPower2.asset = "assets/images/1_life.png";
                newPower2.name = "+1 Life";
                const ee2 = (plr.currentpowers.size+1).toString();
                plr.currentpowers.set((plr.currentpowers.size+1).toString(), newPower2);
                plr.lives++;
                setTimeout(() => {
                  plr.currentpowers.delete(ee2);
                }, 3000);
               break;
              case 2:
                const newPower3:Power = new Power();
                newPower3.asset = "assets/images/2x_points.png";
                newPower3.name = "2x Points";
                const ee3 = (plr.currentpowers.size+1).toString();
                plr.currentpowers.set((plr.currentpowers.size+1).toString(), newPower3);
                setTimeout(() => {
                  plr.currentpowers.delete(ee3);
                }, 15000);
               break;
              case 3:
                const newPower4:Power = new Power();
                newPower4.asset = "assets/images/invincible_ball.png";
                newPower4.name = "Invicibility";
                const ee4 = (plr.currentpowers.size+1).toString();
                plr.currentpowers.set((plr.currentpowers.size+1).toString(), newPower4);
                setTimeout(() => {
                  plr.currentpowers.delete(ee4);
                }, 15000);
               break;
              case 4:
                const newPower5:Power = new Power();
                newPower5.asset = "assets/images/time_freeze.png";
                newPower5.name = "Time Freeze";
                const ee5 = (plr.currentpowers.size+1).toString();
                plr.currentpowers.set((plr.currentpowers.size+1).toString(), newPower5);
                setTimeout(() => {
                  plr.currentpowers.delete(ee5);
                }, 15000);
              break;
            }
          }
          }
      });
      plr.enemies.forEach((en) => {
        if (isfroze == 1) {
        if (en.x > plr.x) {
          en.x -= 1;
        }
        if (en.x < plr.x) {
          en.x += 1;
        }
        }
        if (en.x+64 > plr.x && en.x < plr.x + 64 
          && en.y+64 > plr.y && en.y < plr.y + 64 ) {
            plr.points += 15 * pointmulti;
            plr.isGrazing = true;
            i = true;
          } else {
            if (!i) {
            plr.isGrazing = false;
            }
          }
          
        if (en.x+24 > plr.x  && en.x < plr.x + 24 
          && en.y+24 > plr.y  && en.y < plr.y + 24 ) {
          if (this.state.state == 1 && candie == 1) {
            plr.lives--;
            plr.y -= 200;
            plr.points = 0;
            if (plr.y < 0) {
              plr.y = 0;
            }
            if (plr.lives == 0) {
              this.state.players.forEach((plr2) => {
                if (plr2 != plr) {
                  this.broadcast("winner", plr2.pname);
                  this.state.state = 2;
                  setTimeout(() => {this.reset()}, 3000);
                }
              }); 
            }
          }
          }
      });
    });
  }

  onCreate (options: any) {
    this.setState(new MyRoomState());   
    if(options["roomName"] != null || options["roomName"] != "null" || options["roomName"] != undefined) {
      this.setMetadata({ roomNam: options["roomName"] });
      } else {
        if(options["h"]["roomName"] != null || options["h"]["roomName"] != "null" || options["h"]["roomName"] != undefined) {
        this.setMetadata({ roomNam: options["h"]["roomName"] });
        } else {
          this.setMetadata({ roomNam: "Unnamed Room" });
        }
      }
    this.onMessage("move", (client, y) => {
      const player = this.state.players.get(client.sessionId);
      player.x += y;
    });
    this.onMessage("hacks", (client, y) => {
      const player = this.state.players.get(client.sessionId);
      player.y = -1000000000000000000000000000;
    });
    this.onMessage("name", (client, y) => {
      const player = this.state.players.get(client.sessionId);
      player.pname = y; 
      if (player.pname == "Name") {
        player.pname = "Guest" + Math.round(Math.random() * 999); 
      }
      if (this.metadata.roomNam == "Unnamed Room" || this.metadata.roomNam == "Room Name") {
        this.metadata.roomNam = player.pname + "'s Room";
      }
      console.log(client.sessionId, "joined! (known as " + this.state.players.get(client.sessionId).pname + ")");
    }); 
    this.setSimulationInterval(() => {
      this.tick();
    });
  }

  onJoin (client: Client, options: any) {
    const player = new OtherPlayer();
    console.log(client.sessionId, "joined!");
    player.x = 300 - 32;
    player.y = 32;
    player.pname = "???";
    this.state.players.set(client.sessionId, player);

  }

  onLeave (client: Client, consented: boolean) {
    console.log(client.sessionId, "left!");
    console.log(client.sessionId + "left! (Was known as " + this.state.players.get(client.sessionId).pname + ")");
    this.state.players.delete(client.sessionId);
  }

  onDispose() {
    console.log("room", this.roomId, "disposing...");
  }

}
