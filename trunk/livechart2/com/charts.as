class charts
{
	private var Graphs:Array;
	private var GraphNo:Number;
	private var GraphType:Array;
	private var Data:Array;
	
	function charts(No:Number):Void
	{
		var i;
		Graphs = new Array(No);
		GraphNo = No;
		for(i=0;i<GraphNo;i++)
		{
			Graph[i] = new Graph
		}
	}
}