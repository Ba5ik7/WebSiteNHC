<?php

	$file = $_POST['fileName'];
	ini_set('user_agent', 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3');
	echo file_get_contents($file);

?>