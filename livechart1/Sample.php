<?
	$GraphType = 'column3d';
	$SourceURL = 'http://araya.thaigrid.or.th/~trainee6/Data.php';
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Sample Graph</title>
</head>

<body>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="618" height="376" title="Sample Graph">
  <param name="movie" value="Graphs.swf?GType=<?=$GraphType ?>&URL=<?=$SourceURL ?>" />
  <param name="quality" value="high" />
  <embed src="Graphs.swf?GType=<?=$GraphType ?>&URL=<?=$SourceURL ?>" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="618" height="376"></embed>
</object>
</body>
</html>
