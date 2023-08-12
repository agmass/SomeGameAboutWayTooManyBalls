package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Int64Helper;

class MenuSubState extends FlxSubState
{
	var selection:Int = 0;
	var title:FlxText;
	var play:FlxText;
	var menu:FlxText;
	var restart:FlxText;
	var saves:FlxText;
	var sprite:FlxSprite = new FlxSprite(0, 0);
	var pausemenumusic = new flixel.sound.FlxSound();

	override public function create():Void
	{
		_parentState.persistentUpdate = true;
        _parentState.persistentDraw = true;
		FlxG.sound.music.fadeOut(0.5);
		pausemenumusic.loadEmbedded(AssetPaths.tryagain__wav, true);
		pausemenumusic.fadeIn(0.5);
		pausemenumusic.play();
		sprite.makeGraphic(400, 680, FlxColor.BLACK);
		sprite.alpha = 0;
		sprite.scrollFactor.set(0, 0);
		sprite.camera = FlxG.cameras.list[1];
		sprite.x = 600;
		add(sprite);
		super.create();
		title = new FlxText(0, 0, 0, "PAUSED", 32);
		title.y = 300 - title.height / 2;
		title.x = 600;
		title.color = FlxColor.WHITE;
		title.scrollFactor.set(0, 0);
		title.y -= 64;
		title.alpha = 0;
		FlxTween.tween(title, {alpha: 1, x: (sprite.x - sprite.width / 2) - title.textField.width / 2}, 0.25, {ease: FlxEase.sineInOut});
		title.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(title);
		title.camera = FlxG.cameras.list[1];

		play = new FlxText(0, 0, 0, "Return To Game", 16);
		play.y = 300 - play.height/2;
		play.x = 600;
		play.scrollFactor.set(0, 0);
		play.y -= 16;
		play.alpha = 0;
		FlxTween.tween(play, {alpha: 0.75, x: (sprite.x - sprite.width / 2) - play.textField.width / 2}, 0.25, {ease: FlxEase.sineInOut});
		play.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(play);
		play.camera = FlxG.cameras.list[1];

		menu = new FlxText(0, 0, 0, "Return to Menu", 16);
		menu.y = 300 - menu.height/2;
		menu.x = 600;
		menu.scrollFactor.set(0, 0);
		menu.alpha = 0;
		FlxTween.tween(menu, {alpha: 0.75, x: (sprite.x - sprite.width / 2) - menu.textField.width / 2}, 0.25, {ease: FlxEase.sineInOut});
		menu.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1, 1);
		add(menu);
		menu.camera = FlxG.cameras.list[1];
		FlxTween.tween(sprite, {alpha: 0.5, x: 600 - sprite.width}, 0.25, {ease: FlxEase.sineInOut});
	}

	override public function update(elapsed:Float):Void
	{
		if (selection != 100)
		{
			if (FlxG.keys.justPressed.UP)
			{
				selection -= 1;
			}
			if (FlxG.keys.justPressed.DOWN)
			{
				selection += 1;
			}
			if (selection <= -1)
			{
				selection = 50;
			}
			if (selection >= 2)
			{
				selection = 0;
			}

			play.color = FlxColor.WHITE;
			play.scale.set(0.75, 0.75);
			play.alpha = 0.75;

			menu.color = FlxColor.WHITE;
			menu.scale.set(0.75, 0.75);
			menu.alpha = 0.75;

			switch (selection)
			{
				case 0:
					play.color = FlxColor.YELLOW;
					play.scale.set(1.25, 1.25);
					play.alpha = 1;
					if (FlxG.keys.justPressed.ENTER)
					{
						pausemenumusic.fadeOut(0.5);
						FlxG.sound.music.fadeIn(0.5);
                 
						selection = 100;
						FlxG.sound.play(AssetPaths.sound__wav);
						FlxTween.tween(sprite, {alpha: 0, x: 600}, 0.1, {ease: FlxEase.sineInOut});
						FlxTween.tween(play, {alpha: 0, x: 600}, 0.1, {ease: FlxEase.sineInOut});
						FlxTween.tween(menu, {alpha: 0, x: 600}, 0.1, {ease: FlxEase.sineInOut});
						FlxTween.tween(title, {alpha: 0, x: 600}, 0.1, {ease: FlxEase.sineInOut});
						new FlxTimer().start(0.1, function(tmr)
						{
							close();
						});
					}
				case 1:
					menu.color = FlxColor.YELLOW;
					menu.scale.set(1.25, 1.25);
					menu.alpha = 1;
					if (FlxG.keys.justPressed.ENTER)
					{
						pausemenumusic.fadeOut(0.5);
						FlxG.sound.music.stop();
						selection = 100;
                        
						FlxG.sound.play(AssetPaths.sound__wav);
						FlxG.cameras.list[1].fade(FlxColor.BLACK, 0.5, false, function funny()
						{
							new FlxTimer().start(1.5, function(tmr)
							{
                                close();
								FlxG.switchState(new NameState());
							});
						});
					}
			}
		}
		super.update(elapsed);
	}
}