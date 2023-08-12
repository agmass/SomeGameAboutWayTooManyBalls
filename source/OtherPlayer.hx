// 
// THIS FILE HAS BEEN GENERATED AUTOMATICALLY
// DO NOT CHANGE IT MANUALLY UNLESS YOU KNOW WHAT YOU'RE DOING
// 
// GENERATED USING @colyseus/schema 2.0.11
// 


import io.colyseus.serializer.schema.Schema;
import io.colyseus.serializer.schema.types.*;

class OtherPlayer extends Schema {
	@:type("number")
	public var x: Dynamic = 0;

	@:type("number")
	public var y: Dynamic = 0;

	@:type("number")
	public var lives: Dynamic = 0;

	@:type("boolean")
	public var isGrazing: Bool = false;

	@:type("number")
	public var points: Dynamic = 0;

	@:type("number")
	public var enemycount: Dynamic = 0;

	@:type("number")
	public var enemycountscr: Dynamic = 0;

	@:type("number")
	public var powerupcount: Dynamic = 0;

	@:type("string")
	public var pname: String = "";

	@:type("map", Enemy)
	public var enemies: MapSchema<Enemy> = new MapSchema<Enemy>();

	@:type("map", Powerup)
	public var powerups: MapSchema<Powerup> = new MapSchema<Powerup>();

	@:type("map", Power)
	public var currentpowers: MapSchema<Power> = new MapSchema<Power>();

}
