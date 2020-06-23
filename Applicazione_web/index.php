<!doctype html>
<html lang="it">
	<head>
		<title> Pagina iniziale </title>
		<!-- Required meta tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="./CSS/node_modules/bootstrap/dist/css/bootstrap.css">

	</head>
	<?php 
		session_start();
		require 'php/config-files/admin-password.php';

		if (isset($_GET['logout'])) {
			session_destroy();
			header("location: index.php");
			die();
		}



	?>
	<body>

		<div class="header">
			<h2>Home Page</h2>
		</div>
		<div class="content">
			<!-- logged in user information -->
			<div class="profile_info">
				
				<div>
						<?php  if (isset($_SESSION['user'])) {
							echo "Benvenuto, <strong>";
							echo $_SESSION['user'];
							echo "</strong>";
							echo"<small>";
							echo" <a href='index.php?logout='1'' style='color: red;'>(logout?)</a>";
							echo"</small> <br> ";
						}
						?>
						<?php  if (isset($_SESSION['user']) && $_SESSION['user_type']=='amministratore') : ?>
						<a href="file-upload.php">Caricamento csv</a><br><br>
							<?php  if (isset($_SESSION['success-upload-csv'])) : ?>
								<br><i style="color: green">
								<?php echo $_SESSION['success-upload-csv'] . "<br>";
									unset($_SESSION['success-upload-csv']);
								?>
								</i>
							<?php endif ?>
							<?php  if (isset($_SESSION['double-upload-csv'])) : ?>
								<br><i style="color: orange">
								<?php echo $_SESSION['double-upload-csv'] . "<br>";
									unset($_SESSION['double-upload-csv']);
								?>
								</i>
							<?php endif ?>
							<?php  if (isset($_SESSION['error-csv'])) : ?>
								<br><i style="color: red">
								<?php echo $_SESSION['error-csv'] . "<br>";
									unset($_SESSION['error-csv']);
								?>
								</i>
							<?php endif ?>
						<?php endif ?>
						<?php  if (isset($_SESSION['user']) && $_SESSION['user_type']=='operatore') : ?>
							<a href="match-insert.php">Inserimento nuovo incontro</a><br><br>
						<?php endif ?>
						<?php  if (isset($_SESSION['user']) && $_SESSION['user_type']=='partner') : ?>
							<a href="quote-insert.php">Insertimento nuova quota</a><br><br>
						<?php endif ?>

						<?php
							echo "Seleziona una delle funzioni disponibili senza autenticazione:<br><br>";
						?>
							Migliori giocatori (seleziona incontro):
						<form action="index.php" method="get">
							<?php
							$dbconn = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
								or die('Could not connect: ' . pg_last_error());
					
							$query = "set search_path to $schema_name";
							$result = pg_query($dbconn, $query) 
								or die('Query failed: ' . pg_last_error());
							
							$query = "select incontri.id,s1.nome_lungo as squadra_casa,s2.nome_lungo as squadra_trasferta,data from incontri join squadre as s1 on squadra_casa = s1.id join squadre as s2 on squadra_trasferta = s2.id order by data";
							$result = pg_query($dbconn, $query) 
								or die('Query failed: ' . pg_last_error());

							echo"<select name='match'>";
							echo"<option value='' disabled selected hidden>Incontri</option>";
							while ($line2 = pg_fetch_row($result, null, PGSQL_NUM)) {
								$date_c = substr($line2[3],0,10);
								echo "<option value='$line2[0]'>$date_c || $line2[1] vs $line2[2]</option>";
							}
							echo "</select>";
							
							?>
							<!--<input type="number" name="match"> -->
							<input type="submit" value="Mostra">
						</form>
						<?php
							if (isset($_GET['match'])) {
								$dbconn = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
									or die('Could not connect: ' . pg_last_error());
							
								$query = "set search_path to $schema_name";
								$result = pg_query($dbconn, $query) 
									or die('Query failed: ' . pg_last_error());
								
								$value = pg_escape_string($dbconn, $_GET['match']);
								$prep = pg_prepare($dbconn,"best_p","select * from miglior_giocatore($1)");
								if ($prep != false) {
									$prep = pg_execute($dbconn,"best_p",array($value))
										or die('Query failed: ' . pg_last_error());
								}
								/*$query = "select * from miglior_giocatore($value)";
								$result = pg_query($dbconn, $query) 
									or die('Query failed: ' . pg_last_error());*/
								echo "<br><div style='width:700px; height:200px; overflow:auto'>";
								echo "<table class='table table-hover table-bordered table-sm'>\n";
								echo "\t<tr>\n";
								echo "<td>Nome giocatore</td>";
								echo "<td>Valutazione</td>";
								echo "<td>Squadra</td>";
								echo "<td>Posizione</td>";

								echo "\t</tr>\n";
								while ($line = pg_fetch_row($prep)) {
									echo "\t<tr>\n";
									foreach ($line as $col_value) {
										echo "\t\t<td>$col_value</td>\n";
									}
									echo "\t</tr>\n";
								}
								echo "</table>\n";
								echo "</div>";

								pg_free_result($result);
								pg_free_result($prep);
							
								pg_close($dbconn);
							}
						?>
						<br>
						Classifica squadre(seleziona lega e stagione):
						<form action="index.php" method="get">
						<div style='width:700px; height:60px; overflow:auto'>
						<?php
							$dbconn = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
								or die('Could not connect: ' . pg_last_error());
					
							$query = "set search_path to $schema_name";
							$result = pg_query($dbconn, $query) 
								or die('Query failed: ' . pg_last_error());
							$query = 'SELECT distinct lega from classifica_squadre_lega';
							$result = pg_query($dbconn, $query) 
								or die('Query failed: ' . pg_last_error());
							while ($line = pg_fetch_array($result, null, PGSQL_NUM)) {
								foreach ($line as $col_value) {
									echo "<input type='radio' name='lega' value='$col_value'> $col_value ";
									$query = "SELECT distinct stagione from classifica_squadre_lega where lega='$col_value' order by stagione";
									$result2 = pg_query($dbconn, $query) 
										or die('Query failed: ' . pg_last_error());
									echo"<select name='stagione-" . urlencode($col_value) . "'>";
									while ($line2 = pg_fetch_array($result2, null, PGSQL_NUM)) {
										foreach ($line2 as $col_value2) {
											echo "<option value='$col_value2'>$col_value2</option>";
										}
									}
					
									echo'</select>';
									echo '<br>';
								}
							}
							pg_free_result($result);
							
							pg_close($dbconn);
						?>
						</div>
							<input type="submit" value="Mostra">
						</form>
						<?php
							if (isset($_GET['lega'])) {
								$dbconn = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
									or die('Could not connect: ' . pg_last_error());
							
								$query = "set search_path to $schema_name";
								$result = pg_query($dbconn, $query) 
									or die('Query failed: ' . pg_last_error());

								$lega = pg_escape_string($dbconn,$_GET['lega']);
								$string_stagione = "stagione-" . urlencode($lega);
								$stagione = pg_escape_string($dbconn,$_GET[$string_stagione]);
								/*$query = "select nome_squadra,punteggio from classifica_squadre_lega where lega='$lega' and stagione='$stagione'";
								$result = pg_query($dbconn, $query) 
									or die('Query failed: ' . pg_last_error());*/
								$prep = pg_prepare($dbconn,"lega_c","select nome_squadra,punteggio from classifica_squadre_lega where lega=$1 and stagione=$2");
								if($prep != false) {
									$prep = pg_execute($dbconn,"lega_c",array($lega,$stagione))
										or die('Query failed: ' . pg_last_error());
								}
								echo "<br><div style='width:700px; height:200px; overflow:auto'>";
								echo "<table class='table table-hover table-bordered table-sm'>\n";								
								echo "\t<tr>\n";
								echo "<td>Squadra</td>";
								echo "<td>Punti</td>";

								echo "\t</tr>\n";
								while ($line = pg_fetch_row($prep)) {
									echo "\t<tr>\n";
									foreach ($line as $col_value) {
										echo "\t\t<td>$col_value</td>\n";
									}
									echo "\t</tr>\n";
								}
								echo "</table>\n";
								echo "</div>";

								pg_free_result($result);
								pg_free_result($prep);
							
								pg_close($dbconn);
							}
						?>
						<br>
						<?php
						if(!isset($_SESSION['user'])){
							echo "Oppure effettua il <a href='login.php'>login</a>";
						}						

						?>


				</div>
			</div>
		</div>
	</body>
</html>