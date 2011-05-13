package
{
	import flash.display.Sprite;
	import flash.media.Sound; 
	import flash.net.URLRequest; 
	import flash.net.URLLoader; 
	import flash.events.Event;
	import flash.errors.IOError;

	public class Eighth extends Sprite
	{
		private var flowerSound:Sound;
		private var flowerSoundChannel; 
		public function Eighth()
		{
			super();
		}
		
		public function eight() {
			flowerSound:Sound; 
			var requestflowerSound:URLRequest = new URLRequest("Sounds/GamePieces/flower-blackheart.mp3"); 
			flowerSound.load(requestflowerSound); 
			flowerSound.addEventListener(Event.COMPLETE, flowerOneSound); 
		//	flowerSound.addEventListener(IOERROR.IO_ERROR, onIOError); 
			flowerSoundChannel = flowerSound.play(); 
			//use on the 1/8th 
			
		}
		private function flowerOneSound() { 
			trace("Flower one sound loaded"); 
		}
		private function onIOError(){
			
		}
	}
}