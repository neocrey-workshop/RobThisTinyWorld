package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame
	{
		public function Main()
		{
			super(320,240,MenuState,2,40,40);
			forceDebugger = true;
		}
	}
}