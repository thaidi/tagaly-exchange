<?php
//echo"this is starting";
$chk=array_keys($result);

?>
<script>
	function savedata(){
		document.frm.submit();
	}
</script>
<script>
	//for light box		
	$(document).ready(function($) {        
	// DOM Ready				
		$(function() {				
			$('#dashboard-popup').bind('click', function(e) {
				// alert('hello');
				// Prevents the default action to be triggered. 
				e.preventDefault();				
				// Triggering bPopup when click event is fired		
				$('#dashboard').bPopup();			
			});				
		});			
	});


</script>
<div align='left'>	
	<button type="button" id="dashboard-popup" class="dashboard btn btn-default" data-toggle="button">Select Columns</button>	
</div>
<div class='dataset'>	
			<table class='table'>	
				<?php				
					$c = new Mongo("192.168.1.104");

				  //  $c->command(array("listDatabases" => 1));


					//$numofclients = 10;
					mysql_connect('localhost','root','ppcminds1') or die("Error in Connection");
					mysql_select_db('cakephp') or die("Cannot Select The Database");
					$rs77=mysql_query("select * from clients");
					while($row77=mysql_fetch_array($rs77))
					{
				$clientactids[]=$row77['accountid'];	
					}


print_r($clientactids);
				    $numofclients = count($clientactids);	
					$result = mysql_query('select * from actsettings where id = 1');
					$result_set= mysql_fetch_array($result);
					//print_r($result_set);
					// echo $result_set['Acct2'];
					echo "<thead style='background-color:#f6f6f6'>";	
						echo "<tr>";
							echo"<th><input type='checkbox' onClick='toggle(this)'  /></th>";
echo "<th>Client&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>";
							// if($result_set['Acct1'] != 'false'){ echo "<th>Ad Network Type2</th>"; }

							echo "<th>Labels</th><th>Alerts</th>";
							if($result_set['Acct2'] != 'false'){ echo "<th>Clicks</th>"; }		
							if($result_set['Acct3'] != 'false'){ echo "<th>Impressions</th>"; }		
							if($result_set['Acct4'] != 'false'){ echo "<th>Ctr</th>"; }		
							if($result_set['Acct5'] != 'false'){ echo "<th>Average Cpc</th>"; }		
							if($result_set['Acct6'] != 'false'){ echo "<th>Average Cpm</th>"; }		
							if($result_set['Acct7'] != 'false'){ echo "<th>Average Position</th>"; }	
							if($result_set['Acct8'] != 'false'){ echo "<th>Amount Spent<br>(Cost)</th>"; }		
							if($result_set['Acct9'] != 'false'){ echo "<th>Conversions</th>"; }		
							if($result_set['Acct10'] != 'false'){ echo "<th>Conversions Many Per Click</th>"; }	
							if($result_set['Acct11'] != 'false'){ echo "<th>View Through Conversions</th>"; }	
							if($result_set['Acct12'] != 'false'){ echo "<th>Cost Per Conversion</th>"; }
							if($result_set['Acct13'] != 'false'){ echo "<th>Cost Per Conversion Many Per Click</th>"; }		
							if($result_set['Acct14'] != 'false'){ echo "<th>Conversion Rate</th>"; }			
							if($result_set['Acct15'] != 'false'){ echo "<th>Conversion Rate Many Per Click</th>"; }	
							if($result_set['Acct16'] != 'false'){ echo "<th>Invalid Clicks</th>"; }		
						echo "</tr>";				
					echo "</thead>";
					
