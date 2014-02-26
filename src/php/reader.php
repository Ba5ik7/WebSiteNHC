<?php
$xmlData=file_get_contents('http://www.facebook.com/feeds/page.php?format=rss20&id=322548597302', FILE_TEXT);
echo ($xmlData);

?>