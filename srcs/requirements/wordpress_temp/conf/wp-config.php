<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'wp_user');
define('DB_PASSWORD', getenv('DB_PASSWORD'));  // Retrieve password from environment
define('DB_HOST', 'mariadb');
define('DB_CHARSET', 'utf8');

$table_prefix = 'wp_';

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
