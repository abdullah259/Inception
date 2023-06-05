<?php
define('DB_NAME', 'your_database_name');
define('DB_USER', 'your_database_user');
define('DB_PASSWORD', 'your_database_password');
define('DB_HOST', 'your_database_host');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY', 'your_unique_key');
define('SECURE_AUTH_KEY', 'your_unique_key');
define('LOGGED_IN_KEY', 'your_unique_key');
define('NONCE_KEY', 'your_unique_key');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