$Clicks1=$Impressions1=$Ctr=$AverageCpc1=$Cost1=$Conversions1=0;
$ConversionsManyPerClick1=$ViewThroughConversions1=$CostPerConversion1=$CostPerConversionManyPerClick1=0;	
$ConversionRate1=$ConversionRateManyPerClick1=$InvalidClicks1=0;
//print_r($clientsAccounts);
					for($i=0;$i<count($clientactids);$i++){
						  if (in_array($i, $chk)|| $input=='')
								{
								echo $clientactids[$i];
						$db_name = 'F'.$clientactids[$i];
						$db = $c->selectDB($db_name);
						$collection = $db->ACCOUNT_PERFORMANCE;		
						$result = $db->command(array(				
							'aggregate' => 'ACCOUNT_PERFORMANCE',			
							'pipeline'  => array(					
								array('$group'  => array(				
									'_id'       => "123456123456123456123456",	
									'Clicks'  => array('$sum' => '$Clicks'),	
									'Impressions' => array('$sum' => '$Impressions'),				
									'Cost' => array('$sum' => '$Cost'),					
									'Conversions' => array('$sum' => '$Conversions'),	
									'InvalidClicks' => array('$sum' => '$InvalidClicks'),	
									'ViewThroughConversions' => array('$sum' => '$ViewThroughConversions'),	
								))					
							),						
						));
						
						$Clicks = $result['result'][0]['Clicks'];
						if($Clicks==0){
						$result = $db->command(array(				
							'aggregate' => 'ACCOUNT_PERFORMANCE_REPORT',			
							'pipeline'  => array(					
								array('$group'  => array(				
									'_id'       => "123456123456123456123456",	
									'Clicks'  => array('$sum' => '$Clicks'),	
									'Impressions' => array('$sum' => '$Impressions'),				
									'Cost' => array('$sum' => '$Cost'),					
									'Conversions' => array('$sum' => '$Conversions'),	
									'InvalidClicks' => array('$sum' => '$InvalidClicks'),	
									'ViewThroughConversions' => array('$sum' => '$ViewThroughConversions'),	
								))					
							),						
						));
						}
						
						
						  //print_r($result);		
						$Clicks = $result['result'][0]['Clicks'];	
						$Cost = $result['result'][0]['Cost'];	
						$Impressions = $result['result'][0]['Impressions'];	
						$Conversions = $result['result'][0]['Conversions'];		
						$InvalidClicks = $result['result'][0]['InvalidClicks'];			
						$ViewThroughConversions = $result['result'][0]['ViewThroughConversions'];			
						$Ctr = Ctr($Clicks,$Impressions);				
						$AverageCpc = AverageCpc($Cost,$Clicks);		
						$AverageCpm = AverageCpm($Cost,$Impressions);
						$ConversionRate = ConversionRate($Conversions,$Clicks);		
						// $ConversionRateManyPerClick = ConversionRateManyPerClick($ConversionsManyPerClick,$Clicks);
						$CostPerConversion = CostPerConversion($Cost,$Conversions);						
						// $CostPerConversionManyPerClick = CostPerConversionManyPerClick($Cost,$ConversionsManyPerClick);
						// print_r($retval['AdNetworkType2']);

$Clicks1=$Clicks1+$Clicks;
$Impressions1=$Impressions1+$Impressions;
$Ctr1=$Ctr1+$Ctr;
$AverageCpc1=$AverageCpc1+$AverageCpc;
$AverageCpm1=$AverageCpm1+$AverageCpm;
$Cost1=$Cost1+$Cost;
$Conversions1=$Conversions1+$Conversions;
$ConversionsManyPerClick1=$ConversionsManyPerClick1+$ConversionsManyPerClick;
$ViewThroughConversions1=$ViewThroughConversions1+$ViewThroughConversions;
$CostPerConversion1=$CostPerConversion1+$CostPerConversion;
$CostPerConversionManyPerClick1=$CostPerConversionManyPerClick1+$CostPerConversionManyPerClick1;	
$ConversionRate1=$ConversionRate1+$ConversionRate;
$ConversionRateManyPerClick1=$ConversionRateManyPerClick1+$ConversionRateManyPerClick;
$InvalidClicks1=$InvalidClicks1+$InvalidClicks;
						echo "<tr>";
						echo "<td><input  type='checkbox' id='chkbox[]' name='foo' ></td>";
						//echo "<td>Account name <font color='green'>". $clientactnames[$i] ."</font><br/> Account Id : <a href='#'  id='".$clientactids[$i]."' onclick='ajaxtest(this.id)'>". $clientactids[$i] ."</a> </td>";


echo "<td>Account name <font color='green'><a href='".$this->Html->url(array("controller" => "users","action" => "main",'?' => array('cid' => $clientactids[$i])))."'>". $clientactnames[$i] ."</a></font><br/> Account Id : <a href='".$this->Html->url(array("controller" => "users","action" => "main",'?' => array('aid' => $clientactids[$i],'field' => 'value.Campaigns')))."'>". $clientactids[$i] ."</a> </td>";


 //$this->Html->url(array("controller" => "projectnetworks","action" => "client_account")); 
						// if($result_set['Acct1'] != 'false'){echo"<td>" . $retval['AdNetworkType2']. "</td>"; }

							     echo "<td>--</td><td>--</td>";
								if($result_set['Acct2'] != 'false'){ echo "<td>" . $Clicks . "</td>"; }		
								if($result_set['Acct3'] != 'false'){ echo "<td>" . $Impressions. "</td>"; }	
								if($result_set['Acct4'] != 'false'){ echo "<td>" . $Ctr. "</td>"; }			
								if($result_set['Acct5'] != 'false'){ echo "<td>" . $AverageCpc. "</td>"; }	
								if($result_set['Acct6'] != 'false'){ echo "<td>" . $AverageCpm. "</td>"; }	
								if($result_set['Acct7'] != 'false'){ echo "<td>AveragePosition</td>"; }		
								if($result_set['Acct8'] != 'false'){ echo "<td>" . round($Cost,2). "</td>"; }		
								if($result_set['Acct9'] != 'false'){ echo "<td>" . $Conversions. "</td>"; }	
								if($result_set['Acct10'] != 'false'){ echo "<td>" . $ConversionsManyPerClick. "</td>"; }
								if($result_set['Acct11'] != 'false'){ echo "<td>" . $ViewThroughConversions. "</td>"; }
								if($result_set['Acct12'] != 'false'){ echo "<td>" . $CostPerConversion. "</td>"; }
								if($result_set['Acct13'] != 'false'){ echo "<td>" . $CostPerConversionManyPerClick. "</td>"; }
								if($result_set['Acct14'] != 'false'){ echo "<td>" . $ConversionRate. "</td>"; }
								if($result_set['Acct15'] != 'false'){ echo "<td>" . $ConversionRateManyPerClick. "</td>"; }
								if($result_set['Acct16'] != 'false'){ echo "<td>" . $InvalidClicks. "</td>"; }				
								echo "</tr>";
					  }// if (in_array($i, $chk))
					}
