<!doctype html>
<html lang="it">
    <head>
        <title> Login </title>
        <?php 
        session_start(); 
        if (isset($_SESSION['user'])) {
            header('location: index.php');
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
        <div class="login">
            <h2>Login</h2>
            <form action="php/authenticate.php" method="post">
                <input type="text" name="username" placeholder="Username" id="username" required>
                <input type="password" name="password" placeholder="Password" id="password" required>
                <select name="user_type" required>
                    <option value="" disabled selected hidden>Seleziona tipo utente</option>
                    <option value="operatore">operatore</option>
                    <option value="amministratore">amministratore</option>
                    <option value="partner">partner</option>
                </select> 
                <input type="submit" value="Login">
            </form>
            <?php if (isset($_SESSION['failed-login'])) : ?>
                <i style="color: red">
                <?php echo $_SESSION['failed-login'];
                    session_destroy(); 
                ?>
                </i><br>
            <?php endif ?>
            <?php if (isset($_SESSION['success-create'])) : ?>
                <i style="color: green">
                <?php echo $_SESSION['success-create'];
                    session_destroy(); 
                ?>
                </i><br>
			<?php endif ?><br>
            <a href="register.php">Nuovo utente?</a><br>
            <a href="index.php">Homepage sito</a>
        </div>
    </body>
</html>