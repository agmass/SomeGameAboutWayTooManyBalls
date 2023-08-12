package;

import flixel.sound.FlxSound;
import flixel.ui.FlxBar;
import flixel.group.FlxGroup;
import flixel.effects.particles.FlxEmitter;
import flixel.addons.plugin.taskManager.FlxTask;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import io.colyseus.error.MatchMakeError;
import io.colyseus.Room;
import io.colyseus.Client;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;

class PlayState extends FlxState
{
	var roomCode:FlxText = new FlxText(0, FlxG.height - 128, 0, "Room Code: ", 16);
	var otherPlayers:FlxSpriteGroup = new FlxSpriteGroup(0, 0);
	

	var client = new Client("wss://ws.agmas.org");
	var waittext:FlxText = new FlxText(0,0,0,"Waiting for an opponent...", 32);
	var roome:Room<MyRoomState> = null;
	var cam1:FlxCamera = new FlxCamera(20,20, 600, 700-20);
	var cam2:FlxCamera = new FlxCamera(FlxG.width-620,20, 600, 700-20);
	var winnertext:FlxText = new FlxText(0, 0, 0, ",,,", 32);
	override public function create()
	{	
		FlxG.autoPause = false;
		var mainbg:FlxSprite = new FlxSprite(0,0,AssetPaths.mainbg__png);
		add(mainbg);
		var bg:FlxSprite = new FlxSprite(0,0,AssetPaths.racebg__png);
		bg.cameras = [cam1, cam2];
		add(bg);
		FlxG.cameras.add(cam1);
		FlxG.cameras.add(cam2);
		
		super.create();
		waittext.screenCenter();
		waittext.color = FlxColor.RED;
		if (NameState.tojoin == null)
			{
				client.create("myRoom", ["roomName" => NameState.tocreate], MyRoomState, function(err, room)
				{
					roome = room;
					epic(err, room);
				});
			}
			else
			{
				if (NameState.tojoin == "quick") {
					client.joinOrCreate("myRoom", [], MyRoomState, function(err, room)
						{
							roome = room;
							epic(err, room);
						});
				} else {
				client.joinById(NameState.tojoin, [], MyRoomState, function(err, room)
				{
					roome = room;
					epic(err, room);
				});
			}
			}
	}

