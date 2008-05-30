import mx.utils.Delegate;
class config
{	
	private var GraphType:String;
	private var SourceURL:String;
	
	function config()
	{
		GraphType 		= new String("");
		SourceURL		= new String("");
	}	
	public function getGraphType():String
	{
		return trim(GraphType);
	}
	public function getSourceURL():String
	{
		return trim(SourceURL);
	}
	public function trim(str:String):String
	{
		for(var i = 0; str.charCodeAt(i) < 33; i++);
		for(var j = str.length-1; str.charCodeAt(j) < 33; j--);
		return str.substring(i, j+1);
	}
	public function setConfig(GType:String,Url:String):Void
	{
		GraphType = GType;
		SourceURL = Url;
	}
}