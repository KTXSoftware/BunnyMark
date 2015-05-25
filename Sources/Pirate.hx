package;
import kha.Image;

class Pirate {
	public var image: Image;
	public var x: Float;
	public var y: Float;
	public var scaleX: Float;
	public var scaleY: Float;
	
	public function new(image: Image) {
		this.image = image;
	}
	
	public var width(get, null): Float;
	
	private function get_width(): Float {
		return image.width * scaleX;
	}
	
	public var height(get, null): Float;
	
	private function get_height(): Float {
		return image.height * scaleY;
	}
}
