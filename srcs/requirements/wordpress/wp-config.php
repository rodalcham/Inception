<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'db1' );

/** MySQL database username */
define( 'DB_USER', 'user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'pwd' );

/** MySQL hostname */
define( 'DB_HOST', 'mariadb' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define( 'WP_ALLOW_REPAIR', true );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '*Z>M*0!Yle>Q<|N*%=Dm*/.RniMhm:bNHk8#/]0]E.[p`:_nBqr+OB5H]EYq=*e;');
define('SECURE_AUTH_KEY',  'iVNZH->Csm+07tJ!X4Meq2yD6%go|CiRJ x6vP[5g]Ilt5A@G&.Ic<GhrJ#$A,Kf');
define('LOGGED_IN_KEY',    'd+7SS{,xUX4|]s4mUolH#w@&yVKB+AUu+e*wo_i7bR}WRcW *pO#(.*$:Z5J]C^<');
define('NONCE_KEY',        'p-Ac+2+f)vNSNJhFc6}|O?]fQ[J5M]orfAL2BriNwx<I+[7Ka^_PygckozX ~T,7');
define('AUTH_SALT',        '<9&[&]AJ!>((dz?;RIvRn$iM[b!?md5DkS3+Evu`xZ:e{HizAs~2zVdwbXyK;wzA');
define('SECURE_AUTH_SALT', '3&80AI50+3b-f*/mWGS:|_$6cYO-Q--JGN@ CzGv5s%U+vxCTBCUJ^`.f~=Rt[@O');
define('LOGGED_IN_SALT',   'Z=F]B@xq!j:zq656h7*yM%EYMs6mu`wF]2w{ML2v<#UWmaHz|uJg^_t*i)K:TGu,');
define('NONCE_SALT',       'JJjqU:Xq3e!u1UmBL0hA)ur`?M((a-n.tRdPb,Tu^y*7L.1+jWPrPEG%sk6Wxb(x');

// define( 'WP_REDIS_HOST', 'redis' );
// define( 'WP_REDIS_PORT', 6379 );     


define('WP_CACHE', true);

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
// define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>