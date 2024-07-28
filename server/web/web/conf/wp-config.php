<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'admin' );

/** Database password */
define( 'DB_PASSWORD', 'passwd' );

/** Database hostname */
define( 'DB_HOST', '192.168.1.3' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'VQ`T:~^incq%/J9i@I8l%^Rt9e{eYF#n:SUnQT|_`IdMLxi93E{=tTv;h3ih1vY8' );
define( 'SECURE_AUTH_KEY',  'k}2hfF+eXeT)s4oo:i4BBU~lg%ro05#{/oK8E{Ct5~x3*OYQ7IJY={FGqpf;o#Lt' );
define( 'LOGGED_IN_KEY',    'e>W9FX%NkFs_&U_tNN8VSFt~4eAe2y_x(Nkx{3~qpzv<sJ>QQf9,<d|dn;]h!VoF' );
define( 'NONCE_KEY',        'HeO.9F%mmCa*75e42$~-&`j|VBisiI~C.rU3B[-)Q}z~x#)CtJhcRR-:Pe-$KP!G' );
define( 'AUTH_SALT',        'wTv9/k5-fR1xVSQgsq^zmL3nDTz/(t_C@!@ su5!{23x^O]B|_XM(W8.;7weIz$i' );
define( 'SECURE_AUTH_SALT', '}|!23WA7zeL7kI:`k(PWH^$81WM(*1vT(bVIZ/ZM9z)^FkFr^u1,t73s_Q/{,xw@' );
define( 'LOGGED_IN_SALT',   'rarc]h?wPcN3#kB$j{d(}BXq(0-nI21ej)?wJX;mmr1uYlZt&OV*d% 6IjF|Zy(e' );
define( 'NONCE_SALT',       ': 2Q[?DJ s@|Z(_X/MU0<eyMFuf,GyP;lfW$Xx1?[]]Mt3a{wkmyC$55gZ Y!YZm' );

/**#@-*/

/**
 * WordPress database table prefix.
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
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';