/*
$Clicks1=$Impressions1=$Ctr=$AverageCpc1=$Cost1=$Conversions1=0;
$ConversionsManyPerClick1=$ViewThroughConversions1=$CostPerConversion1=$CostPerConversionManyPerClick1=0;	
$ConversionRate1=$ConversionRateManyPerClick1=$InvalidClicks1=0;
*/
echo "<tr>";
						echo "<td colspan='4'>Grand Total</td>";
								if($result_set['Acct2'] != 'false'){ echo "<td>" . $Clicks1 . "</td>"; }		
								if($result_set['Acct3'] != 'false'){ echo "<td>" . $Impressions1. "</td>"; }	
								if($result_set['Acct4'] != 'false'){ echo "<td>" . $Ctr1. "</td>"; }			
								if($result_set['Acct5'] != 'false'){ echo "<td>" . $AverageCpc1. "</td>"; }	
								if($result_set['Acct6'] != 'false'){ echo "<td>" . $AverageCpm1. "</td>"; }	
								if($result_set['Acct7'] != 'false'){ echo "<td>AveragePosition1</td>"; }		
								if($result_set['Acct8'] != 'false'){ echo "<td>" . round($Cost1,2). "</td>"; }		
								if($result_set['Acct9'] != 'false'){ echo "<td>" . $Conversions1. "</td>"; }	
								if($result_set['Acct10'] != 'false'){ echo "<td>" . $ConversionsManyPerClick1. "</td>"; }
								if($result_set['Acct11'] != 'false'){ echo "<td>" . $ViewThroughConversions1. "</td>"; }
								if($result_set['Acct12'] != 'false'){ echo "<td>" . $CostPerConversion1. "</td>"; }
								if($result_set['Acct13'] != 'false'){ echo "<td>" . $CostPerConversionManyPerClick1. "</td>"; }
								if($result_set['Acct14'] != 'false'){ echo "<td>" . $ConversionRate1. "</td>"; }
								if($result_set['Acct15'] != 'false'){ echo "<td>" . $ConversionRateManyPerClick1. "</td>"; }
								if($result_set['Acct16'] != 'false'){ echo "<td>" . $InvalidClicks1. "</td>"; }
								echo "</tr>";
