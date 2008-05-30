import ColumnGraphData;
class Column 
{
	private var Graph:MovieClip;
	private var Data:ColumnGraphData;
	function Column(target:MovieClip) 
	{
		Graph = target;
		this.Data = new ColumnGraphData();
	}
	public function LoadDataStatus():Boolean 
	{
		return this.Data.LoadDataStatus();
	}
	public function ClearLoadStatus():Void 
	{
		this.Data.ClearLoadStatus();
	}
	public function ClearGraph():Void 
	{
		Graph.clear();
	}
	public function DotYPosition(Data:Number,GraphHeight:Number):Number 
	{
		if(Data<=0)
			return GraphHeight;
		else
			return (GraphHeight-((GraphHeight/(this.Data.getYscale())[5])*Data));
	}
	public function DrawCross(x:Number, y:Number, color:Number, target:MovieClip):Void 
	{
		target.lineStyle(1, color, 100);
		target.moveTo(x-5, y-5);
		target.lineTo(x+5, y+5);
		target.moveTo(x-5, y+5);
		target.lineTo(x+5, y-5);
		target.moveTo(x, y);
	}
	public function UpdateData(xml:String):Void 
	{
		this.Data.xmlLoad(xml);
	}
	public function UpdateGraph(target:MovieClip):Void 
	{
		//clear old graph
		target.clear();
		target.GraphColumn.clear();
		target.GraphBody.clear();
		target.error.removeTextField();
		
		target._x = 0;
		target._y = 0;
		for(var i=0;i<100;i++)
		{
			target["X_"+i].removeTextField();
		}
		
		var Depth = 1;
		//graph body variables
		var GraphX 			= 105;
		var GraphY 			= 80;
		var FixGraphWidth 	= 350; 
		var	GraphWidth		= FixGraphWidth + (this.Data.getDataSetAmount() - (FixGraphWidth%this.Data.getDataSetAmount()));
		var FixGraphHeight 	= 250;
		var GraphHeight		= FixGraphHeight + (5 - (FixGraphHeight%5));
		
		//graph header variables
		var HeaderX 	= GraphX;
		var HeaderY 	= GraphY - 65;
		var HeaderWidth = GraphWidth;
		var HeaderHeight= 31;
		
		//column variables
		var el		= GraphWidth/this.Data.getDataSetAmount();
		var d		= 0.25 * el;
		var CWidth 	= 0.5 * el;
		
		//y axis's name variables
		var YTagHeight 	= 20;
		var YTagWidth 	= 114;
		var YTagX 		= GraphX - (YTagWidth/2);
		var YTagY 		= GraphY - (YTagHeight + 10);
		
		//x axis's name variables
		var XTagHeight	= 20;
		var XTagWidth	= 114;
		var XTagX		= GraphX + GraphWidth+5;
		var XTagY		= GraphY + GraphHeight - (XTagHeight/2);
		
		//y tag's variables
		var YHeight = 16;
		var YWidth 	= 90;
		var Yx 		= GraphX - YWidth - 5;
		var Yy 		= GraphY + GraphHeight - (YHeight/2);
		
		//x tag's variables
		var XWidth 	= el;
		var XHeight = 16;
		var Xx 		= GraphX;
		var Xy 		= GraphY + GraphHeight + 5;
		
		//draw graph body
		var fillType = "linear";
		var colors = [0x999999, 0xFFFFFF];
		var alphas = [30, 60];
		var ratios = [0, 255];
		var matrix = {matrixType:"box", x:GraphX, y:GraphY, w:GraphWidth, h:GraphHeight, r:90/180*Math.PI};
				
		target.createEmptyMovieClip("GraphBody", Depth++);
		target.GraphBody._x = GraphX;
		target.GraphBody._y = GraphY;
		target.GraphBody.moveTo(0, 0);
		target.GraphBody.lineStyle(0, 0, 100);
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.lineTo(0, GraphHeight);
		target.GraphBody.lineTo(GraphWidth, GraphHeight);
		target.GraphBody.lineTo(GraphWidth, 0);
		target.GraphBody.lineTo(0, 0);
		target.GraphBody.endFill();
		
		//draw grid line
		for (i = 0; i<4; i++) 
		{
			target.GraphBody.moveTo(0, GraphHeight-((i+1)*(GraphHeight/5)));
			target.GraphBody.lineStyle(1, 0, 10);
			target.GraphBody.lineTo(GraphWidth, GraphHeight-((i+1)*(GraphHeight/5)));
		}
		
		//draw header
		target.createTextField("Header", Depth++, HeaderX, HeaderY, GraphWidth, HeaderHeight);
		target.Header.text = this.Data.getHeader();
		var myformat = new TextFormat();
		myformat.size = 22;
		myformat.align = "center";
		myformat.bold = true;
		target.Header.setTextFormat(myformat);
		
		//draw axis detail
		var myformat = new TextFormat();
		for (i=0; i<6; i++) 
		{
			target.createTextField("Y_"+i, Depth++, Yx, Yy - i*(GraphHeight/5), YWidth, YHeight);
			target["Y_"+i].text = (this.Data.getYscale())[i];
			myformat.size = 10;
			myformat.align = "right";
			target["Y_"+i].setTextFormat(myformat);
		}
		
		//draw y's axis name
		target.createTextField("Y_name", Depth++, YTagX, YTagY, YTagWidth, YTagHeight);
		target["Y_name"].text = this.Data.getYname();
		myformat.size = 10;
		myformat.align = "center";
		target["Y_name"].setTextFormat(myformat);
		
		//draw x's axis name
		target.createTextField("X_name", Depth++, XTagX, XTagY, XTagWidth, XTagHeight);
		target["X_name"].text = this.Data.getXname();
		myformat.size = 10;
		myformat.align = "left";
		target["X_name"].setTextFormat(myformat);
		
		//draw data columns
		target.createEmptyMovieClip("GraphColumn", Depth++);
		target.GraphColumn._x = GraphX;
		target.GraphColumn._y = GraphY;

		for(var i = 0; i < this.Data.getDataSetAmount(); i++)
		{
			if((this.Data.getDataValue())[i][0]!=0)
			{
				var Cx1 = (i * el) + d;
				var Cx2 = Cx1 + CWidth;
				var Cy  = DotYPosition((this.Data.getDataValue())[i][0],GraphHeight);
				//draw column
				var fillType = "linear";
				var colors = [(this.Data.getDataColor())[i], (this.Data.getDataColor())[i]];
				var alphas = [100, 50];
				var ratios = [0, 255];
				var matrix = {matrixType:"box", x:Cx1, y:DotYPosition((this.Data.getDataValue())[i][0],GraphHeight), w:CWidth, h:GraphHeight-DotYPosition((this.Data.getDataValue())[i][0],GraphHeight), r:270/180*Math.PI};
				target.GraphColumn.beginGradientFill(fillType, colors, alphas, ratios, matrix);
				//target.GraphColumn.beginFill((this.Data.getDataColor())[i],100);
				target.GraphColumn.moveTo(Cx1,GraphHeight);
				target.GraphColumn.lineTo(Cx1,Cy);
				target.GraphColumn.lineTo(Cx2,Cy);
				target.GraphColumn.lineTo(Cx2,GraphHeight);
				target.GraphColumn.endFill();
			}
			
			//draw value's text box above the column
			target.GraphColumn.createTextField("C_"+i, Depth++, i*el, DotYPosition((this.Data.getDataValue())[i][0],GraphHeight)-15, el, 15.5);
			target.GraphColumn["C_"+i].text = (this.Data.getDataValue())[i][0];
			myformat.size 	= 10;
			myformat.align 	= "center";
			//target.GraphColumn["C_"+i].border = true;
			target.GraphColumn["C_"+i].setTextFormat(myformat);
		}
		
		//draw column's tags at x axis
		for (i=0; i<this.Data.getDataSetAmount(); i++) 
		{
			Cx1 = Xx + (i * el);
			target.createTextField("X_"+i, Depth++, Cx1, Xy, XWidth, XHeight);
			target["X_"+i].text 	= (this.Data.getDataSetNames())[i];
			//target["X_"+i].border 	= true;
			myformat.size 	= 10;
			myformat.align 	= "center";
			myformat.bold 	= true;
			target["X_"+i].setTextFormat(myformat);
		}
	}
}
