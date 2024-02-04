package com.coursevector.display {

	public class DisplayObject3D {
		
		private var dispObj:*;
		public var xpos:Number;
		public var ypos:Number;
		public var zpos:Number;
		public var z:Number;
		
		public function DisplayObject3D(obj:*) {
			dispObj = obj;
		}
		
		// Y Prop
		public function get y():Number {
			return dispObj.y;
		}
		public function set y(n:Number):void {
			dispObj.y = n;
		}
		
		// X Prop
		public function get x():Number {
			return dispObj.x;
		}
		public function set x(n:Number):void {
			dispObj.x = n;
		}
		
		// Width Prop
		public function get width():Number {
			return dispObj.width;
		}
		public function set width(n:Number):void {
			dispObj.width = n;
		}
		
		// Height Prop
		public function get height():Number {
			return dispObj.height;
		}
		public function set height(n:Number):void {
			dispObj.height = n;
		}
		
		// yScale Prop
		public function get scaleY():Number {
			return dispObj.scaley;
		}
		public function set scaleY(n:Number):void {
			dispObj.scaleY = n;
		}
		
		// xScale Prop
		public function get scaleX():Number {
			return dispObj.scalex;
		}
		public function set scaleX(n:Number):void {
			dispObj.scaleX = n;
		}
		
		// Alpha Prop
		public function get alpha():Number {
			return dispObj.alpha;
		}
		public function set alpha(n:Number):void {
			dispObj.alpha = n;
		}
		
		// Return source object
		public function get src():* {
			return dispObj;
		}
	}
}