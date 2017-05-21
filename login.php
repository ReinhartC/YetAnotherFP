<!--
Author: W3layouts
Author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<?php
      session_start();
      if(isset($_SESSION['email'])){
            header("Location: index.php");
            die;
      }
?>
<!DOCTYPE html>
<html>

<head>
<title>LOGIN</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Gaming Login Form Widget Tab Form,Login Forms,Sign up Forms,Registration Forms,News letter Forms,Elements"/>
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
</head>

<body>
	<div class="padding-all">
		<div class="header">
			<h1><img src="./images/5.png" alt=" ">Login</h1>
		</div>

		<div class="design-w3l">
			<div class="mail-form-agile">
				<form action="#" method="post">
					<input  autofocus type="text" id="nama" name="nama" placeholder="Username" required=""/>
					<input  placeholder='Password' id="password" type="password"  name="password" class="padding" placeholder="Password" required=""/>
					<input type="submit" name="submit" id="submit" value="Login"/>
				</form>
				<p style="color:white"><br>Belum ada akun? Daftar <a href="registration.php" >disini</a>.</p>
			</div>
		  <div class="clear"> </div>
		</div>
	</div>
	<?php
      if(isset($_POST['submit'])){
        include "connect.php";

        $query = "CALL sp_login('$_POST[nama]','$_POST[password]')";
        $sql = mysqli_query($db, $query);

        $row = mysqli_fetch_array($sql);
            if($row[0] == 0){
              $_SESSION['email']=$_POST['nama'];
              $_SESSION['password']=$row[2];
                $_SESSION['loggedIn']=true;
                            echo $row[1];
              header("Location: index.php");
            }
            else{
              ?>
              <?php
            }
            echo $row[1]; 
            mysqli_close($db);
      }
    ?>
   
</body>
</html>