<?php
$connectionName = getenv('CLOUD_SQL_CONNECTION_NAME');
$host = getenv('DB_HOST');
$db   = getenv('DB_NAME');
$user = getenv('DB_USER');
$pass = getenv('DB_PASSWORD');

#$dsn = "mysql:dbname=$db;host=$host";
#try {
#    $pdo = new PDO($dsn, $user, $pass);
#    echo "Connected to database successfully!";
#} catch (PDOException $e) {
#    echo "Connection failed: " . $e->getMessage();
#}

#$dsn = "mysql:host=$host;dbname=$db;charset=utf8mb4";
#$pdo = new PDO($dsn, $user, $pass);


$socket = "/cloudsql/$connectionName";

try {
    $dsn = "mysql:unix_socket=$socket;dbname=$db;charset=utf8mb4";
    $pdo = new PDO($dsn, $user, $pass);

    echo "Connected to database successfully!";
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}
?>
