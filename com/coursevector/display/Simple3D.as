/*
 * Portions adapted from Paul Ortchanian San Francisco CA
 * paul@reflektions.com
 * 
 * Thanks for the simple formulas!
 */

package com.coursevector.display {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.coursevector.display.DisplayObject3D;
	
	public class Simple3D extends Sprite {
		
		private var arrDisplayList:Array = new Array();
		private var fl:uint; // Focal Length
		private var vpX:Number; // Vanishing Point X
		private var vpY:Number; // Vanishing Point Y
		private var vpZ:Number; // Vanishing Point Z
		private var _angleX:Number = 0;
		private var _angleY:Number = 0;
		private var _angleZ:Number = 0;
		private var piRad:Number = Math.PI / 180;
		
		function Simple3D(centerCoord:Object, focalLength:uint=300) {
			fl = focalLength;
			vpX = centerCoord.x; // Preferrably stage.stageWidth / 2
			vpY = centerCoord.y; // Preferrably stage.stageHeight / 2
			vpZ = fl / 2;
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function addObject(obj:DisplayObject, initCoord:Object):void {
			var newObj:DisplayObject3D = new DisplayObject3D(obj);
			newObj.xpos = initCoord.x;
			newObj.ypos = initCoord.y;
			
			// Miniml way
			//newObj.x = initCoord.x;
			//newObj.y = initCoord.y;
			
			newObj.zpos = newObj.z = initCoord.z;
			arrDisplayList.push(newObj);
		}
		
		public function set cameraX(n:Number):void {
			//
		}
		
		public function set cameraY(n:Number):void {
			//
		}
		
		public function set cameraZ(n:Number):void {
			//
		}
		
		// Rotate X Prop
		public function get rotateX():Number {
			return _angleX;
		}
		public function set rotateX(n:Number):void {
			_angleX = n;
		}
		
		// Rotate Y Prop
		public function get rotateY():Number {
			return _angleY;
		}
		public function set rotateY(n:Number):void {
			_angleY = n;
		}
		
		// Rotate Z Prop
		public function get rotateZ():Number {
			return _angleZ;
		}
		public function set rotateZ(n:Number):void {
			_angleZ = n;
		}
		
		// Rotate X Speed Prop
		public function get rotateSpeedX():Number {
			return _angleX;
		}
		public function set rotateSpeedX(n:Number):void {
			_angleX = n;
		}
		
		// Rotate Y Speed Prop
		public function get rotateSpeedY():Number {
			return _angleY;
		}
		public function set rotateSpeedY(n:Number):void {
			_angleY = n;
		}
		
		// Rotate Z Speed Prop
		public function get rotateSpeedZ():Number {
			return _angleZ;
		}
		public function set rotateSpeedZ(n:Number):void {
			_angleZ = n;
		}
		
		public function update(e:Event):void {
			for(var i in arrDisplayList) {
				updateItem(arrDisplayList[i]);
			}
			
			sortZOrder();
		}
		
		private function updateItem(curObj:DisplayObject3D):void {
			var xRad:Number = _angleX * piRad;
			var yRad:Number = _angleY * piRad;
			var zRad:Number = _angleZ * piRad;
			
			rotateItemX(curObj, xRad);
			rotateItemY(curObj, yRad);
			rotateItemZ(curObj, zRad);
			positionItem(curObj);
		}
		
		private function rotateItemX(curObj:DisplayObject3D, angle:Number):void {
			var cosX:Number = Math.cos(angle);
			var sinX:Number = Math.sin(angle);
			
			/* Goes to angle amount
			var tempZ:Number = curObj.z * cosX - curObj.y * sinX;
			var tempY:Number = curObj.z * sinX + curObj.y * cosX;
			*/
			
			// Updates by angle amount
			var tempY:Number = curObj.ypos * cosX - curObj.zpos * sinX;
			var tempZ:Number = curObj.zpos * cosX + curObj.ypos * sinX;
			
			curObj.ypos = tempY;
			curObj.zpos = tempZ;
		}
		
		private function rotateItemY(curObj:DisplayObject3D, angle:Number):void {
			var cosY:Number = Math.cos(angle);
			var sinY:Number = Math.sin(angle);
			
			/* Goes to angle amount
			var tempX:Number = curObj.x * cosY - curObj.z * sinY;
			var tempZ:Number = curObj.x * sinY + curObj.z * cosY;
			*/
			
			// Updates by angle amount
			var tempX:Number = curObj.xpos * cosY - curObj.zpos * sinY;
			var tempZ:Number = curObj.zpos * cosY + curObj.xpos * sinY;
			
			curObj.xpos = tempX;
			curObj.zpos = tempZ;
		}
		
		private function rotateItemZ(curObj:DisplayObject3D, angle:Number):void {
			var cosZ:Number = Math.cos(angle);
			var sinZ:Number = Math.sin(angle);
			
			/* Goes to angle amount
			var tempX:Number = curObj.x * cosZ - curObj.y * sinZ;
			var tempY:Number = curObj.y * cosZ + curObj.x * sinZ;
			*/
			
			// Updates by angle amount
			var tempX:Number = curObj.xpos * cosZ - curObj.ypos * sinZ;
			var tempY:Number = curObj.ypos * cosZ + curObj.xpos * sinZ;
			
			curObj.xpos = tempX;
			curObj.ypos = tempY;
		}
		
		private function positionItem(curObj:DisplayObject3D):void {
			if(curObj.zpos > -fl) {
				//var scale:Number = fl / (fl + curObj.zpos);
				var scale:Number = fl / (fl + curObj.z);
				
				curObj.x = vpX + curObj.xpos * scale;
				curObj.y = vpY + curObj.ypos * scale;
				curObj.z = vpZ + fl + curObj.zpos * scale;
				
				curObj.alpha = scale;
				curObj.scaleY = scale;
				curObj.scaleX = scale;
				curObj.src.visible = true;
			} else {
				curObj.src.visible = false;
			}
		}
		
		private function sortZOrder():void {
			arrDisplayList.sortOn("zpos", Array.NUMERIC | Array.DESCENDING);
			var len:uint = arrDisplayList.length;
			
			for(var i:uint = 0; i < len; i++) {
				var curObj:* = arrDisplayList[i];
				curObj.src.parent.setChildIndex(curObj.src, i);
			}
		}
	}
}