<?php
	define("DB_NAME",				getenv("DB_NAME"));
	define("DB_USER",				getenv("DB_USER"));
	define("DB_PASSWORD",			getenv("DB_PASSWORD"));
	define("DB_HOST",				getenv("DB_HOST") . ":3306");
	define("DB_CHARSET",			getenv("DB_CHARSET"));
	define("DB_COLLATE",			getenv("DB_COLLATE"));

	define('AUTH_KEY',         'F#g; =~>/wffn-P&N@0fhs^@-sA,TZNQHX(J>!g]?FuA#uXgrshZGN}-QISz)c2K');
	define('SECURE_AUTH_KEY',  'int [y_~z^Fc+fbhE`l]Yf=hn(-3:HV:9-C?woby.JF#hmCXln^}MU?y~7Gn:QP5');
	define('LOGGED_IN_KEY',    'ViLQh+7fGKJ|P-@Z=+Pt|G,uVaDqkG8S5?=L:%dtVR|okgP`w<peSDd>lWXZm-_2');
	define('NONCE_KEY',        ')P-?]]d:gi,,l#r];Wroz>$jq+/+2%d}pjtfje]t{om#~TorOp=i]v;yi# MM|;/');
	define('AUTH_SALT',        '!?Av7<^.}BVj$d&_-eLK(~8R;`.!<|pimKgF%2|`x0ZF|=q</D_ZvJ+oLLZ@>L-m');
	define('SECURE_AUTH_SALT', '$e[-:~bEXfqHUBD,PA!=[xH.2SOBlN1v@~YZmVYMr?pxI1D]Sigl]0u:YW>8hj?Y');
	define('LOGGED_IN_SALT',   'Dou:P8f2o=2cy4r|Oe8f+_1KTEM`{kJ$jf1[kJldN2)Oc$i;0&Z!w#u8F[o9G*/L');
	define('NONCE_SALT',       '#KCLy-Hub jb2:m4=$t~&TP}wqV&yn2Mv]Ku QIS2DBAj2X2$/|4lfS_h}{]5*uM');
	define("CONCATENATE_SCRIPTS",	false);

	$table_prefix =					getenv("WP_TABLE_PREFIX");

	define("WP_DEBUG", true);
	if (!defined("ABSPATH"))
		define("ABSPATH", __DIR__ . "/");

	require_once ABSPATH . "wp-settings.php";