package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author neocrey
	 */
	public class MenuState extends FlxState
	{
		[Embed(source = "data/coin.mp3")]
		private var Coin:Class;
		
		[Embed(source = "data/rtw.mp3")]
		private var st:Class;
		
		override public function create():void 
		{
			
			FlxG.bgColor = 0xff000000;
			
			var text:FlxText;
			text = new FlxText(0, 5, 320, "Rob this tiny world!");
			text.color = 0xefef00;
			text.alignment = "center";
			text.size = 30;
			text.shadow=0xffffff;
			add(text);
			
			var text2:FlxText;
			text2 = new FlxText(60,80,200,"made for Ludum Dare #23");
			text2.alignment = "center";
			text2.color = 0x9090FF;
			text2.size = 12;
			text2.shadow=0xffffff;
			add(text2);
			
			var text4:FlxText;
			text4 = new FlxText(40,97,240,"by neocrey (c) 2012 by-nc-sa");
			text4.alignment = "center";
			text4.color = 0x9090FF;
			text4.size = 12;
			text4.shadow=0xffffff;
			add(text4);
			
			var text3:FlxText;
			text3 = new FlxText(10,130,300,"Use WAD keys to rob the cities of the tiny world and return to home. Avoid meeting with flying police. That's all! Have fun!)");
			text3.alignment = "left";
			text3.color = 0x08909F;
			text3.size = 14;
			text3.shadow=0xF3Fe68;
			add(text3);
			
			var text5:FlxText;
			text5 = new FlxText(45,210,300,"Press SPACE to start the game");
			text5.alignment = "left";
			text5.color = 0xffffff;
			text5.size = 12;
			add(text5);
			
			FlxG.playMusic(st, 1);
			FlxG.mouse.show();
			
		}
		
		override public function update():void
		{	
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.play(Coin,1,false);
				FlxG.fade(0xff000000, 2, gotoRoom);
			}
			
			super.update();
			
		}
		
		protected function gotoRoom():void
		{
			FlxG.switchState(new PlayState());
		}
		
	}

}