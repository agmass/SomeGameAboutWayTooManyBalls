package;

import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR2i2688521R3y5:MUSICR5y28:assets%2Fmusic%2Fwaiting.mp3y9:pathGroupaR8y28:assets%2Fmusic%2Fwaiting.wavhR6tgoR2i11843514R3y5:SOUNDR5R10R9aR8R10hgoR2i1625860R3R7R5y27:assets%2Fmusic%2Fguitar.mp3R9aR12y27:assets%2Fmusic%2Fguitar.wavhR6tgoR2i7288494R3R11R5y25:assets%2Fmusic%2Flofi.wavR9aR14y25:assets%2Fmusic%2Flofi.mp3hR6tgoR2i1286268R3R7R5y26:assets%2Fmusic%2Fsynth.mp3R9aR16y26:assets%2Fmusic%2Fsynth.wavhR6tgoR2i1310301R3R7R5y25:assets%2Fmusic%2Fupsc.mp3R9aR18y25:assets%2Fmusic%2Fupsc.wavhR6tgoR2i7156826R3R11R5R13R9aR12R13hgoR2i2216227R3R7R5y26:assets%2Fmusic%2Fintro.mp3R9aR20y26:assets%2Fmusic%2Fintro.wavhR6tgoR2i9762462R3R11R5R21R9aR20R21hgoR2i1655117R3R7R5R15R9aR14R15hgoR2i5660178R3R11R5R17R9aR16R17hgoR2i5767694R3R11R5R19R9aR18R19hgoR2i8202650R3R11R5y29:assets%2Fmusic%2Ftryagain.wavR9aR22hR6tgoR0y30:assets%2Fimages%2F-3_balls.pngR2i274R3y5:IMAGER5R23R6tgoR0y26:assets%2Fimages%2Fwtmb.pngR2i4330R3R24R5R25R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R26R6tgoR0y33:assets%2Fimages%2Ftime_freeze.pngR2i541R3R24R5R27R6tgoR0y31:assets%2Fimages%2F2x_points.pngR2i328R3R24R5R28R6tgoR0y26:assets%2Fimages%2FBall.pngR2i1025R3R24R5R29R6tgoR0y36:assets%2Fimages%2F2x_points.asepriteR2i757R3y6:BINARYR5R30R6tgoR0y30:assets%2Fimages%2Fpowerorb.pngR2i146R3R24R5R32R6tgoR0y38:assets%2Fimages%2Ftime_freeze.asepriteR2i1056R3R31R5R33R6tgoR0y32:assets%2Fimages%2Fmap_1.asepriteR2i26090R3R31R5R34R6tgoR0y37:assets%2Fimages%2Finvincible_ball.pngR2i333R3R24R5R35R6tgoR0y30:assets%2Fimages%2Flogotext.pngR2i61211R3R24R5R36R6tgoR0y28:assets%2Fimages%2Fmenubg.pngR2i6493R3R24R5R37R6tgoR0y42:assets%2Fimages%2Finvincible_ball.asepriteR2i781R3R31R5R38R6tgoR0y35:assets%2Fimages%2F-3_balls.asepriteR2i726R3R31R5R39R6tgoR0y28:assets%2Fimages%2F1_life.pngR2i254R3R24R5R40R6tgoR0y28:assets%2Fimages%2Fracebg.pngR2i6262R3R24R5R41R6tgoR0y28:assets%2Fimages%2Fmainbg.pngR2i5389R3R24R5R42R6tgoR0y33:assets%2Fimages%2F1_life.asepriteR2i753R3R31R5R43R6tgoR2i7962R3R11R5y26:assets%2Fsounds%2Fhurt.wavR9aR44hR6tgoR2i3985R3R11R5y27:assets%2Fsounds%2Fshoot.wavR9aR45hR6tgoR2i6569R3R11R5y28:assets%2Fsounds%2Fclicky.wavR9aR46hR6tgoR2i506994R3R11R5y27:assets%2Fsounds%2Fsound.wavR9aR47hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R48R6tgoR2i32090R3R11R5y31:assets%2Fsounds%2Fexplosion.wavR9aR49hR6tgoR2i8220R3R7R5y26:flixel%2Fsounds%2Fbeep.mp3R9aR50y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R7R5y28:flixel%2Fsounds%2Fflixel.mp3R9aR52y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i6840R3R11R5R51R9aR50R51hgoR2i33629R3R11R5R53R9aR52R53hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R54R55y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R24R5R60R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R24R5R61R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pngR2i534R3R24R5R62R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pngR2i201R3R24R5R63R6tgoR0y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pngR2i210R3R24R5R64R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pngR2i147R3R24R5R65R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pngR2i294R3R24R5R66R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pngR2i922R3R24R5R67R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pngR2i433R3R24R5R68R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pngR2i1724R3R24R5R69R6tgoR0y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pngR2i129R3R24R5R70R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pngR2i192R3R24R5R71R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pngR2i191R3R24R5R72R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pngR2i946R3R24R5R73R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pngR2i128R3R24R5R74R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pngR2i247R3R24R5R75R6tgoR0y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pngR2i493R3R24R5R76R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pngR2i214R3R24R5R77R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pngR2i136R3R24R5R78R6tgoR0y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pngR2i511R3R24R5R79R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pngR2i912R3R24R5R80R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pngR2i446R3R24R5R81R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pngR2i185R3R24R5R82R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pngR2i153R3R24R5R83R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pngR2i156R3R24R5R84R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pngR2i212R3R24R5R85R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pngR2i253R3R24R5R86R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pngR2i459R3R24R5R87R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pngR2i18509R3R24R5R88R6tgoR0y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlR2i1848R3R4R5R89R6tgoR0y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlR2i1263R3R4R5R90R6tgoR0y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlR2i1953R3R4R5R91R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_waiting_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_waiting_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_guitar_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_lofi_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_synth_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_upsc_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_guitar_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_intro_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_intro_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_lofi_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_synth_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_upsc_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_tryagain_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images__3_balls_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_wtmb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_time_freeze_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_2x_points_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_2x_points_aseprite extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_powerorb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_time_freeze_aseprite extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_map_1_aseprite extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_invincible_ball_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_logotext_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_menubg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_invincible_ball_aseprite extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images__3_balls_aseprite extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_life_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_racebg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_mainbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_1_life_aseprite extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_hurt_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_shoot_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_clicky_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sound_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_explosion_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/music/waiting.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_waiting_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/waiting.wav") @:noCompletion #if display private #end class __ASSET__assets_music_waiting_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/guitar.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_guitar_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/lofi.wav") @:noCompletion #if display private #end class __ASSET__assets_music_lofi_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/synth.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_synth_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/upsc.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_upsc_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/guitar.wav") @:noCompletion #if display private #end class __ASSET__assets_music_guitar_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/intro.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_intro_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/intro.wav") @:noCompletion #if display private #end class __ASSET__assets_music_intro_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/lofi.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_lofi_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/music/synth.wav") @:noCompletion #if display private #end class __ASSET__assets_music_synth_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/upsc.wav") @:noCompletion #if display private #end class __ASSET__assets_music_upsc_wav extends haxe.io.Bytes {}
@:keep @:file("assets/music/tryagain.wav") @:noCompletion #if display private #end class __ASSET__assets_music_tryagain_wav extends haxe.io.Bytes {}
@:keep @:image("assets/images/-3_balls.png") @:noCompletion #if display private #end class __ASSET__assets_images__3_balls_png extends lime.graphics.Image {}
@:keep @:image("assets/images/wtmb.png") @:noCompletion #if display private #end class __ASSET__assets_images_wtmb_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/time_freeze.png") @:noCompletion #if display private #end class __ASSET__assets_images_time_freeze_png extends lime.graphics.Image {}
@:keep @:image("assets/images/2x_points.png") @:noCompletion #if display private #end class __ASSET__assets_images_2x_points_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Ball.png") @:noCompletion #if display private #end class __ASSET__assets_images_ball_png extends lime.graphics.Image {}
@:keep @:file("assets/images/2x_points.aseprite") @:noCompletion #if display private #end class __ASSET__assets_images_2x_points_aseprite extends haxe.io.Bytes {}
@:keep @:image("assets/images/powerorb.png") @:noCompletion #if display private #end class __ASSET__assets_images_powerorb_png extends lime.graphics.Image {}
@:keep @:file("assets/images/time_freeze.aseprite") @:noCompletion #if display private #end class __ASSET__assets_images_time_freeze_aseprite extends haxe.io.Bytes {}
@:keep @:file("assets/images/map_1.aseprite") @:noCompletion #if display private #end class __ASSET__assets_images_map_1_aseprite extends haxe.io.Bytes {}
@:keep @:image("assets/images/invincible_ball.png") @:noCompletion #if display private #end class __ASSET__assets_images_invincible_ball_png extends lime.graphics.Image {}
@:keep @:image("assets/images/logotext.png") @:noCompletion #if display private #end class __ASSET__assets_images_logotext_png extends lime.graphics.Image {}
@:keep @:image("assets/images/menubg.png") @:noCompletion #if display private #end class __ASSET__assets_images_menubg_png extends lime.graphics.Image {}
@:keep @:file("assets/images/invincible_ball.aseprite") @:noCompletion #if display private #end class __ASSET__assets_images_invincible_ball_aseprite extends haxe.io.Bytes {}
@:keep @:file("assets/images/-3_balls.aseprite") @:noCompletion #if display private #end class __ASSET__assets_images__3_balls_aseprite extends haxe.io.Bytes {}
@:keep @:image("assets/images/1_life.png") @:noCompletion #if display private #end class __ASSET__assets_images_1_life_png extends lime.graphics.Image {}
@:keep @:image("assets/images/racebg.png") @:noCompletion #if display private #end class __ASSET__assets_images_racebg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/mainbg.png") @:noCompletion #if display private #end class __ASSET__assets_images_mainbg_png extends lime.graphics.Image {}
@:keep @:file("assets/images/1_life.aseprite") @:noCompletion #if display private #end class __ASSET__assets_images_1_life_aseprite extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/hurt.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_hurt_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/shoot.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_shoot_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/clicky.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_clicky_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sound.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sound_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/explosion.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_explosion_wav extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,3,1/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,3,1/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,3,1/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel/5,3,1/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("/home/agmas/haxelib/flixel/5,3,1/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel/5,3,1/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/button_toggle.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/tab.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/tab_back.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/plus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/finger_small.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/check_box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/button.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/finger_big.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/hilight.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/chrome_inset.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/radio.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/check_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/invis.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/button_thin.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/button_arrow_up.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/chrome_light.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/minus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/button_arrow_right.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/button_arrow_down.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/swatch.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/radio_dot.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/dropdown_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/chrome_flat.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/chrome.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/button_arrow_left.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("/home/agmas/haxelib/flixel-ui/2,5,0/assets/images/tooltip_arrow.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("/home/agmas/haxelib/flixel-ui/2,5,0/assets/xml/default_popup.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel-ui/2,5,0/assets/xml/defaults.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("/home/agmas/haxelib/flixel-ui/2,5,0/assets/xml/default_loading_screen.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end

#end