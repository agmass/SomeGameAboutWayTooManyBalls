package;

import flixel.sound.FlxSound;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUIInputText;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class NameState extends FlxState
{
	public static var playerName:String = "??";
	public static var tojoin:String = null;
	public static var tocreate:String = null;

	var name:FlxUIInputText;
	var roomname:FlxUIInputText;
	var createroom:FlxText;
	var joinroom:FlxText;
	var joinroom2:FlxText;
	var bg:FlxSprite = new FlxSprite(0,0,AssetPaths.menubg__png);

	override public function create()
	{
		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();
		FlxG.sound.music = new FlxSound();
		FlxG.sound.music.loadEmbedded(AssetPaths.lofi__wav, true);
		FlxG.sound.music.fadeIn();
		FlxG.camera.fade(FlxColor.BLACK, 0.5, true);
		bg.y = (-bg.height / 2.75) - (FlxG.mouse.y - FlxG.height / 2) / 2;
		bg.scale.set(0.5,0.5);
		add(bg);
		name = new FlxUIInputText(0, 0, 256, "Name", 8);
		name.screenCenter();
		name.y -= 32;
		add(name);

		createroom = new FlxText(0, 0, 0, "Create Room", 16);
		createroom.screenCenter();
		createroom.y += 32;
		add(createroom);

		joinroom = new FlxText(0, 0, 0, "Room Browser", 16);
		joinroom.screenCenter();
		joinroom.y += 64;
		add(joinroom);

		joinroom2 = new FlxText(0, 0, 0, "Quickplay", 16);
		joinroom2.color = FlxColor.BLUE;
		joinroom2.screenCenter();
		add(joinroom2);

		roomname = new FlxUIInputText(0, 0, 256, "Room Name", 8);
		roomname.screenCenter();
		roomname.y -= 64;
		add(roomname);

		super.create();
		FlxG.camera.zoom = 2;
	}

	override public function update(elapsed:Float)
	{
		FlxTween.tween(bg, {y: (-bg.height / 2.75) - (FlxG.mouse.y - FlxG.height / 2) / 8}, 0.075);
		bg.alpha = 0.5;
		FlxG.autoPause = false;
		createroom.scale.set(0.75, 0.75);
		createroom.color = FlxColor.WHITE;
		if (FlxG.mouse.overlaps(createroom))
		{
			createroom.scale.set(1, 1);
			createroom.color = FlxColor.YELLOW;
			playerName = name.text;
			if (FlxG.mouse.justPressed)
			{
				tocreate = roomname.text;
				FlxG.switchState(new PlayState());
			}
		}
		joinroom.scale.set(0.75, 0.75);
		joinroom.color = FlxColor.WHITE;
		if (FlxG.mouse.overlaps(joinroom))
		{
			joinroom.scale.set(1, 1);
			joinroom.color = FlxColor.YELLOW;
			playerName = name.text;
			if (FlxG.mouse.justPressed)
				FlxG.switchState(new RoomsState());
		}
		joinroom2.scale.set(0.75, 0.75);
		joinroom2.color = FlxColor.WHITE;
		if (FlxG.mouse.overlaps(joinroom2))
		{
			joinroom2.scale.set(1, 1);
			joinroom2.color = FlxColor.YELLOW;
			playerName = name.text;
			if (FlxG.mouse.justPressed)
			{
				tojoin = "quick";
				FlxG.switchState(new PlayState());
			}
		}
		super.update(elapsed);
	}
}
