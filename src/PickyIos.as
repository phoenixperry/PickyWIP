////IOS

package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.GestureEvent;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.events.TransformGestureEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import org.osflash.signals.Signal;
	
	
	public class PickyIos extends MovieClip {
		//sounds 
		private var monsterTwo:HeartEater; 
		private var bgSoundChannel:SoundChannel; 
		private var bgSound:Sound; 
		private var beeSound:Sound; 
		private var flowerSound:Sound; 
		private var flowerTwoSound:Sound; 
		private var flowerThreeSound:Sound; 	
		private var flowerSoundChannel:SoundChannel; 
		
		public var road:Road; 
		public var bee:Bee; 
		public var roadContainer:MovieClip; 
		public var road2:Road; 
		public var roadBreadth:Number; 
		public var move:Number; 
		public var flower:Flower; 
		public var monster:HeartEater; 
		public var mover:Number; 
		public var beeFlying:BeeFlying;
		public var controlBox:ControlBox; 
		//this is how I'm trying to track how many fingers are down - this doesn't work and I have no idea why. reasearch online yeilds no results - ye
		public var touchID:int =0; 
		
		//here comes the sprite sheet for gpu 
		public var bitmapSheetTwo:BeeSheetTwo; 
		//size of the grid in the sheet 
		public var gridW:int = 4; 
		public var gridH:int = 1; 
		//Each Frame's Dimentions 
		var frameW:int = 50; 
		var frameH:int = 53; 
		//bee and bee animations 
		public var bitmaps:Vector.<BitmapData>;  
		public var bees:Vector.<Bitmap>; 
		//flowers creation
		public var flowerBit:BitmapData; 
		public var flowerArray:Array; 
		var flowerPopulation:Number = 20; 
		
		//touch offset so your finger isn't ontop of the bee
		public var touch:Number = 40; 
		
		//cheap meter 
		public var meterDots:Array; 
		
		//sounds more
		
		public var eighth:Eighth; 
		//bits
		public var blackBg:BlackBg = new BlackBg(); 
		public var whiteBg:WhiteBg; 
		public var gradBg:GradBg; 
		public var purpleBg:PurpleBg; 
		public var purpleBg2:PurpleBg;
		public var blackRoad:MovieClip; 
		public var whiteRoad:MovieClip; 
		public var whiteContainer:MovieClip; 
		public var gradRoad:MovieClip; 
		public var purpleRoad:MovieClip; 
		public var purpleBgBreadth:Number; 
		public var purpleContainer:MovieClip; 
		public var mover2:Number; 
		public var life:Array; 
		public function PickyIos(){
			//constructor 
			trace("I ran");
			
			//life array 
			life = new Array(); 
			
			monsterTwo = new HeartEater(); 
			//parallax other bgs 

			var gradBg = new GradBg(); 
			var gd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true);
			gd.draw(gradBg);
			var gradRoad:Bitmap = new Bitmap(gd);
			//	addChild(gradRoad);
			
			
			
			var bd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x000000);
			bd.draw(blackBg);
			var blackRoad:Bitmap = new Bitmap(bd);
			//	addChild(blackRoad);	
			//sounds 
			audio(); 
			eighth = new Eighth(); 
			
			bee = new Bee(); 
			road = new Road();
			road2 = new Road();
			purpleBg = new PurpleBg(); 
			purpleBg2 = new PurpleBg(); 
			
			flower = new Flower();
			monster = new HeartEater(); 
			mover = 30; 
			mover2 = 5; 
			//flowers array creation 
			flowerArray = new Array(); 
			
			//bee redo instantiate as Sprite  
			var frameW:int = 50; 
			var frameH:int = 53; 
			var bees:Vector.<Bitmap>; 
			
			purpleBg.x = 0.0; 
			purpleBg.y = 0.0; 
			purpleBgBreadth = 5927; 
			road.x = 0.0; 
			road.y = 0; 
			roadBreadth = 5927; 
			road2.x = road.x + roadBreadth; 
			road2.y = road.y; 
			monster.x 600; 
			monster.y = 200; 
			monsterTwo.x = 1800; 
			monsterTwo.y = 200; 
			
			
			//	addChild(beeFlying);
			roadContainer = new MovieClip(); 
			roadContainer.addChild(monsterTwo); 
			roadContainer.addChild(road);
			roadContainer.addChild(road2); 
			roadContainer.addChild(flower); 
		//	roadContainer.addChild(monster);
			
			purpleContainer = new MovieClip(); 
			purpleContainer.addChild(purpleBg); 
			purpleContainer.addChild(purpleBg2);
	 
			stage.addChild(purpleContainer); 
			stage.addChild(roadContainer); 
			
			//parallax listeners
			addEventListener(Event.ENTER_FRAME, onEnterFrame );
			addEventListener(Event.ENTER_FRAME, onEnterPurpleFrame );
