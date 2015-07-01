package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = "data/player.png")] private var ImgPlayer:Class;
		[Embed(source = "data/jump.mp3")] private var Jump:Class;
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(ImgPlayer,true);
			maxVelocity.x = 100;
			acceleration.y = 400;
			drag.x = maxVelocity.x*4;
			
			width = 8;
			height = 10;
			offset.x = 3;
			offset.y = 3;
			
			addAnimation("idle",[0],0,false);
			addAnimation("walk",[1,0],10,true);
			addAnimation("walk_back",[1,0],10,true);
			addAnimation("flail",[1,0],18,true);
			addAnimation("jump",[1],0,false);
		}
		
		override public function update():void
		{
			acceleration.x = 0;
			if(FlxG.keys.A)
				acceleration.x -= drag.x;
			if(FlxG.keys.D)
				acceleration.x += drag.x;
			
			if(isTouching(FLOOR))
			{
				if(FlxG.keys.justPressed("W"))
				{
					velocity.y = -acceleration.y*0.51;
					play("jump");
					FlxG.play(Jump, 1, false);
				}
				else if(velocity.x > 0)
					play("walk");
				else if(velocity.x < 0)
					play("walk_back");
				else
					play("idle");
			}
			else if(velocity.y < 0)
				play("jump");
			else
				play("flail");
		}
		
		public function getBulletSpawnPosition():FlxPoint
		{
			var p:FlxPoint = new FlxPoint(x + 8, y + 2);
			return p;
		}
	}
}