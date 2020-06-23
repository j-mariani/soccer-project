<?php
    require 'config-files/admin-password.php';
    session_start();
    
    if ($_SERVER["REQUEST_METHOD"]== "POST"){

        $connect_string = "host=$dblocation dbname=$dbname user=admin password=". "'" . $adminpassword . "'";
        $dbconn = pg_connect($connect_string)
            or die('Could not connect: ' . pg_last_error());

        $usercreator = "user-creator";
        $dbconnuser = pg_connect("host=$dblocation dbname=$dbname user=$usercreator password=$usercreatorpassword")
            or die('Could not connect: ' . pg_last_error());

        $query = "set search_path to $schema_name";
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());
        
        $result = pg_query($dbconnuser, $query) 
            or die('Query failed: ' . pg_last_error());

        $username    =  pg_escape_string($dbconn,$_POST['username']);
        $password_1  =  pg_escape_string($dbconn,$_POST['password']);
        $password_2  =  pg_escape_string($dbconn,$_POST['password2']);
        $aValid = array('-', '_'); 

        if($username == 'lettore' || $username == 'operatore' || $username=='amministratore' || $username=='admin' || $username =='partner' || $username=='user-creator') {
            $_SESSION['failed-create-password']  = "Errore: nome utente non disponibile.";
            pg_free_result($result);
            pg_close($dbconn);
            pg_close($dbconnuser);
            if(isset($_POST['societa'])) {
                header('location: ../register-partner.php');
                die();
            }
            header('location: ../register.php');
            die();
        }
        $prep = pg_prepare($dbconn,"check_u","SELECT * from operatori where operatori.nome_utente=$1 union select * from amministratori where amministratori.nome_utente=$1 union select partner.nome_utente,partner.password from partner where partner.nome_utente=$1");
        
        if($prep != false) {
            $prep = pg_execute($dbconn,"check_u",array($username));
            if($prep == false) {
                $_SESSION['failed-create-password']  = "Errore generico.";
                pg_free_result($result);
                pg_free_result($prep);
                pg_close($dbconnuser);
                pg_close($dbconn);
                if(isset($_POST['societa'])) {
                    header('location: ../register-partner.php');
                    die();
                }
                header('location: ../register.php');
                die();
            }
            if(pg_num_rows($prep) > 0) {
                $_SESSION['failed-create-password']  = "Errore: nome utente già in uso.";
                pg_free_result($result);
                pg_free_result($prep);
                pg_close($dbconnuser);
                pg_close($dbconn);
                if(isset($_POST['societa'])) {
                    header('location: ../register-partner.php');
                    die();
                }
                header('location: ../register.php');
                die();
            }
        }
        else {
            $_SESSION['failed-create-password']  = "Errore: nome utente non disponibile.";
            pg_free_result($result);
            pg_free_result($prep);
            pg_close($dbconnuser);
            pg_close($dbconn);
            if(isset($_POST['societa'])) {
                header('location: ../register-partner.php');
                die();
            }
            header('location: ../register.php');
            die();
        }

        if(!ctype_alnum(str_replace($aValid, '', $username))) {
            $_SESSION['failed-create-password']  = "Errore: il nome utente può contenere solo _ , - , lettere e numeri.";
            pg_free_result($result);
            pg_free_result($prep);
            pg_close($dbconnuser);
            pg_close($dbconn);
            if(isset($_POST['societa'])) {
                header('location: ../register-partner.php');
                die();
            }
            header('location: ../register.php');
            die();
        }
        
        if ($password_1 == $password_2) {
            $password = hash('sha256',$password_1);

            if (isset($_POST['user_type'])) {
                $user_type = pg_escape_string($dbconn,$_POST['user_type']);
                $prep = false;
                if($user_type =='operatore') {
                    $prep = pg_prepare($dbconn,"insert_oa","INSERT INTO operatori (nome_utente,password) values ($1,$2)");
                }
                if($user_type =='amministratore'){
                    $prep = pg_prepare($dbconn,"insert_oa","INSERT INTO amministratori (nome_utente,password) values ($1,$2)");
                }
                if($prep != false) {
                    $prep = pg_execute($dbconn,"insert_oa",array($username,$password));
                    if($prep == false) {
                        $_SESSION['failed-create-password']  = "Errore generico.";
                        pg_free_result($result);
                        pg_free_result($prep);
                        pg_close($dbconnuser);
                        pg_close($dbconn);
                        if(isset($_POST['societa'])) {
                            header('location: ../register-partner.php');
                            die();
                        }
                        header('location: ../register.php');
                        die();
                    }
                }
                else {
                    $_SESSION['failed-create-password']  = "Errore generico.";
                    pg_free_result($result);
                    pg_free_result($prep);
                    pg_close($dbconnuser);
                    pg_close($dbconn);
                    if(isset($_POST['societa'])) {
                        header('location: ../register-partner.php');
                        die();
                    }
                    header('location: ../register.php');
                    die();
                }
            }
            else if(isset($_POST['societa'])) {
                $societa = pg_escape_string($dbconn,$_POST['societa']);
                $user_type= "partner";
                $prep = pg_prepare($dbconn,"insert_p","INSERT INTO partner (nome_utente,password,societa) values ($1,$2,$3)");
                if($prep != false) {
                    $prep = pg_execute($dbconn,"insert_p",array($username,$password,$societa));
                    if($prep == false) {
                        $_SESSION['failed-create-password']  = "Errore generico.";
                        pg_free_result($result);
                        pg_free_result($prep);
                        pg_close($dbconnuser);
                        pg_close($dbconn);
                        if(isset($_POST['societa'])) {
                            header('location: ../register-partner.php');
                            die();
                        }
                        header('location: ../register.php');
                        die();
                    }
                }
                else {
                    $_SESSION['failed-create-password']  = "Errore generico.";
                    pg_free_result($result);
                    pg_free_result($prep);
                    pg_close($dbconnuser);
                    pg_close($dbconn);
                    if(isset($_POST['societa'])) {
                        header('location: ../register-partner.php');
                        die();
                    }
                    header('location: ../register.php');
                    die();
                }
            }


            //create user problemi con pg_prepare
            $username = '"' . $username . '"';
            $query = "create user " . $username . " in role " . $user_type . " password '$password_1' " ;
            $result = pg_query($dbconnuser, $query);
            if($result == false) {
                $_SESSION['failed-create-password']  = "Errore generico.";
                pg_free_result($result);
                pg_free_result($prep);
                pg_close($dbconnuser);
                pg_close($dbconn);
                if(isset($_POST['societa'])) {
                    header('location: ../register-partner.php');
                    die();
                }
                header('location: ../register.php');
                die();
            }

            $_SESSION['success-create']  = "Nuovo utente creato!";
            pg_free_result($result);
            pg_free_result($prep);
            pg_close($dbconnuser);
            pg_close($dbconn);
            header('location: ../login.php');
            die();
        }
        else {
            $_SESSION['failed-create-password']  = "Errore: le password sono differenti.";
            pg_free_result($result);
            pg_free_result($prep);
            pg_close($dbconnuser);
            pg_close($dbconn);
            header('location: ../register.php');
            die();
        }
    }
    else {
        header('location: ../index.php');
        die();
    }
?>