//		
			//trace(roadContainer.x, "/", road2.x); 
			//	stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			//keyDownHandler); //
			//	addEventListener(Event.ENTER_FRAME, update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedBit);
			
			
			//ios funtionality
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT; 
			this.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin); 
			this.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove); 
			this.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd); 
			//			beeFlying.addEventListener(GestureEvent.GESTURE_TWO_FINGER_TAP, tapHandler); 
			
			
			//signal listening 
		//	beeFlying.punched.addOnce(beePunched); 
			//beeFlying.punchedAgain.add(beePunchedAgain); 
			//beeFlying.puchedNum.add(beePunchedNumbers); 
			//beeFlying.punched.remove(beePunched); 
			//beeFlying.punched.removeAll - removeds all listeners attached to punched
			
			//load up the sprite sheet 
			bitmapSheetTwo = new BeeSheetTwo(200, 53, true, 0); 
			beeSpritesLoad();
			bitmapSheetTwo.punched.addOnce(beePunched);
			flowerBit = new FlowerBit(39, 61, true, 0); 
			
			//signal listeing 
			
			loadFlowers(); 
			
			var frameWM:Number = 342;  
			var frameHM:Number = 149; 
			//monster frame numbers 
			//var maxFrameMonsters:Number = 0; 
			
			//cheap meter 
			var meterDots:Array = new Array(); 
			
		}
		//end constructor 
		
		//start game functionality here 
		
		//parallax animation
		public function onEnterFrame( evt:Event ):void
		{
			purpleContainer.x = -20 - mover2; 
			roadContainer.x = -20 - mover;
			
			mover = mover +10;
			
			
			if ( road.x + roadBreadth + roadContainer.x < 0 )
			{
				road.x = road.x + (2 * roadBreadth);
			}
			if ( road2.x + roadBreadth + roadContainer.x < 0 )
			{
				road2.x = road2.x + (2 * roadBreadth);
			}
			

		
		}
		
		public function onEnterPurpleFrame(evt:Event):void 
		{
			mover2 = mover2 +2; 
			if ( purpleBg.x + purpleBgBreadth + purpleContainer.x < 0 )
			{
				purpleBg.x = purpleBg.x + (2 * roadBreadth);
			}
			if ( purpleBg2.x + roadBreadth + purpleContainer.x < 0 )
			{
				purpleBg2.x = purpleBg2.x + (2 * roadBreadth);
			}
		}
		
		
		//signals events
		public function beePunched(action:String):void { 
			trace(action); 
			
				life.pop();
		
		}
		
		public function beePunchedAgain(action:String):void { 
			trace(action); 
		}
		
		public function beePunchedNumbers(action:Number):void { 
			trace(action); 
		}
		
		//gpu sprite sheet integration and flower generation 
		public function randomNumber(low:Number=NaN, high:Number=NaN):Number
		{
			var low:Number = low;
			var high:Number = high;
			
			if(isNaN(low))
			{
				throw new Error("low must be defined");
			}
			if(isNaN(high))
			{
				throw new Error("high must be defined");
			}
			
			return Math.round(Math.random() * (high - low)) + low;
		}
		public function loadFlowers():void { 
			
			for(var i:int = 0; i <flowerPopulation; i++){ 
				var flowerBitmap = new Bitmap(flowerBit); 
				
				flowerArray.push(flowerBitmap); 
			}
			for(var j:int = 0; j <flowerArray.length; j++){ 
				addChild(flowerArray[j]); 
				flowerArray[j].x = randomNumber(100, 900); 
				flowerArray[j].y = randomNumber(150, 660); 
			}
			
			
			
		}
		//monster bitmap load 
		
		
		public function beeSpritesLoad():void { 
			//store each frame's bitmap data here
			bitmaps = new<BitmapData>[]; 
			//chop the bitmap sheet into individual frames
			for(var i:int =0; i <gridH; i++) { 
				for(var j:int = 0; j < gridW; j++) {
					//createa a bitmapData object for this frame 
					var bd:BitmapData = new BitmapData(frameW, frameH, true); 
					
					//the rect area to be copied from the bitmap sheet 
					var srcRect: Rectangle = new Rectangle ((j*frameW), (i*frameH), frameW, frameH); 
					
					//copy the frame's pixels from the bitmap Sheet. 
					bd.copyPixels(bitmapSheetTwo, srcRect, new Point(0,0)); 
					
					//store the bitmap data into the array for later use 
					bitmaps.push(bd);
					
				}
			}
			
			//manually remove bitmap data that is no longer required 
			//bitmapSheetTwo.dispose(); 
			//bitmapSheetTwo = null; 
			
			
			bees = new <Bitmap>[]; 
			//startX + Y position
			var startX:int = 20; 
			var startY:int = 300; 
			//if you wanna grid you can use these 
			var numBeesX:int = 1; 
			var numBeesY:int = 1; 
			
			for(var y_:int=0; y_< numBeesY; y_++) {
				for(var x_:int =0; x_<numBeesX; x_++){
					var bee:Bitmap = new Bitmap(bitmaps[0]); 
					bee.x = startX +(bee.width *x_); 
					bee.y = startY + (bee.height *y_); 
					bees.push(bee); 
					addChild(bee); 
					
				}
			}
			
			var frame:int =0; 
			//this frame number will let you place your grid in the right area of the sheet 
			var maxFrames:int = bitmaps.length-1;
			addEventListener(Event.ENTER_FRAME, update); 
			
			function update(e:Event):void 
				
			{
				
				//loops the anumimation back to the first frame or start frame i set 
				if(++frame == maxFrames) 
				{
					frame=1; 
				}
				//update each bee's bitmap data reference in space on the sheet - this puts it on each frame
				
				for(var i:int=0; i<bees.length; i++)
				{
					bees[i].bitmapData = bitmaps[frame]; 
					
					
				}
				
			}
			
			
		}
		//bitmap moving to key presses - 
		public function keyPressedBit(evt:KeyboardEvent):void {
			
			
			var frame:int =0; 
			var maxFrames:int = bitmaps.length-1;
			if(++frame == maxFrames) 
			{
				frame=1; 
			}
			var frameNum:Number = 0; 
			
			for(var i:int=0; i<bees.length; i++)
			{
				bees[i].bitmapData = bitmaps[frame]; 
				for(var j:int=0; j<flowerArray.length; j++) { 
					if (bees[i].hitTestObject(flowerArray[j])) 
					{
						//beeFlying.eat(); 
						trace("new bee eats"); 
						bitmapSheetTwo.eat(); 
						
						removeChild(flowerArray[j]); 
						downAndDirtyLifeMeter(); 							
						//bees[i].bitmapData = bitmaps[frameNum];
						
						//play sound 
						
					}
						
				if(bees[i].hitTestObject(monsterTwo))
				{
					trace("new bee takes damage"); 
					bitmapSheetTwo.punch();
					monster.eat(); 
					trace("monster just ate a bit of bee life" , monster.eat);
					bitmapSheetTwo.takeDamage();
					trace(bitmapSheetTwo.damage, "bee takes zeedamage", monster.food, "monster eats"); 
					//life.pop();
					
				}	
				}	
				
				
				//here come the keyboard test  
				
				
				switch(evt.keyCode) {
					
					case 39:					
						bees[i].x = bees[i].x + 20;
						break; 	
					
					case 40: 				
						bees[i].y = bees[i].y + 20; 
						break; 	
					
					case 38: 
						bees[i].y = bees[i].y -15; 
						break; 
					case 37: 
						bees[i].x = bees[i].x -15; 
						break; 	
				}
				//limite bee to stage 
				if(bees[i].x > stage.stageWidth-bees[i].width) { 
					bees[i].x = stage.stageWidth -bees[i].width; 
				}
				if(bees[i].x < 0 +bees[i].width) { 
					bees[i].x = 0 +bees[i].width; 
				}
				if(bees[i].y < 0 + bees[i].height) { 
					bees[i].y = 0 + bees[i].height; 
				}
				if(bees[i].y > 630) { 
					bees[i].y = 630; 
				}
			}
		}	
		
		
		//ios functionality 
		function onTouchBegin (e:TouchEvent):void{
			trace(e.sizeX + "Size of the touch surface"); 
			trace(e.pressure +"How much pressure is being pressed"); 
			trace(e.isPrimaryTouchPoint +"Is originail finger you touched with"); 
			
			var frame:int =0; 
			var maxFrames:int = bitmaps.length-1;
			if(++frame == maxFrames) 
			{
				frame=1; 
			}
			var frameNum:Number = 0; 
			
			for(var i:int=0; i<bees.length; i++)
			{
				bees[i].bitmapData = bitmaps[frame]; 
				bees[i].x = e.stageX-touch; 
				bees[i].y = e.stageY-touch*2; 
				for(var j:int=0; j<flowerArray.length; j++) { 
					if (bees[i].hitTestObject(flowerArray[j])) 
					{
						//beeFlying.eat(); 
						trace("new bee eats"); 
						bitmapSheetTwo.eat(); 
						removeChild(flowerArray[j]); 
						
						//bees[i].bitmapData = bitmaps[frameNum];
					}
				}	
				if(bees[i].hitTestObject(monster))
				{
					trace("new bee takes damage"); 
					//	bitmapSheetTwo.punch();
					monster.eat(); 
					//life.pop();
					
					bitmapSheetTwo.takeDamage();
					trace(bitmapSheetTwo.damage, "bee takes zeedamage", monster.food, "monster eats"); 
					
				}	
				touchID = e.touchPointID; 
				//	trace(e.touchPointID); 
				//this assigns the new touch an ID
				
			}
			
		}
		
		function onTouchMove (e:TouchEvent):void{
			var frame:int =0; 
			var maxFrames:int = bitmaps.length-1;
			if(++frame == maxFrames) 
			{
				frame=1; 
			}
			var frameNum:Number = 0; 
			
			for(var i:int=0; i<bees.length; i++)
			{
				bees[i].bitmapData = bitmaps[frame]; 
				bees[i].x = e.stageX-touch; 
				bees[i].y = e.stageY-touch*2; 
				for(var j:int=0; j<flowerArray.length; j++) { 
					if (bees[i].hitTestObject(flowerArray[j])) 
					{
						//beeFlying.eat(); 
						trace("new bee eats"); 
						bitmapSheetTwo.eat(); 
						removeChild(flowerArray[j]); 
						
						//bees[i].bitmapData = bitmaps[frameNum];
						
						//sounds 
						bgSoundChannel = bgSound.play();  
						
					}
				}	
				if(bees[i].hitTestObject(monster))
				{
					trace("new bee takes damage"); 
					//	bitmapSheetTwo.punch();
					monster.eat(); 
					//.pop();
					
					bitmapSheetTwo.takeDamage();
					trace(bitmapSheetTwo.damage, "bee takes zeedamage", monster.food, "monster eats"); 		
				}	
			}
			touchID = e.touchPointID; 
			//this still will not work. why? 
			if (touchID == (e.touchPointID)) {
				//	myTextField = "still using one finger";  
				beeFlying.gotoAndStop("One");
			}else if(touchID == (e.touchPointID-1)) { 
				//you are holding down another finger 
				beeFlying.gotoAndStop("Two"); 
			}else if(touchID == (e.touchPointID-2)) { 
				//you are holding down a third finger 
				beeFlying.gotoAndStop(4);
			}
			//if you want the bee to change appearance when touched you can add this here
			
		}
		function onTouchEnd (e:TouchEvent):void{
			var frame:int =0; 
			var maxFrames:int = bitmaps.length-1;
			if(++frame == maxFrames) 
			{
				frame=1; 
			}
			var frameNum:Number = 0; 
			
			for(var i:int=0; i<bees.length; i++)
			{
				bees[i].bitmapData = bitmaps[frame]; 
				bees[i].x = e.stageX-touch; 
				bees[i].y = e.stageY-touch*2; 
				for(var j:int=0; j<flowerArray.length; j++) { 
					if (bees[i].hitTestObject(flowerArray[j])) 
					{
						//beeFlying.eat(); 
						trace("new bee eats"); 
						bitmapSheetTwo.eat(); 
						removeChild(flowerArray[j]); 
						
						//bees[i].bitmapData = bitmaps[frameNum];
					}
				}	
				if(bees[i].hitTestObject(monster))
				{
					trace("new bee takes damage"); 
					//	bitmapSheetTwo.punch();
					monster.eat(); 
					//life.pop();
					
					bitmapSheetTwo.takeDamage();
					trace(bitmapSheetTwo.damage, "bee takes zeedamage", monster.food, "monster eats"); 		
				}	
			}
			//if you want the bee to change appearance when release you can add this here
			
		}
