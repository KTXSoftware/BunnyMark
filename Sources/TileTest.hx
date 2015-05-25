package ;
import kha.graphics2.Graphics;
import kha.Image;
import kha.Loader;
import kha.Scheduler;

/**
 * @author Joshua Granick
 * @author Philippe Elsass
 */
class TileTest
{
	//var tf:TextField;	
	var numBunnies:Int;
	var incBunnies:Int;
	var smooth:Bool;
	var gravity:Float;
	var bunnies:Array <Bunny>;
	var maxX:Int;
	var minX:Int;
	var maxY:Int;
	var minY:Int;
	var bunnyAsset:Image;
	var pirate:Pirate;
	
	public function new() 
	{
		gravity = 0.5;
		incBunnies = 100;
		smooth = true;
		numBunnies = 500;

		bunnyAsset = Loader.the.getImage("wabbit_alpha");
		pirate = new Pirate(Loader.the.getImage("pirate"));
		pirate.scaleX = pirate.scaleY = Env.height / 768;
		
		bunnies = new Array<Bunny>();
		
		var bunny; 
		for (i in 0...numBunnies) 
		{
			bunny = new Bunny();
			bunny.x = 0;
			bunny.y = 0;
			bunny.speedX = Math.random() * 5;
			bunny.speedY = (Math.random() * 5) - 2.5;
			bunny.scale = 0.3 + Math.random();
			bunny.rotation = 15 - Math.random() * 30;
			bunnies.push(bunny);
		}
		
		createCounter();
		stage_resize();
	}

	function createCounter()
	{
		/*var format = new TextFormat("_sans", 20, 0, true);
		format.align = TextFormatAlign.RIGHT;

		tf = new TextField();
		tf.selectable = false;
		tf.defaultTextFormat = format;
		tf.width = 200;
		tf.height = 60;
		tf.x = maxX - tf.width - 10;
		tf.y = 10;
		addChild(tf);

		tf.addEventListener(MouseEvent.CLICK, counter_click);*/
	}

	function counter_click(e)
	{
		if (numBunnies >= 1500) incBunnies = 250;
		var more = numBunnies + incBunnies;

		var bunny; 
		for (i in numBunnies...more)
		{
			bunny = new Bunny();
			bunny.x = 0;
			bunny.y = 0;
			bunny.speedX = Math.random() * 5;
			bunny.speedY = (Math.random() * 5) - 2.5;
			bunny.scale = 0.3 + Math.random();
			bunny.rotation = 15 - Math.random() * 30;
			bunnies.push (bunny);
		}
		numBunnies = more;

		stage_resize();
	}
	
	function stage_resize() 
	{
		maxX = Env.width;
		maxY = Env.height;
		//tf.text = "Bunnies:\n" + numBunnies;
		//tf.x = maxX - tf.width - 10;
	}
	
	public function render(g: Graphics): Void {
		var transform = g.transformation;
		var TILE_FIELDS = 6; // x+y+index+scale+rotation+alpha
		var bunny;
	 	for (i in 0...numBunnies)
		{
			bunny = bunnies[i];
			bunny.x += bunny.speedX;
			bunny.y += bunny.speedY;
			bunny.speedY += gravity;
			bunny.alpha = 0.3 + 0.7 * bunny.y / maxY;
			
			if (bunny.x > maxX)
			{
				bunny.speedX *= -1;
				bunny.x = maxX;
			}
			else if (bunny.x < minX)
			{
				bunny.speedX *= -1;
				bunny.x = minX;
			}
			if (bunny.y > maxY)
			{
				bunny.speedY *= -0.8;
				bunny.y = maxY;
				if (Math.random() > 0.5) bunny.speedY -= 3 + Math.random() * 4;
			} 
			else if (bunny.y < minY)
			{
				bunny.speedY = 0;
				bunny.y = minY;
			}
			
			var w = bunny.scale * bunnyAsset.width;
			var h = bunny.scale * bunnyAsset.height;
			g.rotate(bunny.rotation, bunny.x + w / 2, bunny.y + h / 2);
			g.opacity = bunny.alpha;
			g.drawScaledImage(bunnyAsset, bunny.x, bunny.y, w, h);
			g.transformation = transform;
		}
		
		g.rotate(0, 0, 0);
		g.opacity = 1;
		var t = Scheduler.time();
		pirate.x = Std.int((Env.width - pirate.width) * (0.5 + 0.5 * Math.sin(t / 3)));
		pirate.y = Std.int(Env.height - pirate.height + 70 - 30 * Math.sin(t * 10));
		g.drawScaledImage(pirate.image, pirate.x, pirate.y, pirate.width, pirate.height);
	}
}