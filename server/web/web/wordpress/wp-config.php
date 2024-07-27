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
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'password' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

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
define( 'AUTH_KEY',         '%8fRli)N[wc2+a)^<oBPd=Q82.8dxF%{MRu2(fQSNEbi mwN6odf4{z1Nu?o^vOO' );
define( 'SECURE_AUTH_KEY',  '$ZCB>s_Q<y]BSPoW[b0hdS:!JMwE|~|[@H)K7qMihCDEY7 sNV$?h/)B9,.Cbe&#' );
define( 'LOGGED_IN_KEY',    'a7}ZETf.YL!lqYa$?(@ rW>ny(o/*_LZ5O.#p}R$Ain^g3WQ#b3c`k?`%yAciQQT' );
define( 'NONCE_KEY',        'PAsBGMMkt.Q>ws7|8+X?bwqRtj+!}5am,k}%9$OZIhBEYH<;VaWV0@I1O.z0i,u%' );
define( 'AUTH_SALT',        'Z?.nPqdTVg1gngUdtM9`U&sSpLv}uNZbB+;Ja>z%wINsgCNg-91VPQ10A//fw1k8' );
define( 'SECURE_AUTH_SALT', '0#5ui[v5MQmV|xmA?#2Z{W%GUYcZ|Qlr<-8vcDJYRMcUvp@x!)FJLtts%fM|{$nl' );
define( 'LOGGED_IN_SALT',   'N;7!bEC@VEQ-0:z[T3RDpg/Q+ 9:s$qh*KF~8n54s&2TxR`9 UDV7mWUmjqix4X7' );
define( 'NONCE_SALT',       '6;fiX$>+~g6iWa8/+PjJtAMq:7y!k.9B#KE?~;+Uo9w$|=c]rM5P&rSek:NXk&YL' );

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
