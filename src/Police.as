package
{
	import org.flixel.*;
	
	public class Police extends FlxSprite
	{
		[Embed(source = "data/police.png")] private var ImgPolice:Class;
		
		public function Police(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(ImgPolice,true);
			
			width = 8;
			height = 10;
			offset.x = 3;
			offset.y = 3;
			
			addAnimation("walk",[1,0],10,true);
		}
		
		override public function update():void
		{
			play("walk");
		}

	}
}