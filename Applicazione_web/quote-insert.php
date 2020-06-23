<!doctype html>
<html lang="it">
    <head>
        <title>Inserimento quota</title>
        <!-- Required meta tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./CSS/node_modules/bootstrap/dist/css/bootstrap.css">

    </head>
        <?php
        require 'php/config-files/admin-password.php';
        session_start();
        $dbconn = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
            or die('Could not connect: ' . pg_last_error());
        
        $query = "set search_path to $schema_name";
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());
        echo'<body>';
        echo '<form action="php/quote-function.php" method="post">';
        echo "<table class='table table-hover'>\n";
        echo "\t<tr>\n";
        echo "\t\t<td>Incontro</td>\n";
        echo "\t\t<td>Valore</td>\n";
        echo "\t\t<td>Tipo</td>\n";

        echo "\t</tr>\n";
        echo "\t<tr>\n";
        
        echo "\t\t<td style='width:550px;'>";
        $query = "select incontri.id,s1.nome_lungo as squadra_casa,s2.nome_lungo as squadra_trasferta,data from incontri join squadre as s1 on squadra_casa = s1.id join squadre as s2 on squadra_trasferta = s2.id order by data";
        $result = pg_query($dbconn, $query) 
            or die('Query failed: ' . pg_last_error());

        echo"<select name='id' required>";
        echo "<option value='' selected disabled hidden>Seleziona un incontro</option>";
        while ($line2 = pg_fetch_row($result, null, PGSQL_NUM)) {
            $date_c = substr($line2[3],0,10);
            echo "<option value='$line2[0]'>$date_c || $line2[1] vs $line2[2]</option>";
        }
        echo "</select>";
        echo '</td>';
        echo "\t\t<td style='width:300px;'>";
        echo '<input type="number" name="valore" required step="0.01">';
        echo '</td>';

        echo "\t\t<td>";
        echo '<input type="radio" name="tipo" value="casa" required> Casa<br>';
        echo '<input type="radio" name="tipo" value="trasferta" required> Trasferta<br>';
        echo '<input type="radio" name="tipo" value="pareggio" required> Pareggio';

        echo '</td>';

        echo "\t</tr>\n";
        
        echo "</table>\n";
        echo'<h6>Inserisci la password per confermare: </h6>';
        echo'<input type="password" name="password"> <br><br>';
        echo'<input type="submit" value="Inserisci quota" />';
        echo'</form>';
                
        pg_free_result($result);
        
        pg_close($dbconn);

        
        ?>
        <?php if(isset($_SESSION['success-insert-quote'])) : ?>
            <i style="color: green">
                <?php echo $_SESSION['success-insert-quote'];
                    unset($_SESSION['success-insert-quote']);
                ?>
			</i>
        <?php endif?>
        <?php if(isset($_SESSION['failed-same-tipo'])) : ?>
            <i style="color: red">
                <?php echo $_SESSION['failed-same-tipo'];
                    unset($_SESSION['failed-same-tipo']);
                ?>
			</i>
        <?php endif?>
        <br>
        <a href="index.php">Torna all'homepage</a>
    </body>
</html>