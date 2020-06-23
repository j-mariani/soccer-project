<!doctype html>
<html lang="it">
    <head>
        <title>Inserimento incontro</title>
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
        unset($_SESSION['connect-string']);
        unset($_SESSION['match-id-last-inserted']);
        $dbconn = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
            or die('Could not connect: ' . pg_last_error());
        
        $query = "set search_path to $schema_name";
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());

        $query = 'SELECT id FROM incontri ORDER BY id DESC';
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error()); 
               
        $row = pg_fetch_row($result);
        $new_id = $row[0]+1;
        echo '<form action="insert-function.php" method="post">';
        echo "<table class='table table-hover'>\n";
        echo "\t<tr>\n";
        echo "\t\t<td>Id incontro</td>\n";
        echo "\t\t<td>Squadra casa</td>\n";
        echo "\t\t<td>Goal squadra casa</td>\n";
        echo "\t\t<td>Squadra trasferta</td>\n";
        echo "\t\t<td>Goal squadra trasferta</td>\n";

        echo "\t</tr>\n";
        echo "\t<tr>\n";

        echo "\t\t<td><input type='number' name='id' placeholder='prossimo id: $new_id' required></td>\n";


    
        echo "\t\t<td>";
        echo'<select name="squadra_casa" required>';
        echo'<option value="" disabled selected hidden>Squadra casa</option>';
        $query = 'SELECT nome_lungo,id FROM squadre';
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());

        while ($col_value = pg_fetch_row($result)) {
            echo "<option value='$col_value[1]'>$col_value[0]</option>";
        }
        echo'</select>';
        echo '</td>';

        echo "\t\t<td>";
        echo'<input type="number" name="goal_casa" required>';
        echo '</td>';

        echo "\t\t<td>";
        echo'<select name="squadra_trasferta" required>';
        echo'<option value="" disabled selected hidden>Squadra trasferta</option>';
        $query = 'SELECT nome_lungo,id FROM squadre';
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());
        while ($col_value = pg_fetch_row($result)) {
                echo "<option value='$col_value[1]'>$col_value[0]</option>";
        }
        echo'</select>';
        echo '</td>';

        echo "\t\t<td>";
        echo'<input type="number" name="goal_trasferta" required>';
        echo '</td>';


        
        echo "\t</tr>\n";
        echo "</table>\n";
        echo "<table class='table table-hover'>\n";
        echo "\t<tr>\n";
        echo "\t\t<td>Lega</td>\n";
        echo "\t\t<td>Data</td>\n";
        echo "\t\t<td>Ora</td>\n";
        echo "\t</tr>\n";
        echo "\t<tr>\n";
        echo "\t\t<td>";
        echo'<select name="lega" required>';
        echo'<option value="" disabled selected hidden>Lega</option>';
        $query = 'SELECT nome FROM leghe';
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());
        while ($line = pg_fetch_array($result, null, PGSQL_NUM)) {
            foreach ($line as $col_value) {
                echo "<option value='$col_value'>$col_value</option>";
            }
        }
        echo'</select>';
        echo '</td>';
        echo "\t\t<td>";
        echo'<input class="date" type="text" name="date" placeholder="gg/mm/aaaa" required>';
        echo '</td>';
        echo "\t\t<td>";
        echo'<input class="time" type="text" name="time" placeholder="oo:mm:ss" required>'; 
        echo '</td>';

        echo "\t</tr>\n";
        echo "</table>\n";
        echo'<h6>Inserisci la password per confermare: </h6>';
        echo'<input type="password" name="password"> <br><br>';
        echo'<input type="submit" value="Inserisci incontro" />';
        echo'</form>';
                
        pg_free_result($result);
        
        pg_close($dbconn);

        
        ?>
        <?php if(isset($_SESSION['success-insert-match'])) : ?>
            <i style="color: green">
                <?php echo $_SESSION['success-insert-match'];
                    unset($_SESSION['success-insert-match']);
                ?>
			</i>
        <?php endif?>
        <?php if(isset($_SESSION['failed-same-team'])) : ?>
            <i style="color: red">
                <?php echo $_SESSION['failed-same-team'];
                    unset($_SESSION['failed-same-team']);
                ?>
			</i>
        <?php endif?>
        <br>
        <a href="index.php">Torna all'homepage</a>
    </body>
</html>