<?php
    require 'config-files/admin-password.php';
    session_start();
    setlocale(LC_CTYPE, "en_US.UTF-8"); //fix per l' escape
    //controllo di avere un file
    if((!empty($_FILES["uploaded_file"])) && ($_FILES['uploaded_file']['error'] == 0)) {

    $filename = basename($_FILES['uploaded_file']['name']);    //controllo se il file è corretto
    $ext = substr($filename, strrpos($filename, '.') + 1); //ottengo la estensione
    $name = pathinfo($filename)['filename'];
        if (($ext == "csv") && ($_FILES["uploaded_file"]["type"] == "text/csv") && 
            ($_FILES["uploaded_file"]["size"] < 1000000) && (($name == "match") || ($name == "player_attribute"))) {

            $file_path = $_FILES['uploaded_file']['tmp_name'];
            $file_path_esc = escapeshellarg($file_path);
            $name_esc = escapeshellarg($name);
            $sh_string = $path_to_python3 . " ../Python/csv_to_table.py $file_path_esc $name_esc";
            passthru($sh_string);
            $output = null;
            $sh_string = $path_to_cmp . " 2$name_esc.sql ../Python/$name_esc.sql";
            passthru($sh_string,$output);
            if(empty($output)){
                //file corretto, gestire import nel database
                $connect_string = "host=$dblocation dbname=$dbname user=admin password=". "'" . $adminpassword . "'";
                $dbconnadmin = pg_connect($connect_string)
                    or die('Could not connect: ' . pg_last_error());
                
                $password = pg_escape_string($dbconnadmin,$_POST['password']);

                $connect_string="host=$dblocation dbname=$dbname user=" . $_SESSION['user'] . " password=". "'" . $password . "'";
                $dbconn = pg_connect($connect_string)
                    or die('Could not connect: ' . pg_last_error());
    
                $query = "set search_path to $schema_name";
                $result = pg_query($dbconn, $query) 
                    or die('Query failed: ' . pg_last_error());
                $result = pg_query($dbconnadmin, $query) 
                    or die('Query failed: ' . pg_last_error());
                if($name == "match") {
                    $table_name = "incontri";
                }
                else if($name == "player_attribute") {
                    $table_name = "letture_attributi_giocatori";
                }
                $query = "select * from $table_name";
                $result = pg_query($dbconnadmin, $query) 
                        or die('Query failed: ' . pg_last_error());
                $number_lines = pg_num_rows($result);

                $file_path_esc = pg_escape_literal($dbconn,$file_path);
                $query = "copy $name from $file_path_esc delimiter ',' CSV HEADER";
                $result = pg_query($dbconn, $query);
                if($result == false) {
                    $_SESSION['error-csv'] = "Errore generico.";
                    pg_free_result($result);
                    pg_close($dbconn);
                    pg_close($dbconnadmin);
                    header('location: ../index.php');
                    die();
                }
                
                $query = "select * from $table_name";
                $result = pg_query($dbconnadmin, $query) 
                    or die('Query failed: ' . pg_last_error());
                $number_lines_2 = pg_num_rows($result);    
                    
                pg_free_result($result);
        
                pg_close($dbconn);  
                pg_close($dbconnadmin); 
                if($number_lines != $number_lines_2) {
                    $_SESSION['success-upload-csv'] = "File correttamente importato.";
                }
                else {
                    $_SESSION['double-upload-csv'] = "File con chiavi già presenti nel database";
                }
                passthru("/bin/rm 2$name.sql");
                header('location: ../index.php');
                die();
            }
            else {
                $_SESSION['error-csv'] = "Il file $name è in un formato diverso da quello presente sul server.";
                passthru("/bin/rm 2$name.sql");
                pg_free_result($result);
                pg_close($dbconn);
                pg_close($dbconnadmin);
                header('location: ../index.php');
                die();
            }
        } 
        else {
            $_SESSION['error-csv'] = "Errore: Solo file match.csv e player_attributes.csv grandi meno di 1MB sono accettati per l'upload.";
            header('location: ../index.php');
            die();
        }
    } 
    else {
        $_SESSION['error-csv'] = "Errore: upload fallito.";
        header('location: ../index.php');
        die();
    }
    header('location: ../index.php');
    die();
?>