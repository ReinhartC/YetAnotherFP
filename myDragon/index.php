	<?php
      session_start();
?>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>myDragon - Home</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin.css" rel="stylesheet">
    <link href="css/plugins/morris.css" rel="stylesheet">
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>

    <div id="wrapper">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">myDragon</a>
            </div>
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                    <ul class="dropdown-menu alert-dropdown">
                        <?php
                        $count=3;
                        while ($count>0){ $count--;
                            echo "<li>
                                    <a href='#'>(notifikasi) <span class='label label-default'>Alert Badge</span></a>
                                </li>";
                        }
                        ?>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>  <?php $username = $_SESSION['username']; echo $username;?> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#"><i class="fa fa-fw fa-user"></i> Profile</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="logout.php"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li class="active">
                        <a href="index.php"><i class="fa fa-fw fa-home"></i> Home</a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw fa-shopping-bag"></i> Shop</a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-fw fa-info"></i> About</a>
                    </li>
                </ul>
            </div>
        </nav>

        <div id="page-wrapper">

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            HOME
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-desktopashboard"></i>Your dragons
                            </li>
                        </ol>
                    </div>
                </div>

                <div class="row">

                <?php
                    $count=3;
                    while ($count>0){
                         echo "<div class='col-lg-3 col-md-6'>
                            <div class='panel panel-yellow'>
                                <div class='panel-heading'>
                                    <div class='row'>
                                        <div class='col-xs-3'>
                                            <p>(Icon naga)</p>
                                        </div>
                                        <div class='col-xs-9 text-right'>
                                           <div><h2>namanaga</h2></div>
                                            <div>(Spesies naga)</div>
                                            <div>(Status naga)</div>
                                        </div>
                                    </div>
                                </div>
                                <a href='#'>
                                    <div class='panel-footer'>
                                        <span href='#' class='pull-left'>Tampilkan naga</span>
                                        <span class='pull-right'><i class='fa fa-arrow-circle-right'></i></span>
                                        <div class='clearfix'></div>
                                    </div>
                                </a>
                            </div>
                        </div>";
                        $count--; 
                    }
                ?>
                </div>


                <div class="page-header">
                    <h1>Welcome</h1>
                </div>
                <div class="well">
                    <h2>Selamat datang <?php $username = $_SESSION['username']; echo $username;?></h2>
                    <?php
                            include "connect.php";

                            $query = "CALL sp_ceknamaawalnaga('$username')";
                            $sql = mysqli_query($db, $query);

                            $row = mysqli_fetch_array($sql);
                                if($row[0] == 0){
                                 echo nl2br ("Selamat Datang !!! \n Sepertinya anda User baru dalam game ini \n Admin telah memberikan sebuah telor naga gratis untuk anda \n Silahkan namai naga anda ");
                            ?><a href="naga.php">NAMAI NAGA</a><?php

                                }
                                else
                                {
                                    echo "tes";
                                }
                                mysqli_close($db);
                        ?>
                </div>
            </div>

        </div>
    </div>
    <!-- /#wrapper -->

    <footer class="text-center">
      <p style="color:white"><br>© myDragon Dev Team<br>2017<br></p>
    </footer>

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="js/plugins/morris/raphael.min.js"></script>
    <script src="js/plugins/morris/morris.min.js"></script>
    <script src="js/plugins/morris/morris-data.js"></script>

</body>

</html>
