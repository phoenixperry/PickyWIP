//kinext 
//im the picky bee!!! 


package{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class BlackEater extends MovieClip {
		public var food:Number; 
		public var damage:Number; 	
		public var bullet:BeeBullet; 
		public var timeTick:Number;
		public var timerEat:Timer; 
		
		//timer vars 
		var timer:Timer;		
		
		public function BlackEater() {
			super();
			
			food = 0; 	
			damage =0; 
			bullet = new BeeBullet(); 
			timer = new Timer(1000, 5); 
			//timer for immuminty of the bee once damaged 
			timer.addEventListener(TimerEvent.TIMER, immume); 
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			timerEat = new Timer(700, 1); 
		}
		
		public function onTimerComplete(event:TimerEvent):void {
			trace("MonsterTimer done now."); 
		}
		
		public function immume(event:TimerEvent):void {
			trace("thisMonster stunned"); 
		}
		
		public function eat():void {
			if(!timerEat.running) {
				food +=5;  
				timerEat.start(); 
				trace(food); 
			} 
			if(timerEat.running) { 	
				trace("monster got fat!");
			}
			
		}
		
		public function takeDamage():void { 
			//check to see if bee is immume 
			//if bee is immune bee takes no damage
			
			//check to see if bee is not immune 
			damage +=1; 
			//	timer= new Timer(1000, 5); 
			if(!timer.running) { 
				damage +=1;  
				timer.start(); 
				trace(damage); 
			} 
			if(timer.running) { 	
				trace("Monster stunned sucker!");
			}
		}
		
		
		public function die():void{ 
			if(damage > food) trace("Monster dies!"); 
		}
		
		
		
	}
}