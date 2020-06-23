<!DOCTYPE html>
<html lang="it">
    <title>Registrazione</title>
    <?php session_start(); ?>
    <!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="./CSS/node_modules/bootstrap/dist/css/bootstrap.css">
    <body>
            <h2>Registrazione</h2>
            <form action="php/register-function.php" method="post">
                <input type="text" name="username" placeholder="Username" id="username" required>
                <input type="password" name="password" placeholder="Password" id="password" required>
                <input type="password" name="password2" placeholder="Confirm Password" id="password2" required>
                <select name="user_type" required>
                    <option value="" disabled selected hidden>Seleziona tipo utente</option>
                    <option value="operatore">operatore</option>
                    <option value="amministratore">amministratore</option>
                </select> 
                <input type="submit" value="Registrati">
                
            </form><br>
            <?php if (isset($_SESSION['failed-create-password'])) : ?>
                <i style="color: red">
                <?php echo $_SESSION['failed-create-password'];
                    session_destroy(); 
                ?>
                </i><br>
            <?php endif ?>
            <a href="register-partner.php">Vuoi registrarti come partner?</a><br>
            <a href="login.php">Sei già registrato?</a><br>
            <a href="index.php">Homepage sito</a>

    </body>
</html>