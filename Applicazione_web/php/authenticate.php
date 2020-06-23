<?php
    require 'config-files/admin-password.php';
    session_start();
    if($_SERVER["REQUEST_METHOD"]== "POST") {

        $connect_string = "host=$dblocation dbname=$dbname user=admin password=". "'" . $adminpassword . "'";
        $dbconn = pg_connect($connect_string)
            or die('Could not connect: ' . pg_last_error());
        
        $query = "set search_path to $schema_name";
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());


        $user = $_POST['username'];
        $password_hash = hash('sha256',$_POST['password']);

        if (isset($_POST['user_type'])) {
            $user_type=pg_escape_string($dbconn,$_POST['user_type']);
            if($user_type =='operatore')
                $prep = pg_prepare($dbconn,"my_query",'select * from operatori where nome_utente= $1 and password= $2');
            if($user_type =='amministratore')
                $prep = pg_prepare($dbconn,"my_query",'select * from amministratori where nome_utente= $1 and password= $2');
            if($user_type =='partner')
                $prep = pg_prepare($dbconn,"my_query",'select * from partner where nome_utente= $1 and password= $2');
            
            
            if($prep != false) {
                $prep = pg_execute($dbconn,"my_query",array($user,$password_hash))
                    or die('Query failed: ' . pg_last_error());
            }



            if(pg_num_rows($prep) == 1) {
                pg_free_result($prep);
                pg_free_result($result);
                pg_close($dbconn);
                $_SESSION['user'] = $user;
                $_SESSION['user_type'] = $user_type;
                $_SESSION['success-login'] = "Benvenuto ";
                header("location: ../index.php");
                die();
            }
            else {
                pg_free_result($prep);
                pg_free_result($result);
                pg_close($dbconn);
                $_SESSION['failed-login'] = "Nome utente o password errata.";
                header("location: ../login.php");
                die();
            }
        }



    }
    else {
        header('location: ../index.php');
        die();
    }
?>