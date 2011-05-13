//kinecrt
package
{
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.GestureEvent; 
	
	
	
	public class Picky extends MovieClip {
	//	Multitouch.inputMode = MultitouchInputMode.GESTURE;
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
	

		public function Picky(){
		//constructor 
			trace("I ran");
			beeFlying = new BeeFlying(); 
			bee = new Bee(); 
			road = new Road();
			road2 = new Road(); 
			flower = new Flower();
			monster = new HeartEater(); 
			
			mover = 30; 
			
			
			
			road.x = 0.0; 
			road.y = 650.0; 
			roadBreadth = 1500; 
			road2.x = road.x + roadBreadth; 
			road2.y = road.y; 
			
			
			beeFlying.scaleX *= -1;
			beeFlying.x = 100; 
			beeFlying.y =600; 
			flower.x = 500; 
			flower.y = 500; 
			
			monster.x = 2000; 
			monster.y = 150; 
				
			addChild(beeFlying);
			roadContainer = new MovieClip(); 
			roadContainer.addChild(road);
			roadContainer.addChild(road2); 
			roadContainer.addChild(flower); 
			roadContainer.addChild(monster); 
			
			stage.addChild(roadContainer); 
	
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame );
			//trace(roadContainer.x, "/", road2.x); 
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			//keyDownHandler); //
			addEventListener(Event.ENTER_FRAME, update);
			//update the game loop
	//close Picky
		}
		
		public function onEnterFrame( evt:Event ):void
		{
			//sbee.x = bee.x + 3;
			
			roadContainer.x = 275 - mover;
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
		
		function keyPressed(evt:KeyboardEvent):void 
		{
			switch(evt.keyCode) {
				case 39:
					beeFlying.x +=130
					break; 
				
				case 40: 
					beeFlying.y +=15; 
					break; 
				
				case 38: 
					beeFlying.y -=15; 
					break; 
				
				case 32:
					//fire a bullet 
					//bee.fire(); 		
				}
		}
		
		function update(evt:Event) {
			if (beeFlying.hitTestObject(flower)) 
			{
				beeFlying.eat(); 
				trace(beeFlying.food , "bee eats"); 
				
				
			}
			
			if (monster.hitTestObject(beeFlying)) 
			{	
				monster.eat(); 
				beeFlying.takeDamage();
				trace(beeFlying.damage, "bee takes zeedamage", monster.food, "monster eats"); 
				beeFlying.die(); 
				//if(beeFlying.die()){removeChild(beeFlying);}
				
				monster.die(); 
				//attach a listener to the bee when she dies and listen for it here. 
				//if(monster.die()){removeChild(monster);}
			}
			
			
		}
		
//final two parens here 		
	}
}