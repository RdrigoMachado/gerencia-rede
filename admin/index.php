<?php
$userType = isset($_SERVER['HTTP_USER_TYPE']) ? $_SERVER['HTTP_USER_TYPE'] : 'default_user_type';
$userName = isset($_SERVER['HTTP_USER_NAME']) ? $_SERVER['HTTP_USER_NAME'] : 'default_user_name';
echo "Bem vindo, $userName. Seu tipo de acesso: $userType";
?>

