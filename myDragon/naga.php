<?php
      session_start();

?>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Untitled Document</title>
</head>

<body>
<h1>ini naga </h1>

<form action="#" method="post">
					<input  autofocus type="text" id="namanaga" name="namanaga" placeholder="Naga" required=""/>
					<input type="submit" name="naga" id="naga" value="Naga"/>
				</form>
           <?php
          if(isset($_POST['naga'])){
            include "connect.php";
			$username = $_SESSION['username'];
            $query = "CALL sp_setnamaawalnaga('$username','$_POST[namanaga]')";
            $sql = mysqli_query($db, $query);

            $row = mysqli_fetch_array($sql);
                if($row[0] == 0){
					$_SESSION['namanaga']=$_POST['namanaga'];
					$namanaga = $_SESSION['namanaga']; echo $namanaga;
                 echo $row[1];
				 ?><a href="index.php">HOME</a><?php
                }
                else{
                  echo "tes";
                } 
                mysqli_close($db);
          }
        ?>
 <a href="logout.php">Keluar</a>
</body>
</html>