<?php
include("config.php");

echo $_REQUEST['page'];
if($_POST){

for($i=0;$i<100;$i++){

$onBal = $_POST['onBalance'][$i];
$offBal = $_POST['offBalance'][$i];
$fxCampaignId = $_POST['fxCampaignId'][$i];
$asignAdCampaign = $_POST['asignAdCampaign'][$i];

echo "update fx_campaign  set balance_on='$onBal',balance_off='$offBal', cur_timestamp=now()  where fx_campaign_id='$fxCampaignId' and asign_ad_campaign='$asignAdCampaign' ";

$queryResult = mysql_query("update fx_campaign  set balance_on='$onBal',balance_off='$offBal', cur_timestamp=now()  where fx_campaign_id='$fxCampaignId' and asign_ad_campaign='$asignAdCampaign' ");


}

// header("Location: status_panel_new.php?page=1");


?>