	override public function update(elapsed:Float)
	{
		if (roome != null) {
		if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
			roome.send("move", -4);
		}
		if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
			roome.send("move", 4);
		}
		if (FlxG.keys.justPressed.ESCAPE && FlxG.state.subState == null)
			{
				var tempState:MenuSubState = new MenuSubState();
				openSubState(tempState);
			}
	
	}
		super.update(elapsed);
	}

	override public function destroy() {
		roome.leave();
		super.destroy();
	}

	function epic(err:MatchMakeError, room:Room<MyRoomState>)
		{
			roome = room;				
			if (err != null)
			{
				trace("JOIN ERROR: " + err);
				return;
			}
			room.send("name", NameState.playerName.split(".")[0]);
			trace("Joined with success!");
			trace(NameState.playerName);
			var t:FlxCamera = new FlxCamera(0,0,0,0);
			FlxG.cameras.add(t, false);
			t.bgColor.alpha = 0;
			winnertext.camera= t;
			winnertext.visible = false;
			add(winnertext);
			if (FlxG.sound.music != null)
				FlxG.sound.music.stop();
			FlxG.sound.music = new FlxSound();
			FlxG.sound.music.loadEmbedded(AssetPaths.waiting__mp3, true);
			FlxG.sound.music.fadeIn();
			var noPlayer:FlxText = new FlxText(0,0,0,"Waiting for\nother player...", 32);
			add(noPlayer);
			noPlayer.camera = cam2;
			noPlayer.x = 300 - noPlayer.width / 2;
			noPlayer.y = 340 - noPlayer.height / 2;
			var curstate:Int = 0;
			room.state.listen("state", (c, p) -> {
				curstate = c;
				if (c == 1) {
					noPlayer.visible = false;
					
				if (FlxG.sound.music != null)
					FlxG.sound.music.fadeOut(1);
				FlxG.sound.music = new FlxSound();
				FlxG.sound.music.loadEmbedded(AssetPaths.upsc__mp3, true);
				FlxG.sound.music.fadeIn();
				}
				if (c == 2) {
					if (FlxG.sound.music != null)
						FlxG.sound.music.fadeOut(1);
					FlxG.sound.music = new FlxSound();
					FlxG.sound.music.loadEmbedded(AssetPaths.synth__wav, true);
					FlxG.sound.music.fadeIn();
				}
				if (c == 0) {
					noPlayer.visible = true;
					if (FlxG.sound.music != null)
						FlxG.sound.music.fadeOut(2);
					FlxG.sound.music = new FlxSound();
					FlxG.sound.music.loadEmbedded(AssetPaths.waiting__mp3, true);
					FlxG.sound.music.fadeIn();
				}
			});
			
			room.onMessage("startGame", function(y)
			{
				cam1.fade(FlxColor.BLACK, 0.15);
				cam2.fade(FlxColor.BLACK, 0.15);
				FlxG.camera.fade(FlxColor.BLACK, 0.25, false, function()
				{
					FlxG.camera.fade(FlxColor.BLACK, 0.25, true);
					cam2.fade(FlxColor.BLACK, 0.25, true);
					cam1.fade(FlxColor.BLACK, 0.25, true);
				});
				
			});

			room.onMessage("finish", function(y)
				{
					cam1.flash(FlxColor.WHITE, 0.15);
				});
			room.onMessage("winner", function(y)
			{
				FlxG.camera.fade(FlxColor.BLACK, 1, false);
				cam1.fade(FlxColor.BLACK, 1, false);
				cam2.fade(FlxColor.BLACK, 1, false);
				var alltheparts:FlxGroup = new FlxGroup();
				otherPlayers.forEach((op) -> {
					op.visible = false;
					
					var particles:FlxEmitter = new FlxEmitter(op.x, op.y);
					particles.makeParticles(4,4, op.color, 30);
					//particles.speed.set(particles.speed.start.min/2,particles.speed.start.min/2,particles.speed.end.min/2,particles.speed.end.min/2);
					particles.start(true, 0, 0);
					particles.camera = op.camera;
					alltheparts.add(particles);
					add(particles);
				});
				winnertext.text = y + " Wins!";
				winnertext.visible = true;
				winnertext.alpha = 0.25;
				winnertext.screenCenter();
				winnertext.scale.set(0.5, 0.5);
				FlxTween.tween(winnertext, {alpha: 1, "scale.x": 1, "scale.y": 1}, 1.25, {
					ease: FlxEase.smoothStepOut,
					onComplete: function(twn)
					{
						new FlxTimer().start(4, function(twn)
						{
							winnertext.visible = false;
							alltheparts.forEach((p) -> {
								remove(p);
								p.destroy();
							});
							otherPlayers.forEach((op) -> {
								op.visible = true;
								if (op.health != 6) {
									remove(op);
									op.destroy();
								}
							});
							FlxG.camera.fade(FlxColor.WHITE, 0.25, true);
							cam1.fade(FlxColor.WHITE, 0.25, true);
							cam2.fade(FlxColor.WHITE, 0.25, true);
						});
					}
				});
			});
	
			room.state.players.onAdd(function(item:OtherPlayer, key:String)
			{
				trace("New player!");
					var newPlayer:FlxSprite = new FlxSprite(item.x, item.y);
					newPlayer.loadGraphic(AssetPaths.Ball__png, true, 32, 32);
					newPlayer.animation.add("1", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16], 8);
					otherPlayers.add(newPlayer);
					otherPlayers.immovable = true;
					newPlayer.health = 6;
					var newGraze:FlxSprite = new FlxSprite(item.x, item.y);
					newGraze.loadGraphic(AssetPaths.Ball__png, true, 32, 32);
					newGraze.animation.add("1", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]);
					add(newGraze);
					add(newPlayer);
					newPlayer.animation.play("1");
					newGraze.scale.set(4,4);
					newGraze.alpha = 0;
					newGraze.animation.play("1");
					var playerNm:FlxText = new FlxText(0, 0, 0, "", 16);
					playerNm.color = FlxColor.BLACK;
					playerNm.text = item.pname;
					playerNm.alpha = 0.75;
					var playerPts:FlxText = new FlxText(0, 18, 0, "", 16);
					var plrLives:FlxBar = new FlxBar(600 - 120, 20, FlxBarFillDirection.LEFT_TO_RIGHT, 100, 20);
					plrLives.createFilledBar(FlxColor.GRAY, FlxColor.RED, true, FlxColor.BLACK);
					add(plrLives);		
					plrLives.value = 3;
					plrLives.setRange(0, 3);
					plrLives.alpha = 0.75;
					playerPts.color = FlxColor.GREEN;
					playerPts.text = item.pname;
					playerPts.alpha = 1;
					if (key != roome.sessionId)
					{
						newPlayer.camera = cam2;
						newPlayer.color = FlxColor.RED;
					} else {
						newPlayer.camera = cam1;
						newPlayer.color = FlxColor.BLUE;
					}
					plrLives.camera = newPlayer.camera;
					playerNm.camera = newPlayer.camera;
					add(playerNm);
					playerPts.camera = newPlayer.camera;
					add(playerPts);
					item.listen("lives", (c, p) -> {
						plrLives.value = c;
						FlxG.sound.play(AssetPaths.explosion__wav);
					});
					item.listen("isGrazing", (c, p) -> {
						newGraze.alpha = c ? 0.5 : 0;
						FlxG.sound.play(AssetPaths.hurt__wav);
					});
					newGraze.camera = newPlayer.camera;
					var curpwrs:FlxSpriteGroup = new FlxSpriteGroup(0, 0);
					curpwrs.camera = newPlayer.camera;
					var pwt = new FlxTimer().start(0.166667, function(tmr2) {
						var h = 0;
					for (i in curpwrs) {
						i.x = 32 * h;
						h++;

					}
					}, 0);
					item.onRemove(() ->
					{
						pwt.cancel();
						remove(newPlayer);
						remove(playerNm);
						newPlayer.destroy();
						remove(playerPts);
						playerPts.destroy();
						playerNm.destroy();
					});
	
					item.enemies.onAdd((item2, key) -> {
						var newEnemy:FlxSprite = new FlxSprite(item2.x, item2.y);
						newEnemy.loadGraphic(AssetPaths.Ball__png, true, 32, 32);
						newEnemy.animation.add("1", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16], 8);
						newEnemy.color = newPlayer.color == FlxColor.BLUE ? FlxColor.RED : FlxColor.BLUE;
						add(newEnemy);
						otherPlayers.add(newEnemy);
						item2.onRemove(() ->
						{
							remove(newEnemy);
							newEnemy.destroy();
						});
						newEnemy.animation.play("1");
						newEnemy.camera = newPlayer.camera;
						item2.listen("x", (c, p) -> {
							var xsixteen:Int = c;
							FlxTween.tween(newEnemy, {x: c}, 0.075);
						});
						item2.listen("y", (c, p) -> {
							var xsixteen:Int = c;
							var xsixteen2:Int = c;
							FlxTween.tween(newEnemy, {y: c}, 0.00001);
						});
					});
					item.currentpowers.onAdd((item2, key) -> {
						var powerdisplay:FlxSprite = new FlxSprite(0,0,item2.asset);
						var powertext:FlxText = new FlxText(0,0,powerdisplay.width,item2.name,8);
						powerdisplay.alpha = 0;
						powertext.alpha = 0;
						powerdisplay.camera = newPlayer.camera;
						powertext.camera = newPlayer.camera;
						powerdisplay.y = 680 - powerdisplay.height;
						
						powertext.y = (680 - powerdisplay.height) - powertext.height;
						add(powerdisplay);
						add(powertext);
						FlxTween.tween(powerdisplay, {alpha: 0.75}, 0.25);
						FlxTween.tween(powertext, {alpha: 0.75}, 0.25);
						curpwrs.add(powerdisplay);
						var tmr = new FlxTimer().start(0.166667, function(tmr2) {
							powertext.x = powerdisplay.x;
						}, 0);
						item2.onRemove(() ->
						{
							tmr.cancel();
							curpwrs.remove(powerdisplay);
							remove(powerdisplay);
							powerdisplay.destroy();
							remove(powertext);
							powertext.destroy();
						});
					});
					item.powerups.onAdd((item2, key) -> {
						var newEnemy:FlxSprite = new FlxSprite(item2.x, item2.y);
						newEnemy.loadGraphic(AssetPaths.powerorb__png, true, 16, 16);
						add(newEnemy);
						otherPlayers.add(newEnemy);
						item2.onRemove(() ->
						{
							remove(newEnemy);
							newEnemy.destroy();
						});
						newEnemy.camera = newPlayer.camera;
						item2.listen("x", (c, p) -> {
							var xsixteen:Int = c;
							FlxTween.tween(newEnemy, {x: c}, 0.075);
						});
						item2.listen("y", (c, p) -> {
							var xsixteen:Int = c;
							var xsixteen2:Int = c;
							FlxTween.tween(newEnemy, {y: c}, 0.00001);
						});
					});
						item.listen("points", (c,p) -> 
							{
								playerPts.text = c + " points";
							}
						);
						item.listen("enemycount", (c,p) -> 
						{
							var enemyplusText:FlxText = new FlxText(0,0,0,"+" + (c - p) + " enemies!", 32);
							enemyplusText.color = FlxColor.RED;
							if (c == p || c - p == 0 || curstate == 0 || curstate == 2) {
								enemyplusText.visible = false;
							}
							if (p > c) {
								enemyplusText.text = "-" + Math.abs((c - p)) + " enemies!";
								enemyplusText.color = FlxColor.GREEN;
							}
							enemyplusText.x = 300 - enemyplusText.width / 2;
							enemyplusText.y = 680 /2;
							FlxTween.tween(enemyplusText, {alpha: 0}, 1.5, {onComplete: (twn) -> {
								remove(enemyplusText);
								enemyplusText.destroy();
							}});
							enemyplusText.camera = newPlayer.camera;
							add(enemyplusText);
						}
						);
							item.listen("x", (c, p) -> {
								var xsixteen:Int = c;
								FlxTween.tween(newPlayer, {x: c}, 0.075);
								FlxTween.tween(newGraze, {x: c}, 0.05);
							});
							item.listen("y", (c, p) -> {
								var xsixteen:Int = c;
								var xsixteen2:Int = c;
								FlxTween.tween(newPlayer, {y: c}, 0.05);
								FlxTween.tween(newGraze, {y: c}, 0.05);
							});
			});
		}

}
