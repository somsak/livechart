import mx.utils.Delegate;
class config
{	
	private var GraphType:String;
	
	function config()
	{
		GraphType 		= new String("");
	}	
	public function getGraphType():String
	{
		return trim(GraphType);
	}
	public function trim(str:String):String
	{
		for(var i = 0; str.charCodeAt(i) < 33; i++);
		for(var j = str.length-1; str.charCodeAt(j) < 33; j--);
		return str.substring(i, j+1);
	}
	public function setConfig(GType:String):Void
	{
		GraphType = GType;
	}
}