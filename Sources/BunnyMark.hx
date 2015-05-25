package;

import kha.Configuration;
import kha.Framebuffer;
import kha.Game;
import kha.Loader;

/**
 * @author Joshua Granick
 * @author Philippe Elsass
 * @author Robert Konrad
 */
class BunnyMark extends Game 
{
	private var loaded = false;
	//private var bg:Background;
	private var tiletest:TileTest;
	//private var fps:FPS;

	public function new()
	{
		super ("BunnyMark");
	}
	
	override public function init(): Void {
		Loader.the.loadRoom("all", start);
	}

	function start() 
	{
		Env.setup();

		/*bg = new Background();
		bg.texture = Assets.getBitmapData("assets/grass.png");
		bg.cols = 8;
		bg.rows = 12;
		bg.x = -50;
		bg.y = -50;
		bg.setSize(Env.width + 100, Env.height + 100);
		resize();*/

		tiletest = new TileTest();

		//fps = new FPS();
		
		loaded = true;
	}

	/*function resize() 
	{
		if (bg == null) return;

		if (Env.width > Env.height)
		{
			bg.cols = 12;
			bg.rows = 8;
		}
		else
		{
			bg.cols = 8;
			bg.rows = 12;
		}
		bg.setSize(Env.width + 100, Env.height + 100);
	}*/
	
	override public function render(frame: Framebuffer): Void {
		if (loaded) {
			var g = frame.g2;
			g.clear();
			//bg.render(g);
			tiletest.render(g);
			//fps.render(g);
		}
	}
}
