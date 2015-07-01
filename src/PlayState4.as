package
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import org.flixel.plugin.photonstorm.*;

	public class PlayState4 extends FlxState
	{
		[Embed(source="data/map.png")] private var ImgMap:Class;
		[Embed(source="data/tiles.png")] private var ImgTiles:Class;
		[Embed(source="data/coin.png")] private var ImgCoin:Class;
		
		[Embed(source = "data/city1.png")] private var ImgCity1:Class;
		[Embed(source = "data/city2.png")] private var ImgCity2:Class;
		[Embed(source = "data/city3.png")] private var ImgCity3:Class;
		[Embed(source = "data/city4.png")] private var ImgCity4:Class;
		[Embed(source = "data/grass.png")] private var ImgGrass:Class;
		[Embed(source = "data/stones.png")] private var Stones:Class;
		[Embed(source = "data/tree.png")] private var ImgTree:Class;
		
		[Embed(source = "data/coin.mp3")] private var _coin:Class;
		[Embed(source = "data/win.mp3")] private var winsound:Class;
		[Embed(source = "data/bang.mp3")] private var Bang:Class;
		
		protected var _level:FlxTilemap;
		private var _player:Player;
		private var _enemy:Police;
		private var _enemy2:Police;
		private var _enemy3:Police;
		private var exit:FlxSprite;
		private var City2:FlxSprite;
		private var City3:FlxSprite;
		private var City4:FlxSprite;
		private var grass:FlxSprite;
		private var grass2:FlxSprite;
		private var grass3:FlxSprite;
		private var stones:FlxSprite;
		private var tree:FlxSprite;
		private var tree2:FlxSprite;
		private var tree3:FlxSprite;
		private var speed:Number;
		public var coins:FlxGroup;
		private var _scoreText:FlxText;
		
		override public function create():void
		{			
			FlxG.bgColor = 0xff000000;
			
			FlxG.score = 105;
			_scoreText = new FlxText(100, 20, 130, "105");
			_scoreText.setFormat(null, 60, 0x303030, "center");
			add(_scoreText);
			
			grass = new FlxSprite(200, 34, ImgGrass);			
			add(grass);
			grass2 = new FlxSprite(100, 177, ImgGrass);			
			add(grass2);
			grass3 = new FlxSprite(15, 97, ImgGrass);			
			add(grass3);
			tree = new FlxSprite(256, 80, ImgTree);			
			add(tree);
			tree2 = new FlxSprite(45, 176, ImgTree);			
			add(tree2);
			tree3 = new FlxSprite(180, 160, ImgTree);			
			add(tree3);
			stones = new FlxSprite(160, 80, Stones);			
			add(stones);
			
			exit = new FlxSprite(43, 128, ImgCity1);
			exit.exists = false;
			add(exit);
			
			City2 = new FlxSprite(35, 25, ImgCity2);			
			add(City2);
			
			City3 = new FlxSprite(256, 168, ImgCity3);			
			add(City3);
			
			City4 = new FlxSprite(265, 5, ImgCity4);			
			add(City4);
			
			var path:FlxPath;
			var sprite:FlxSprite;
			var destination:FlxPoint;
			
			_player = new Player(35,120);
			add(_player);
			
			_level = new FlxTilemap();
			_level.loadMap(FlxTilemap.imageToCSV(ImgMap,false,2),ImgTiles,0,0,FlxTilemap.ALT);
			_level.follow();
			add(_level);
			
			_enemy = new Police(FlxG.width - 30, FlxG.height - 30);			
			add(_enemy);
			
			_enemy2 = new Police(FlxG.width / 2, FlxG.height / 2);			
			add(_enemy2);
			
			_enemy3 = new Police(FlxG.width / 7, FlxG.height / 7);			
			add(_enemy3);
			
			coins = new FlxGroup();
			createCoin(5, 4);
			createCoin(5, 5);
			createCoin(5, 6);
			createCoin(5, 7);
			createCoin(5, 8);
			createCoin(6, 4);
			createCoin(6, 5);
			createCoin(6, 6);
			createCoin(6, 7);
			createCoin(6, 8);
			
			createCoin(35, 3);
			createCoin(35, 4);
			createCoin(35, 5);
			createCoin(35, 6);
			createCoin(35, 7);
			createCoin(36, 3);
			createCoin(36, 4);
			createCoin(36, 5);
			createCoin(36, 6);
			createCoin(36, 7);
			
			createCoin(34, 22);
			createCoin(34, 23);
			createCoin(34, 24);
			createCoin(34, 25);
			createCoin(34, 26);
			createCoin(35, 22);
			createCoin(35, 23);
			createCoin(35, 24);
			createCoin(35, 25);
			createCoin(35, 26);
			
			createCoin(10, 20);
			createCoin(29, 20);
			createCoin(20, 7);
			createCoin(10, 3);
			createCoin(29, 3);
			
			createCoin(2, 26);
			createCoin(37, 10);
			createCoin(37, 17);
			createCoin(10, 14);
			createCoin(29, 14);

			add(coins);
			
			FlxG.mouse.show();
		}
		
		override public function destroy():void
		{
			super.destroy();
			_level = null;
			_player = null;
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(_player, _level);
			
			FlxVelocity.moveTowardsObject(_enemy, _player, 40);
			FlxVelocity.moveTowardsObject(_enemy2, _player, 40);
			FlxVelocity.moveTowardsObject(_enemy3, _player, 40);
			FlxG.overlap(_enemy, _player, overlapEP);
			FlxG.overlap(_enemy2, _player, overlapEP);
			FlxG.overlap(_enemy3, _player, overlapEP);
			
			FlxG.overlap(coins, _player, getCoin);
			FlxG.overlap(exit,_player,win);
			
			if (FlxG.keys.justPressed("R"))
			{
				FlxG.fade(0xff000000, 1, gotoReload);
			}
			
		}
		
		public function createCoin(X:uint,Y:uint):void
		{
			var coin:FlxSprite = new FlxSprite(X*8+3,Y*8+2,ImgCoin);
			coins.add(coin);
		}
		
		public function getCoin(Coin:FlxSprite,Player:FlxSprite):void
		{
			Coin.kill();
			FlxG.play(_coin, 1, false);
			FlxG.score += 1;
			_scoreText.text = FlxG.score.toString();
			if(coins.countLiving() == 0)
			{
				FlxG.play(winsound, 1, false);
				exit.exists = true;
			}
		}
		
		private function createEmitter():FlxEmitter
		{
			var emitter:FlxEmitter = new FlxEmitter();
			emitter.lifespan = 1;
			emitter.gravity = 0;
			emitter.maxRotation = 0;
			emitter.setXSpeed( -300, 300);
			emitter.setYSpeed( -300, 300);
			var particles:int = 30;
			for (var i:int = 0; i < particles; i++)
			{
				var particle:FlxParticle = new FlxParticle();
				particle.makeGraphic(2, 2, 0xFFF67F00);
				particle.exists = false;
				emitter.add(particle);
			}
			emitter.start();
			add(emitter);
			return emitter;
		}
		
		private function overlapEP(enemy:FlxSprite, player:FlxSprite):void
		{
			var emitter:FlxEmitter = createEmitter();
			emitter.at(player);
			FlxG.play(Bang, 1, false);
			player.kill();
			enemy.kill();
			FlxG.shake(0.035, 0.5);
			var text:FlxText;
			text = new FlxText(90, 90, 150, "Game Over! Press R to restart");
			text.color = 0xffffff;
			text.alignment = "center";
			text.size = 16;
			add(text);
		}
		
		protected function gotoReload():void
		{
			FlxG.switchState(new PlayState4());
		}
		
		public function win(Exit:FlxSprite,player:FlxSprite):void
		{
			FlxG.play(winsound, 1, false);
			FlxG.fade(0xff000000, 1, gotoRoom);
			player.kill();
		}
		
		protected function gotoRoom():void
		{
			FlxG.switchState(new PlayState5());
		}
	}
}