/*
echo "<tr style='background-color:#f6f6f6'><td></td><td></td><td colspan='3'><b>GRAND TOTAL</b></td><td>$Clicks1</td><td>$Impressions1</td><td>$Ctr1</td><td>$AverageCpc1</td><td>$AverageCpm1</td><td>--</td><td>$Cost1</td><td>$Conversions1</td><td>$ConversionsManyPerClick1</td><td>$ViewThroughConversions1</td><td>$CostPerConversionManyPerClick1</td><td></td><td>$ConversionRate1</td><td>$ConversionRateManyPerClick1</td><td>$InvalidClicks1</td></tr>";
*/
				?>
					</table>		
				</div>
				<div id="dashboard" style="display:none;background-color:white;padding:60px 60px 60px 60px;">			<form method='post' name='frm' action='savesettings'>			
				<table class="table">		
				<tr>
				<td><input type="checkbox" style='margin-top:-4px;' name="Acct1" <?php if($result_set['Acct1'] != 'false'){ echo "checked='checked'"; } ?> value="1"> AdNetwork Type2</td>	
				<td><input type="checkbox" name="Acct2" <?php if($result_set['Acct2'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="2"> Clicks</td>			<td><input type="checkbox" name="Acct3" <?php if($result_set['Acct3'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="3"> Impressions</td>		</tr>		<tr>			<td><input type="checkbox"  style='margin-top:-4px;' name="Acct4" <?php if($result_set['Acct4'] != 'false'){ echo "checked='checked'"; } ?> value="4"> Ctr</td>			<td><input type="checkbox" name="Acct5" <?php if($result_set['Acct5'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;'  value="5"> Average Cpc</td>			<td><input type="checkbox" name="Acct6" <?php if($result_set['Acct6'] != 'false'){ echo "checked='checked'"; } ?> style='margin-top:-4px;'  value="6"> Average Cpm</td>		</tr>		<tr>			<td><input type="checkbox" name="Acct7" <?php if($result_set['Acct7'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="7"> Average Position</td>			<td><input type="checkbox" name="Acct8" <?php if($result_set['Acct8'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="8"> Cost</td>			<td><input type="checkbox" name="Acct9" <?php if($result_set['Acct9'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="9"> Conversions</td>		</tr>		<tr>			<td><input type="checkbox" name="Acct10" <?php if($result_set['Acct10'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;'  value="10"> ConversionsManyPerClick</td>			<td><input type="checkbox" name="Acct11" <?php if($result_set['Acct11'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="11"> ViewThroughConversions</td>			<td><input type="checkbox" name="Acct12" <?php if($result_set['Acct12'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="12"> CostPerConversion</td>		</tr>		<tr>			<td><input type="checkbox" name="Acct13" <?php if($result_set['Acct13'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="13"> CostPerConversionManyPerClick</td>			<td><input type="checkbox" name="Acct14" <?php if($result_set['Acct14'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="14"> ConversionRate</td>			<td><input type="checkbox" name="Acct15" <?php if($result_set['Acct15'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="15"> ConversionRateManyPerClick</td>		</tr>		<tr>			<td><input type="checkbox" name="Acct16" <?php if($result_set['Acct16'] != 'false'){ echo "checked='checked'"; } ?>  style='margin-top:-4px;' value="16">InvalidClicks</td>		</tr>		<tr>			<submit class='btn btn-primary' onclick='savedata();'>Confirm</submit>					</tr>	</table>	</form>		</div>


