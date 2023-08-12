import { Schema, Context, type, MapSchema } from "@colyseus/schema";

export class Enemy extends Schema {
  @type("number") x: number;
  @type("number") y: number;
}
export class Powerup extends Schema {
  @type("number") x: number;
  @type("number") y: number;
  @type("string") key: string = "0";
}
export class Power extends Schema {
  @type("string") name: string = "Power";
  @type("string") asset: string = "Power";
}
export class OtherPlayer extends Schema {
  @type("number") x: number;
  @type("number") y: number;
  @type("number") lives: number = 3;
  @type("boolean") isGrazing: boolean = false;
  @type("number") points: number = 999;
  @type("number") enemycount: number = 0;
  @type("number") enemycountscr: number = 0;
  @type("number") powerupcount: number = 0;
  @type("string") pname: string;
  @type({ map: Enemy }) enemies = new MapSchema<Enemy>();
  @type({ map: Powerup }) powerups = new MapSchema<Powerup>();
  @type({ map: Power }) currentpowers = new MapSchema<Power>();
}

export class MyRoomState extends Schema {
  
  @type({ map: OtherPlayer }) players = new MapSchema<OtherPlayer>();
  @type("number") state:number = 0;

}
