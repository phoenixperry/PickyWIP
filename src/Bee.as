
//im the picky bee!!! 


package{
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

	public class Bee extends MovieClip {
		public var food:Number; 
		public var damage:Number; 	
		public var bullet:BeeBullet; 
		public var timeTick:Number;
		public var eatTime:Timer; 
		
		//timer vars 
		var timer:Timer;	
		var timerEat:Timer;
		
		public function Bee() {
			super();
			
			food = 0; 	
			damage =0; 
			bullet = new BeeBullet(); 
			timer = new Timer(700, 1); 
			//timer for immuminty of the bee once damaged 
			//timer.addEventListener(TimerEvent.TIMER, immume); 
			//timer.addEventListener(TimerEvent.TIMER, eat);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			
			
			timerEat = new Timer(700, 1); 
			//timer for immuminty of the bee once eats 
		
			
		}
		
		public function onTimerComplete(event:TimerEvent):void {
			trace("theTimer done now."); 
		}

		public function eat() {
			if(!timerEat.running) {
				food +=1;  
				timerEat.start(); 
				trace(food); 
			} 
			if(timerEat.running) { 	
				trace("bee got fat!");
			}
		
		}
		
		public function takeDamage() { 
			//check to see if bee is immume 
			//if bee is immune bee takes no damage
			
			//check to see if bee is not immune 
		
			//	timer= new Timer(1000, 5); 
			if(!timer.running) { 
				damage +=20;  
				timer.start(); 
				trace(damage); 
			} 
			if(timer.running) { 	
				trace("msBEE is stunned sucker!");
			}
		}
		
		
		public function die() { 
			if(damage > food) trace("Msbee dies!"); 
			gotoAndPlay("beeDies");
		}
		
		
		
	}
}