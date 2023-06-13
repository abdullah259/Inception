cd /var/www/html/wordpress

sed -i 's/listen = .*/listen = 0.0.0.0:9000/g' /etc/php/7.3/fpm/pool.d/www/conf

if [ ! -f "/var/www/html/wordpress/wp-content/wp-config.php" ]; then

# Download wordpress files
wp core download  --path="/var/www/html/wordpress" --allow-root

# Generate and configure the wp-config.php file
wp config create --path="/var/www/html/wordpress" --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USERPASS --dbhost=$DB_HOSTNAME --dbprefix=wp_

# Runs the standard wordpress installation process - create the wordpress tables in db
wp core install --path="/var/www/html/wordpress" --allow-root --url=$DOMAIN --title="$WORDPRESS_DB_TITLE" --admin_user=$WORDPRESS_DB_ADMIN --admin_password=$WORDPRESS_DB_ADMIN_PASSWORD --admin_email=$WORDPRESS_DB_ADMIN_EMAIL


# REDIS CACHE
wp config set WP_CACHE true --allow-root
wp config set WP_CACHE_KEY_SALT $DOMAIN --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp config set WP_REDIS_DATABASE 0 --allow-root

wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root

# Create user in wordpress
wp plugin update --allow-root --all
wp user create --path="/var/www/html/wordpress" --allow-root $WORDPRESS_DB_USER $WORDPRESS_DB_USER_EMAIL --user_pass=$WORDPRESS_DB_USER_PASSWORD
# Activate the theme
# wp theme install $WORDPRESS_THEME --activate --allow-root
# wp --allow-root theme install "ExS Dark" 
# wp --allow-root theme activate "exs-dark"
chown -R www-data:www-data /var/www/html/
chmod -R 775 /var/www/html
echo "WordPress has been successfully installed."
# Activate the plugins
wp plugin update --allow-root --all

else
  echo "WordPress is already configured"
fi


# launch php-fpm
mkdir -p /run/php/
php-fpm7.3 -F