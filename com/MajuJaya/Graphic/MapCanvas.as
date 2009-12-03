package com.MajuJaya.Graphic {
	
	import mx.flash.UIMovieClip;
	import flash.display.MovieClip;
	import mx.controls.Alert;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	
	public class MapCanvas extends UIMovieClip {
		
		public var Edges:Array;
		public var Nodes:Array;
		public var Connections:Array;
		
		private var NodeHolder:MovieClip = new MovieClip();
		private var EdgeHolder:MovieClip = new MovieClip();
		
		private var PointerDst:Node = new Node("Destination", -50,-50,99);
		private var PointerSrc:Node = new Node("Source", -50,-50,98);
		
		private var NodeDst:int = -1;
		private var NodeSrc:int = -1;
		
		
		public function MapCanvas(EdgeSet:Array, NodeSet:Array, ConnectionSet:Array) {
			
			super();
			
			Edges = EdgeSet;
			Nodes = NodeSet;
			Connections = ConnectionSet;
			
			populateEdges();
			populateNodes();
			
			this.addChild(EdgeHolder);
			this.addChild(PointerDst);
			this.addChild(PointerSrc);
			this.addChild(NodeHolder);
			
			PointerDst.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void{PointerDst.startDrag(true, null)} );
			PointerDst.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent):void{PointerDst.stopDrag()} );
			
			NodeHolder.addEventListener(MouseEvent.CLICK, NodeClicked);
			EdgeHolder.addEventListener(MouseEvent.CLICK, EdgeClicked);
			
			EdgeHighlight([]);
		}
		
		public function populateEdges():void
		{
			for (var i:int = 0; i < Edges.length; i++) {
				var edgeObj:Edge = new Edge(Edges[i][1], Edges[i][3], Edges[i][2]);
				EdgeHolder.addChild(edgeObj);
 			}
		}
		
		public function populateNodes():void
		{
			for(var i:uint = 0; i<Nodes.length; i++)
			{
				var nodeObj:Node = new Node(Nodes[i][1], Nodes[i][2], Nodes[i][3], 1);
				NodeHolder.addChild(nodeObj);
			}
		}
		
		private function EdgeClicked(e:MouseEvent):void
		{
			var mousePosition:Point = new Point(EdgeHolder.mouseX, EdgeHolder.mouseY);
			var obj:Object = EdgeHolder.getObjectsUnderPoint(mousePosition)[0];
			Alert.show(obj.name);
		}
		
		private function NodeClicked(e:MouseEvent):void
		{
		
			var mousePosition:Point = new Point(NodeHolder.mouseX, NodeHolder.mouseY);
			var obj:Object = NodeHolder.getObjectsUnderPoint(mousePosition)[0];
			var displayObj:DisplayObject = NodeHolder.getChildByName(obj.name);
			var objIndex:int = NodeHolder.getChildIndex(displayObj);
			
			if(NodeDst != -1){
			    var prevDst:Object = NodeHolder.getChildAt(NodeDst);
    			var displayPrevDst:DisplayObject = NodeHolder.getChildByName(prevDst.name);
			}
			
			if(objIndex == NodeSrc){
				if(NodeDst != -1){
				    PointerSrc.x = displayPrevDst.x;
				    PointerSrc.y = displayPrevDst.y;
				}else{
				    PointerSrc.x = -50;
				    PointerSrc.y = -50;
				}
		        NodeSrc = NodeDst;
		        NodeDst = -1;
				obj.selected = false;
				PointerDst.x = -50;
				PointerDst.y = -50;
			}else if(objIndex == NodeDst){
		        NodeDst = -1;
				obj.selected = false;
				PointerDst.x = -50;
				PointerDst.y = -50;
			}else{
			    if(NodeDst != -1 && NodeDst != -1){
	                prevDst.selected = false;
	                NodeDst = objIndex;
				    PointerDst.x = displayObj.x;
				    PointerDst.y = displayObj.y;
			    }else if(NodeSrc == -1){
			        NodeSrc = objIndex;
				    PointerSrc.x = displayObj.x;
				    PointerSrc.y = displayObj.y;
			    }else{
			        NodeDst = objIndex;
				    PointerDst.x = displayObj.x;
				    PointerDst.y = displayObj.y;
			    }
				obj.selected = true;
			}
			
			if(NodeDst != -1 && NodeDst != -1){
			    searchShortestPath(NodeSrc, NodeDst);
			}
			
		}
		
		public function searchShortestPath(NodeSource:int, NodeDestination:int):void
		{
		    EdgeHighlight([0,1,2,3,5,7]);
		}
		
		private function EdgeHighlight(EdgeIndex:Array):void
		{
		    for (var i:int = 0; i < Edges.length; i++) {
		        EdgeHolder.getChildAt(i).alpha = 0;
		        for (var j:int = 0; j < EdgeIndex.length; j++) {
		            if(i==EdgeIndex[j]){
		                EdgeHolder.getChildAt(EdgeIndex[j]).alpha = 1;
		            }
		        }
 			}
		}

		
		private function ResetEdgeHighlight():void
		{
		    for (var i:int = 0; i < Edges.length; i++) {
		        EdgeHolder.getChildAt(i).alpha = 1;
 			}
		}
		
	}
	
}



