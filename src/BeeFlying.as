//kinecrt
//im the picky bee!!! 


package{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.sampler.Sample;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;

	
	public class BeeFlying extends MovieClip {
		public var food:Number; 
		public var damage:Number; 	
		public var bullet:BeeBullet; 
		public var timeTick:Number;
		public var eatTime:Timer; 
		
		//signals 
		public var punched:Signal; 
		public var punchedAgain:Signal; 
		public var puchedNum:Signal; 
		
		//timer vars 
		var timer:Timer;	
		var timerEat:Timer;
		
		public function BeeFlying() {
			super();
			
			food = 0; 	
			damage =0; 
			bullet = new BeeBullet(); 
			timer = new Timer(700, 1); 
			//timer for immuminty of the bee once damaged 
			//timer.addEventListener(TimerEvent.TIMER, immume); 
			//timer.addEventListener(TimerEvent.TIMER, eat);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			//singals 
			punched = new Signal(); 
			punchedAgain = new Signal(); 
			puchedNum = new Signal(); 
			timerEat = new Timer(700, 1); 
			//timer for immuminty of the bee once eats 
			
		//end constructor 		
		}
		
		
		public function onTimerComplete(event:TimerEvent):void {
			trace("theTimer done now."); 
		}
		
		public function eat():void {
			if(!timerEat.running) {
				food +=5;  
				timerEat.start(); 
				trace(food); 
			} 
			if(timerEat.running) { 	
				trace("bee got fat!");
			}
			
		}
		
		public function takeDamage():void { 
			//check to see if bee is immume 
			//if bee is immune bee takes no damage
			
			//check to see if bee is not immune 
			
			//	timer= new Timer(1000, 5); 
			if(!timer.running) { 
				damage +=20;  
				timer.start(); 
				trace(damage); 
				punch(); 
			} 
			if(timer.running) { 	
				trace("msBEE is stunned sucker!");
			}
		}
		
		
		public function punch():void { 
		
			if(damage > food) 
				{
				trace("Msbee dies!"); 
				
				//gotoAndStop("beeDies");
				punched.dispatch();
			
		}
		}
		
		
		public function punchAgain():void { 
			
			if(damage > food) 
			{
				
				//gotoAndStop("beeDies");
				punchedAgain.dispatch("i got hit again"); 
				
			}
		}
		
		public function punchNums():void { 
			
			if(damage > food) 
			{
				
					//gotoAndStop("beeDies");
				puchedNum.dispatch(5);
				
			}
		}
		
//close class and package		
	}
}