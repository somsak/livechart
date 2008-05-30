import ColumnGraphData;
class Column3D 
{
	private var Graph:MovieClip;
	private var Data:ColumnGraphData;
	function Column3D(target:MovieClip) 
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
	public function UpdateData(url:String):Void 
	{
		this.Data.GetData(url);
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
		
		var Depth:Number = new Number(1);
		//graph body variables
		var GraphX:Number 			= new Number(80);
		var GraphY:Number 			= new Number(80);
		var FixGraphWidth:Number 	= new Number(350); 
		var	GraphWidth:Number		= new Number(FixGraphWidth + (this.Data.getDataSetAmount() - (FixGraphWidth%this.Data.getDataSetAmount())));
		var FixGraphHeight:Number 	= new Number(250);
		
		if((5 - (FixGraphHeight%5))<5)
			var GraphHeight:Number	= new Number(FixGraphHeight + (5 - (FixGraphHeight%5)));
		else
			var GraphHeight:Number 	= new Number(FixGraphHeight);
		
		//graph header variables
		var HeaderX:Number 		= new Number(GraphX);
		var HeaderY:Number 		= new Number(GraphY - 65);
		var HeaderWidth:Number 	= new Number(GraphWidth);
		var HeaderHeight:Number	= new Number(31);
		
		//column variables
		var el:Number		= new Number(GraphWidth/this.Data.getDataSetAmount());
		var d:Number		= new Number(0.25 * el);
		var CWidth:Number 	= new Number(0.5 * el);
		
		//y axis's name variables
		var YTagHeight:Number	= new Number(20);
		var YTagWidth:Number 	= new Number(114);
		var YTagX:Number 		= new Number(GraphX - (YTagWidth/2));
		var YTagY:Number 		= new Number(GraphY - (YTagHeight + 10));
		
		//x axis's name variables
		var XTagHeight:Number	= new Number(20);
		var XTagWidth:Number	= new Number(114);
		var XTagX:Number		= new Number(GraphX + GraphWidth+5);
		var XTagY:Number		= new Number(GraphY + GraphHeight - (XTagHeight/2));
		
		//y tag's variables
		var YHeight:Number 	= new Number(16);
		var YWidth:Number 	= new Number(90);
		var Yx:Number 		= new Number(GraphX - YWidth - 5);
		var Yy:Number 		= new Number(GraphY + GraphHeight - (YHeight/2));
		
		//x tag's variables
		var XWidth:Number 	= new Number(el);
		var XHeight:Number 	= new Number(16);
		var Xx:Number 		= new Number(GraphX);
		var Xy:Number 		= new Number(GraphY + GraphHeight + 5);
		
		var r:Number	= new Number(15);
		var cx:Number	= new Number(GraphWidth/2);
		var cy:Number	= new Number(GraphHeight/2);
		
		//draw graph body
		var fillType = "linear";
		var colors = [0x999999, 0x999999];
		var alphas = [70, 30];
		var ratios = [0, 255];
		var matrix = {matrixType:"box", x:0, y:0, w:GraphWidth, h:GraphHeight, r:(45/180)*Math.PI};
		
		target.createEmptyMovieClip("GraphBody", Depth++);
		target.GraphBody._x = GraphX;
		target.GraphBody._y = GraphY;
		target.GraphBody.moveTo(0, 0);
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.lineTo(0, GraphHeight);
		target.GraphBody.lineTo(GraphWidth, GraphHeight);
		target.GraphBody.lineTo(GraphWidth, 0);
		target.GraphBody.lineTo(0, 0);
		target.GraphBody.endFill();
		var matrix = {matrixType:"box", x:r*Math.cos(3*Math.PI/4), y:GraphHeight, w:GraphWidth, h:r, r:(0/180)*Math.PI};
		target.GraphBody.moveTo(0,GraphHeight);
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.lineTo(r*Math.cos(3*Math.PI/4),GraphHeight + r*Math.sin(3*Math.PI/4));
		target.GraphBody.lineTo(GraphWidth + (r*Math.cos(3*Math.PI/4)),GraphHeight + r*Math.sin(3*Math.PI/4));
		target.GraphBody.lineTo(GraphWidth ,GraphHeight);
		target.GraphBody.endFill();
		var matrix = {matrixType:"box", x:r*Math.cos(3*Math.PI/4), y:GraphHeight + r*Math.sin(3*Math.PI/4), w:GraphWidth, h:r, r:(3/2)*Math.PI};
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.moveTo(r*Math.cos(3*Math.PI/4),GraphHeight + r*Math.sin(3*Math.PI/4));
		target.GraphBody.lineTo(r*Math.cos(3*Math.PI/4),GraphHeight + r*Math.sin(3*Math.PI/4)+8);
		target.GraphBody.lineTo(GraphWidth + (r*Math.cos(Math.PI)),GraphHeight + r*Math.sin(3*Math.PI/4)+8);
		target.GraphBody.lineTo(GraphWidth + (r*Math.cos(Math.PI)),GraphHeight + r*Math.sin(3*Math.PI/4));
		target.GraphBody.endFill();
		var matrix = {matrixType:"box", x:r*Math.cos(3*Math.PI/4), y:GraphHeight + r*Math.sin(3*Math.PI/4), w:GraphWidth, h:r, r:Math.PI};
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.moveTo(GraphWidth + (r*Math.cos(Math.PI)),GraphHeight + r*Math.sin(3*Math.PI/4));
		target.GraphBody.lineTo(GraphWidth + (r*Math.cos(Math.PI)),GraphHeight + r*Math.sin(3*Math.PI/4)+8);
		target.GraphBody.lineTo(GraphWidth,GraphHeight+8);
		target.GraphBody.lineTo(GraphWidth,GraphHeight);
		target.GraphBody.endFill();
		target.GraphBody.beginGradientFill(fillType, colors, alphas, ratios, matrix);
		target.GraphBody.moveTo(GraphWidth,0);
		target.GraphBody.lineTo(GraphWidth+3,5);
		target.GraphBody.lineTo(GraphWidth+3,GraphHeight-5);
		target.GraphBody.lineTo(GraphWidth,GraphHeight);
		
		//draw grid line
		for (i = 0; i<5; i++) 
		{
			target.GraphBody.moveTo(0, GraphHeight-(i*(GraphHeight/5)));
			target.GraphBody.lineStyle(1, 0, 10);
			target.GraphBody.lineTo(GraphWidth, GraphHeight-(i*(GraphHeight/5)));
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
				var Cx1:Number = new Number((i * el) + d);
				var Cx2:Number = new Number(Cx1 + CWidth);
				var Cy:Number  = new Number(DotYPosition((this.Data.getDataValue())[i][0],GraphHeight));
				//draw column
				var fillType = "linear";
				var colors = [(this.Data.getDataColor())[i],(this.Data.getDataColor())[i]];
				var alphas = [100, 80];
				var ratios = [0, 255];
				var matrix = {matrixType:"box", x:Cx1+r*Math.cos(3*Math.PI/4), y:Cy+r*Math.sin(3*Math.PI/4), w:CWidth, h:GraphHeight-Cy, r:270/180*Math.PI};
				var interpolationMethod = "linearRGB";
				target.GraphColumn.lineStyle(1,0xCCCCCC,100);
				target.GraphColumn.beginGradientFill(fillType, colors, alphas, ratios, matrix, interpolationMethod);
				target.GraphColumn.moveTo(Cx1+r*Math.cos(3*Math.PI/4),GraphHeight+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.lineTo(Cx1+r*Math.cos(3*Math.PI/4),Cy+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.lineTo(Cx2+r*Math.cos(3*Math.PI/4),Cy+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.lineTo(Cx2+r*Math.cos(3*Math.PI/4),GraphHeight+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.endFill();
				
				var matrix = {matrixType:"box", x:Cx1+r*Math.cos(3*Math.PI/4), y:Cy, w:CWidth+r, h:r*Math.sin(7*Math.PI/4), r:135/180*Math.PI};
				target.GraphColumn.beginGradientFill(fillType, colors, alphas, ratios, matrix);
				target.GraphColumn.moveTo(Cx1+r*Math.cos(3*Math.PI/4),Cy+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.lineTo(Cx1,Cy);
				target.GraphColumn.lineTo(Cx2,Cy);
				target.GraphColumn.lineTo(Cx2+r*Math.cos(3*Math.PI/4),Cy+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.endFill();
				
				var matrix = {matrixType:"box", x:Cx2+r*Math.cos(Math.PI), y:Cy, w:CWidth, h:GraphHeight-Cy+(2*r), r:135/180*Math.PI};
				target.GraphColumn.beginGradientFill(fillType, colors, alphas, ratios, matrix);
				target.GraphColumn.moveTo(Cx2,Cy);
				target.GraphColumn.lineTo(Cx2,GraphHeight);
				target.GraphColumn.lineTo(Cx2+r*Math.cos(3*Math.PI/4),GraphHeight+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.lineTo(Cx2+r*Math.cos(3*Math.PI/4),Cy+r*Math.sin(3*Math.PI/4));
				target.GraphColumn.lineTo(Cx2,Cy);
				target.GraphColumn.endFill();
			}
			
			//draw value's text box above the column
			target.GraphColumn.createTextField("C_"+i, Depth++, (i*el), Cy-15, el, 15.5);
			target.GraphColumn["C_"+i].text = (this.Data.getDataValue())[i][0];
			myformat.size 	= 10;
			myformat.align 	= "center";
			target.GraphColumn["C_"+i].setTextFormat(myformat);
		}
		
		//draw column's tags at x axis
		for (i=0; i<this.Data.getDataSetAmount(); i++) 
		{
			Cx1 = Xx + (i * el);
			target.createTextField("X_"+i, Depth++, Cx1+r*Math.cos(3*Math.PI/4), Xy+r*Math.sin(3*Math.PI/4), XWidth, XHeight);
			target["X_"+i].text 	= (this.Data.getDataSetNames())[i];
			myformat.size 	= 10;
			myformat.align 	= "center";
			myformat.bold 	= true;
			target["X_"+i].setTextFormat(myformat);
		}
	}
}
