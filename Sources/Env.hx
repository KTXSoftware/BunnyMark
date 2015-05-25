package ;

/**
 * Stage size, taking into account retina scale
 * @author Philippe / http://philippe.elsass.me
 */

class Env 
{
	static public var width:Int;
	static public var height:Int;

	static public function setup() 
	{
		width = kha.Sys.pixelWidth;
		height = kha.Sys.pixelHeight;
	}
}