/*		
		function tapHandler(e:GestureEvent):void { 
			//tap funcntionality maybe?  
			addChild(monster); 
			monster.x = 200; 
			monster.y =1200; 
		} 
*/	
		public function downAndDirtyLifeMeter():void { 
			var circs:Shape = new Shape();
			circs.graphics.beginFill(0xFFC015, 1);  //color, opacity 
			circs.graphics.drawCircle(bitmapSheetTwo.food,0, 3); 
			circs.graphics.endFill(); //you have to end your fills 
			circs.x = 100; 
			circs.y = 100; 
			
			//	meterDots.push(circs); 
			addChild(circs);
			//life.push(circs);
		}
		
		
		public function audio() {
			bgSound = new Sound(); 
			
			bgSound:Sound; 
			beeSound:Sound; 
			
			flowerTwoSound:Sound; 
			flowerThreeSound:Sound; 	
			
			var requestBg:URLRequest = new URLRequest("../assets/sounds/Levels/level1-main.mp3"); 
			bgSound.load(requestBg); 
			bgSound.addEventListener(Event.COMPLETE, sounds); 
			bgSound.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
			bgSoundChannel = bgSound.play(); 
			/*		
			var requestBee:URLRequest = new URLRequest("Sounds/GamePieces/beedrop.mp3"); 	
			beeSound.load(requestBee); 
			
			//	beeSound.addEventListener(Event.COMPLETE, sounds); 
			/*
			public function eight() {
			flowerSound:Sound; 
			var requestflowerSound:URLRequest = new URLRequest("Sounds/GamePieces/flower-blackheart.mp3"); 
			flowerSound.load(requestflowerSound); 
			flowerSound.addEventListener(Event.COMPLETE, sounds); 
			flower.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
			flowerSoundChannel = flowerSound.play(); 
			//use on the 1/8th 
			
			}
			
			
			var requestflowerTwoSound:URLRequest = new URLRequest("Sounds/GamePieces/Sflower-bush.mp3"); 
			flowerTwoSound.load(requestflowerTwoSound); 
			flowerTwoSound.addEventListener(Event.COMPLETE, sounds); 
			///use on the 16th
			
			var requestflowerThreeSound:URLRequest = new URLRequest("Sounds/GamePieces/flower-willow.mp3"); 
			flowerThreeSound.load(requestflowerThreeSound); 
			flowerThreeSound.addEventListener(Event.COMPLETE, sounds); 
			///use on the quarter 
			
			}
		*/	}
		public function sounds(evt:Event):void {
			trace("bgSound loaded"); 
			
			//trace("bee sound loaded"); 
			//trace("flowersound loaded"); 
		}
		public function onIOError(evt:IOErrorEvent):void {
			trace("io error"); 
		}
		
		//final two parens here 		
	}
}