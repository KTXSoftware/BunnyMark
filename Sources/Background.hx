package ;

import kha.graphics2.Graphics;
import kha.Image;

/**
 * ...
 * @author Philippe / http://philippe.elsass.me
 */

class Background
{
	public var cols:Int;
	public var rows:Int;
	public var texture:Image;
	private var vertices:Vector<Float>;
	private var indices:Vector<Int>;
	private var uvt:Vector<Float>;
	private var _width:Int;
	private var _height:Int;

	public function new() 
	{
		super();
		cols = 1;
		rows = 1;
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		addEventListener(Event.ENTER_FRAME, enterFrame);
		paint();
	}

	function enterFrame(e) 
	{
		if (_width == 0 || _height == 0) return;

		var t:Float = Lib.getTimer() / 1000.0;
		var sw:Float = _width;
		var sh:Float = _height;
		var kx:Float, ky:Float;
		var ci:Int, ri:Int;

		for (j in 0...rows + 1)
		{
			ri = j * (cols + 1) * 2;
			for (i in 0...cols + 1)
			{
				ci = ri + i * 2;
				kx = i / cols + Math.cos(t + i) * 0.02;
				ky = j / rows + Math.sin(t + j + i) * 0.02;
				vertices[ci] = sw * kx; 
				vertices[ci + 1] = sh * ky; 
			}
		}
		paint();
	}

	public function setSize(w:Int, h:Int) 
	{
		_width = w;
		_height = h;
		build();
		if (parent != null) paint();
	}
	
	private function build():Void 
	{
		var sw:Float = _width;
		var sh:Float = _height;
		var uw:Float = sw / texture.width;
		var uh:Float = sh / texture.height;
		var kx:Float, ky:Float;
		var ci:Int, ci2:Int, ri:Int;
		
		vertices = new Vector<Float>();
		uvt = new Vector<Float>();
		indices = new Vector<Int>();
		for (j in 0...rows + 1)
		{
			ri = j * (cols + 1) * 2;
			ky = j / rows;
			for (i in 0...cols + 1)
			{
				ci = ri + i * 2;
				kx = i / cols;
				vertices[ci] = sw * kx; 
				vertices[ci + 1] = sh * ky; 
				uvt[ci] = uw * kx; 
				uvt[ci + 1] = uh * ky;
			}
		}
		for (j in 0...rows)
		{
			ri = j * (cols + 1);
			for (i in 0...cols)
			{
				ci = i + ri;
				ci2 = ci + cols + 1;
				indices.push(ci);
				indices.push(ci + 1);
				indices.push(ci2);
				indices.push(ci + 1);
				indices.push(ci2 + 1);
				indices.push(ci2);
			}
		}
	}
	
	private function paint():Void 
	{
		graphics.beginBitmapFill(texture);
		graphics.drawTriangles(vertices, indices, uvt);
		//graphics.drawRect(0, 0, stage.stageWidth * 1.2, stage.stageHeight * 1.2); // flat
		graphics.endFill();
	}
	
	public function render(g: Graphics): Void {
		g.clear();
	}
}