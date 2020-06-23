<!DOCTYPE html>
<html lang="it">
    <head>
        <title>Registrazione partner</title>
        <?php
        require 'php/config-files/admin-password.php'; 
        session_start(); ?>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="./CSS/node_modules/bootstrap/dist/css/bootstrap.css">
    </head>
    <body>
            <h2>Registrazione partner</h2>
            <form action="php/register-function.php" method="post">
                <input type="text" name="username" placeholder="Username" id="username" required>
                <input type="password" name="password" placeholder="Password" id="password" required>
                <input type="password" name="password2" placeholder="Confirm Password" id="password2" required>
                <select name="societa" required>
                    <option value="" disabled selected hidden>Società</option>
                    <?php 
                    $dbconn = pg_connect("host=$dblocation dbname=$dbname user=lettore password=lettore")
                        or die('Could not connect: ' . pg_last_error());
                    
                    $query = "set search_path to $schema_name";
                    $result = pg_query($dbconn, $query) 
                        or die('Query failed: ' . pg_last_error());
                    
                    $query = "select id,nome from societa";
                    $result = pg_query($dbconn, $query) 
                        or die('Query failed: ' . pg_last_error());

                    while ($col_value = pg_fetch_row($result)) {
                        echo "<option value='$col_value[0]'>$col_value[1]</option>";
                    }

                    pg_free_result($result);
                
                    // Closing connection
                    pg_close($dbconn);

                    ?>
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
            <a href="register.php">Vuoi registrarti come operatore o amministratore?</a><br>
            <a href="login.php">Sei già registrato?</a><br>
            <a href="index.php">Homepage sito</a>

    </body>
</html>