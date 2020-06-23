<!doctype html>
<html lang="en">
	<head>
		<title> Caricamento file </title>
		<?php
		session_start(); 

	    if (isset($_SESSION['user'])) {
			if($_SESSION['user_type']!='amministratore') {
				header('location: index.php');
				die();
			}
		}
		else
		{
			header('location: login.php');
			die();
		}
		?>

		<!-- Required meta tags -->
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="./CSS/node_modules/bootstrap/dist/css/bootstrap.css">
	</head>
	<body>
		<form enctype="multipart/form-data" action="php/upload.php" method="post">
			<div class="form-group">
				<input type="hidden" name="MAX_FILE_SIZE" value="1000000" />
				<h5>Seleziona un csv: </h5>
				<input class="form-control-file" name="uploaded_file" type="file" /> <br>
				<h5>Inserisci la password per confermare l' operazione: </h5>
				<input class="password" type="password" name="password"> <br><br>
    			<input type="submit" value="Upload" />
			</div>
		</form> 
		<br>
		<a href="index.php">Torna all'homepage</a>
	</body>
</html>