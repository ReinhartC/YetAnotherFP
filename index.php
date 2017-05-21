<?php
	session_start();
	if(!isset($_SESSION['email'])){
		header("Location: login.php");
		die;
	}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
  <title>Dragonadopters Shutdown Page</title>
  <link rel="stylesheet" type="text/css" href="css/home.css">
  <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-11458408-2', 'auto');
    ga('send', 'pageview');
    
  </script>
</head>
<body>
<div class="shadow">
  <div class="shadow2">
    <div class="header">
      <a href="http://www.mydragon.kuliahweb.com">
        <div class="betaHide"></div>
        <img border="0" src="images/header.jpg" alt="Dragonadopters Header">
      </a>
    </div>
    <div class="dragonmenu">
      <div class="dragonmenuhover" onMouseOver="this.style.position='absolute'" onMouseOut="this.style.position='static'">
        <div class="floatleft">
		  <div class="dragonlink">
		    <a href="index.php">Home</a>
		  </div>
		</div>
		<div class="floatleft">
		  <div class="dragonlink">
		    <a href="dragons.php">Dragons</a>
		  </div>
		</div>
        <div class="floatright">
		  <div class="dragonlink">
		    <a href="logout.php">Keluar</a>
		  </div>
		</div>
      </div>
    </div>
    <div class="shutdownContent">
    <div class="floatright"><img width="300"src="images/naga.jpg"/></div>
<div class="floatleft" style="width:570px;text-align:justify;">
<b>Dear users,</b><br><br>
<h2>Selamat datang <?php $username = $_SESSION['email']; echo $username;?></h2>
<?php
        include "connect.php";

        $query = "CALL sp_ceknamaawalnaga('$username')";
        $sql = mysqli_query($db, $query);

        $row = mysqli_fetch_array($sql);
            if($row[0] == 0){
             echo nl2br ("Selamat Datang !!! \n Sepertinya anda User baru dalam game ini \n Admin telah memberikan sebuah telor naga gratis untuk anda \n Silahkan namai naga anda ");
		?><a href="naga1.php">NAMAI NAGA</a><?php

            }
            else
            {
				echo "tes";
			}
            mysqli_close($db);
    ?>
         
<br>
</div>
    </div>
    <div class="clearleft"></div>
  </div>
  <div class="footer">
    Images and content &#169; Mydragon.kuliahweb.com
  </div>
</div>
  <div class="footershadow">
  </div>
</div>
</body>
</html>