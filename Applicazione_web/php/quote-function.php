<?php
    require 'config-files/admin-password.php';
    session_start();
    setlocale(LC_CTYPE, "en_US.UTF-8"); //fix per l' escape
    if($_SERVER["REQUEST_METHOD"]=="POST") {
        $connect_string = "host=$dblocation dbname=$dbname user=admin password=". "'" . $adminpassword . "'";
        $dbconnadmin = pg_connect($connect_string)
        or die('Could not connect: ' . pg_last_error());
    
        $query = "set search_path to $schema_name";
        $result = pg_query($dbconnadmin, $query) 
            or die('Query failed: ' . pg_last_error());

        $password = pg_escape_string($dbconnadmin, $_POST['password']);
        $user = $_SESSION['user'];

        $connect_string="host=$dblocation dbname=$dbname user=". $user ." password=" . "'" . $password . "'";
        $dbconn = pg_connect($connect_string)
            or die('Could not connect: ' . pg_last_error());

        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());

        $id = $_POST['id'];
        $value = $_POST['valore'];
        $type = $_POST['tipo'];
        $prep = pg_prepare($dbconn,"insert_q","INSERT INTO quote(incontro_id,vittoria,valore) values ($1,$2,$3)");
        if($prep != false) {
            $prep = pg_execute($dbconn, "insert_q", array($id,$type,$value));
            if($prep == false) {
                $_SESSION['failed-same-tipo']  = "Errore generico.";
                pg_free_result($result);
                pg_free_result($prep);
                pg_close($dbconn);
                pg_close($dbconnadmin);
                header('location: ../quote-insert.php');
                die();
            }
        }

        pg_free_result($result);
        pg_free_result($prep);
        
        pg_close($dbconnadmin);

        pg_close($dbconn); 
            
        $_SESSION['success-insert-quote'] = "Quota inserita.";
        header('location: ../quote-insert.php');
        die();
    }
    else {
        header('location: ../index.php');
        die();
    }
?>