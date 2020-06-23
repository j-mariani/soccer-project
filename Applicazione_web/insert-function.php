<!doctype html>
<html lang="it">
    <head>
        <title>Giocatori e campionati</title>
        <!-- Required meta tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="./CSS/node_modules/bootstrap/dist/css/bootstrap.css">
    </head>
    <body>
        <?php
            require 'php/config-files/admin-password.php';
            session_start();
            if (isset($_SESSION['user'])) {
                if($_SESSION['user_type']!='operatore') {
                    header('location: index.php');
                    die();
                }
            }
            else
            {
                header('location: login.php');
                die();
            }
            setlocale(LC_CTYPE, "en_US.UTF-8"); //fix per l' escape
            if($_SERVER["REQUEST_METHOD"]=="POST") {
                $dbconnlettore = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
                    or die('Could not connect: ' . pg_last_error());
                
                $query = "set search_path to $schema_name";
                $result = pg_query($dbconnlettore, $query) 
                    or die('Query failed: ' . pg_last_error());
            
                $password = pg_escape_string($dbconnlettore, $_POST['password']);
                $user = $_SESSION['user'];

                $connect_string="host=$dblocation dbname=$dbname user=". $user ." password=". "'" . $password . "'";
                $dbconn = pg_connect($connect_string)
                    or die('Could not connect: ' . pg_last_error());

                $_SESSION['connect-string'] = $connect_string;
                $query = "set search_path to $schema_name";
                $result = pg_query($dbconn, $query) 
                    or die('Query failed: ' . pg_last_error());

                $id = pg_escape_string($dbconn,$_POST['id']);
                $data = $_POST['date'] . ' ' . $_POST['time'];
                $flag = false;
                if(strpos($data,'/') == false) {
                    $flag = true;
                }
                if(strpos($data,':') == false) {
                    $flag = true;
                }
                if(strlen($data) != 19) {
                    if(strlen($data) != 16) {
                        $flag = true;
                    }
                }
                if($flag) {
                    $_SESSION['failed-same-team'] = "Data o ora in formato errato.";
                    pg_free_result($result);
                    pg_close($dbconn);
                    pg_close($dbconnlettore);
                    header('location: match-insert.php');
                    die();
                }
                $data = pg_escape_string($dbconn,$data);
                $squadra_casa = pg_escape_string($dbconn,$_POST['squadra_casa']);
                $goal_casa = pg_escape_string($dbconn,$_POST['goal_casa']);
                $squadra_trasferta = pg_escape_string($dbconn,$_POST['squadra_trasferta']);
                $goal_trasferta = pg_escape_string($dbconn,$_POST['goal_trasferta']);
                $lega = pg_escape_string($dbconn,$_POST['lega']);
                if($squadra_casa != $squadra_trasferta)
                {
                    $prep = pg_prepare($dbconn,"insert_m","INSERT INTO incontri(id,data,goal_casa,goal_trasferta,lega,squadra_casa,squadra_trasferta) values ($1,$2,$3,$4,$5,$6,$7)");
                    if($prep != false) {
                        $prep = pg_execute($dbconn,"insert_m",array($id,$data,$goal_casa,$goal_trasferta,$lega,$squadra_casa,$squadra_trasferta));
                        if($prep == false) {
                            $_SESSION['failed-same-team'] = "Errore generico.";
                            pg_free_result($result);
                            pg_free_result($prep);
                            pg_close($dbconn);
                            pg_close($dbconnlettore);
                            header('location: match-insert.php');
                            die();
                        }
                    }

                    echo "<i style='color: orange'>Match $id inserito, aggiungere giornata di campionato e giocatori (facoltativo).</i>";
                    $_SESSION['match-id-last-inserted'] = $id;
                }
                else {
                    $_SESSION['failed-same-team'] = "Inserire squadre diverse.";
                    pg_free_result($result);
                    pg_close($dbconn);
                    pg_close($dbconnlettore);
                    header('location: match-insert.php');
                    die();
                }

                echo '<form action="php/insert-function2.php" method="post">';
                echo "<table class='table table-hover'>\n";
                echo "\t<tr>\n";
                echo "\t\t<td>Giocatori squadra casa</td>\n";
                echo "\t\t<td>Giocatori squadra trasferta</td>\n";
                echo "\t</tr>\n";
                echo "\t<tr>\n";
                echo "\t\t<td>";

                $prep = pg_prepare($dbconnlettore,"select_s","select g.id,nome from giocatori_squadra($1) as g join giocatori on g.id=giocatori.id");
                if($prep != false) {
                    $prep = pg_execute($dbconnlettore,"select_s",array($squadra_casa))
                        or die('Query failed: ' . pg_last_error());
                }

                $players = pg_fetch_all($prep,PGSQL_NUM);

                echo"<select multiple name='giocatori-squadra-casa[]'>";
                echo"<option value='' disabled selected hidden>Giocatori</option>";
                foreach ($players as $col_value) {
                        echo "<option value='$col_value[0]'>$col_value[1]</option>";
                }
                echo'</select>';
                echo'<br>';

                echo '</td>';
                echo "\t\t<td>";

                if($prep != false) {
                    $prep = pg_execute($dbconnlettore,"select_s",array($squadra_trasferta))
                        or die('Query failed: ' . pg_last_error());
                }


                $players = pg_fetch_all($prep,PGSQL_NUM);

                echo"<select multiple name='giocatori-squadra-trasferta[]'>";
                echo"<option value='' disabled selected hidden>Giocatori</option>";
                foreach ($players as $col_value) {
                        echo "<option value='$col_value[0]'>$col_value[1]</option>";
                }
                echo'</select>';
                echo'<br>';

                echo '</td>';
                echo "\t</tr>\n";

                echo "</table>\n";
                echo'<input type="submit" value="Inserisci incontro" />';
                echo'</form>';

                
                pg_free_result($result);
                pg_free_result($prep);
                
                pg_close($dbconnlettore);

                pg_close($dbconn); 
                
            }
            else {
                header('location: index.php');
                die();
            }
        ?>
        <br>
        <a class="btn btn-primary" href="match-insert.php" role="button"> Torna all' inserimento di incontri</a>
    </body>

</html>