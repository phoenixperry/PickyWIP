package 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.events.TransformGestureEvent;
	import flash.events.GestureEvent;
	
	public class MultiTouch extends Sprite
	{
		
		private var spr:Sprite = new Sprite();
		
		public function MultiTouch():void
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			
			var supportedGesturesVar:Vector.<String> = Multitouch.supportedGestures;
			var deviceSupports:TextField = new TextField();
			deviceSupports.text = "Supported Gestures:\n";
			
			addChild(deviceSupports);
			
			if(Multitouch.supportsGestureEvents) 
			{
				
				for (var i:int=0; i<supportedGesturesVar.length; ++i) 
				{
					deviceSupports.appendText(supportedGesturesVar[i] + "\n");
				}
				
				addChildAt(spr, 0);
				spr.x = stage.stageWidth/2;
				spr.y = stage.stageHeight/2;
				
				fillSprite();
				
				spr.addEventListener(TransformGestureEvent.GESTURE_PAN, onGesturePan);
				spr.addEventListener(TransformGestureEvent.GESTURE_ZOOM, onGestureZoom);
				spr.addEventListener(TransformGestureEvent.GESTURE_ROTATE, onGestureRotate);
				spr.addEventListener(TransformGestureEvent.GESTURE_SWIPE, onGestureSwipe);
			}
			else
			{
				deviceSupports.appendText("None");
			}
		}
		
		private function onGesturePan(e:TransformGestureEvent):void
		{
			e.target.x += e.offsetX;
			e.target.y += e.offsetY;
		}
		
		private function onGestureZoom(e:TransformGestureEvent):void
		{
			e.target.scaleX = e.target.scaleY *= e.scaleX;
		}
		
		private function onGestureRotate(e:TransformGestureEvent):void
		{
			e.target.rotation += e.rotation;
		}
		
		private function onGestureSwipe(e:GestureEvent):void
		{
			fillSprite();
		}
		
		private function fillSprite():void
		{
			spr.graphics.clear();
			spr.graphics.beginFill(Math.random()*0xFFFFFF);
			spr.graphics.drawRect(-stage.stageWidth/2,-stage.stageHeight/2, stage.stageWidth, stage.stageHeight);
			spr.graphics.endFill();
		}
	}
}