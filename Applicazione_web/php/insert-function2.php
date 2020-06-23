<?php
    require 'config-files/admin-password.php';
    session_start();
    setlocale(LC_CTYPE, "en_US.UTF-8"); //fix per l' escape
    if($_SERVER["REQUEST_METHOD"]=="POST") {
        
        $dbconn = pg_connect($_SESSION['connect-string'])
            or die('Could not connect: ' . pg_last_error());

        $query = "set search_path to $schema_name";
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());


        if(isset($_POST['giocatori-squadra-casa'])) {
            $s_casa = $_POST['giocatori-squadra-casa'];
            $prep = pg_prepare($dbconn,"insert","insert into gioca(incontro_id,giocatore_id,posizione) values ($1,$2,'casa')");
            foreach($s_casa as $value) {
                if($prep != false) {
                    $prep= pg_execute($dbconn,"insert",array($_SESSION['match-id-last-inserted'],$value));
                    if ($prep == false) {
                        $_SESSION['failed-same-team'] = "Errore inserimento dentro tabella gioca.";
                        pg_free_result($result);
                        pg_free_result($prep);
                        pg_close($dbconn);
                        header('location: ../match-insert.php');
                        die();
                    }
                }

            }
        }

        if(isset($_POST['giocatori-squadra-trasferta'])) {
            $s_trasferta = $_POST['giocatori-squadra-trasferta'];
            $prep = pg_prepare($dbconn,"insert2","insert into gioca(incontro_id,giocatore_id,posizione) values ($1,$2,'trasferta')");
            foreach($s_trasferta as $value) {
                if($prep != false) {
                    $prep= pg_execute($dbconn,"insert2",array($_SESSION['match-id-last-inserted'],$value));
                    if ($prep == false) {
                        $_SESSION['failed-same-team'] = "Errore inserimento dentro tabella gioca.";
                        pg_free_result($result);
                        pg_free_result($prep);
                        pg_close($dbconn);
                        header('location: ../match-insert.php');
                        die();
                    }
                }

            }
        }


        $_SESSION['success-insert-match'] = "Match " . $_SESSION['match-id-last-inserted'] . " correttamente inserito.";
        pg_free_result($result);
        pg_free_result($prep);

        pg_close($dbconn); 
        
        header('location: ../match-insert.php');
        die();
    }
    else {
        header('location: ../index.php');
        die();
    }
?>