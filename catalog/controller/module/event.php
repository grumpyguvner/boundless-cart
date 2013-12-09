<?php  
class ControllerModuleEvent extends Controller {
	protected function index() {
		$this->language->load('module/event');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
    	
		$this->data['text_contact'] = $this->language->get('text_contact');
    	$this->data['text_sitemap'] = $this->language->get('text_sitemap');
		
		$this->load->model('catalog/event');
		
		$this->data['event'] = array();
		
		if(!isset($this->request->get['x'])){ $x = date("n");}
		else{$x=$this->request->get['x'];}
		
		if(isset($this->request->get['y']) && $this->request->get['y']!=''){
			$yr = $this->request->get['y'];		
		}else{
			$yr = date('Y');		
		}
		
		$date = strtotime("$yr/$x/1");
		$day = date("D",$date);
		$m = date("F",$date);
		$totaldays = date("t",$date); //get the total day of specified date
		
		$YN = date("Y",$date);
		
		$wh =" AND DATE_FORMAT(i.event_date,'%Y-%m')='".date("Y",$date)."-".date("m",$date)."'";
		$dates = array();
		foreach ($this->model_catalog_event->getEvents($wh) as $result) {
      		$dates[] = $result['event_date'];
    	}
		
		$cal_str = "<table border = '0' cellspacing = '1' bgcolor='#e4e4e4' cellpadding ='2' width='100%' style='margin-top:3px;'>
		<tr><td colspan='7'><strong>$m - $YN</strong></td></tr>
		<tr>
		<td style='background-color:#fff; font-weight:bold;'><font size = '1'>Sun</font></td>
		<td style='background-color:#fff; font-weight:bold;'><font size = '1'>Mon</font></td>
		<td style='background-color:#fff; font-weight:bold;'><font size = '1'>Tue</font></td>
		<td style='background-color:#fff; font-weight:bold;'><font size = '1'>Wed</font></td>
		<td style='background-color:#fff; font-weight:bold;'><font size = '1'>Thu</font></td>
		<td style='background-color:#fff; font-weight:bold;'><font size = '1'>Fri</font></td>
		<td style='background-color:#fff; font-weight:bold;'><font size = '1'>Sat</font></td>
		</tr>";

		if($day=="Sun") $st=1;
		if($day=="Mon") $st=2;
		if($day=="Tue") $st=3;
		if($day=="Wed") $st=4;
		if($day=="Thu") $st=5;
		if($day=="Fri") $st=6;
		if($day=="Sat") $st=7;
		
		
		if ($st >= 6 && $totaldays == 31) {$tl=42;}elseif($st == 7 && $totaldays == 30){$tl = 42;}else{$tl = 35;}
		
		$ctr = 1;
		$d=1;
				
		for($i=1;$i<=$tl;$i++){

			if($ctr==1) $cal_str.= "<tr>";
			
			if($i >= $st && $d <= $totaldays){
				$cdate = $yr."-". str_pad($x,2,'0',STR_PAD_LEFT) ."-".str_pad($d,2,'0',STR_PAD_LEFT);
				//echo '<br />';
				
				if(in_array($cdate,$dates)){
					$bgcol = 'background-color:#fff; font-weight:bold;';
					$link = "<a href='".$this->url->link("information/event/events&date=$cdate")."' style='text-decoration:none; color:#1db4b7; font-weight: bold;'>$d</a>";
				}else{
					$bgcol = 'background-color:#fff; font-weight:bold;';
					$link = $d;
				}
				
				$cal_str.= "<td align='center' style='$bgcol'><font size = '2'>$link</font></td>";
				$d++;
			}
			else{
				$cal_str.= "<td style='background-color:#fff'>&nbsp</td>";
			}
			
			$ctr++;
			
			if($ctr > 7) {
				$ctr=1;
				$cal_str.= "</tr>";
			}
			
		}
		
		$prev = $x - 1;
		$next = $x + 1;
		if($prev==0) $prev=1;
		//if($next==13) $next = 12;
		
		if($prev==1){$prev = 12;$pryr = $yr-1;}else{$pryr = $yr;}
		if($next>12){$nxyr = $yr+1;$next = 1;}else{$nxyr = $yr;}
		$cal_str.= '</table>
		<div style="text-align:right; margin-top: 8px;">
		<a onclick="do_cal(\''.$pryr.'\',\''.$prev.'\');" class="button">Previous</a>   <a onclick="do_cal(\''.$nxyr.'\',\''.$next.'\');" class="button">Next</a></div>';  
		
		$this->data['event_cal'] = $cal_str;
		
		$this->setTemplate('module/event.tpl');
		
		$this->render();
	}

	public function callback(){
		$this->language->load('module/event');
		if(!isset($this->request->get['x'])){ $x = date("n");}
		else{$x=$this->request->get['x'];}
		
		if(isset($this->request->get['y']) && $this->request->get['y']!=''){
			$yr = $this->request->get['y'];		
		}else{
			$yr = date('Y');		
		}
		$this->load->model('catalog/event');
		$date = strtotime("$yr/$x/1");
		$day = date("D",$date);
		$m = date("F",$date);
		$totaldays = date("t",$date); //get the total day of specified date
		
		$YN = date("Y",$date);
		
		$wh =" AND DATE_FORMAT(i.event_date,'%Y-%m')='".date("Y",$date)."-".date("m",$date)."'";
		$dates = array();
		foreach ($this->model_catalog_event->getevents($wh) as $result) {
      		$dates[] = $result['event_date'];
    	}
		
		
		$cal_str = "<table border = '0' cellspacing = '1' bgcolor='#e4e4e4' cellpadding ='2' width='100%' style='margin-top:3px;'>
		<tr><td colspan='7'><strong>$m - $YN</strong></td></tr>
		<tr>
		<td style='background-color:#fff'><font size = '1'>Sun</font></td>
		<td style='background-color:#fff'><font size = '1'>Mon</font></td>
		<td style='background-color:#fff'><font size = '1'>Tue</font></td>
		<td style='background-color:#fff'><font size = '1'>Wed</font></td>
		<td style='background-color:#fff'><font size = '1'>Thu</font></td>
		<td style='background-color:#fff'><font size = '1'>Fri</font></td>
		<td style='background-color:#fff'><font size = '1'>Sat</font></td>
		</tr>";

		if($day=="Sun") $st=1;
		if($day=="Mon") $st=2;
		if($day=="Tue") $st=3;
		if($day=="Wed") $st=4;
		if($day=="Thu") $st=5;
		if($day=="Fri") $st=6;
		if($day=="Sat") $st=7;
		
		
		if ($st >= 6 && $totaldays == 31) {$tl=42;}elseif($st == 7 && $totaldays == 30){$tl = 42;}else{$tl = 35;}
		
		$ctr = 1;
		$d=1;
		
		for($i=1;$i<=$tl;$i++){

			if($ctr==1) $cal_str.= "<tr>";
			
			if($i >= $st && $d <= $totaldays){
				$cdate = $yr."-". str_pad($x,2,'0',STR_PAD_LEFT) ."-".str_pad($d,2,'0',STR_PAD_LEFT);
				if(in_array($cdate,$dates)){
					$bgcol = 'background-color:#e4e4e4';
					$link = "<a href='".$this->url->link("information/event/events&date=$cdate")."' style='text-decoration:none; font-weight: bold;'>$d</a>";
				}else{
					$bgcol = 'background-color:#fff';
					$link = $d;
				}
				
				$cal_str.= "<td align='center' style='$bgcol'><font size = '2'>$link</font></td>";
				$d++;
			}
			else{
				$cal_str.= "<td style='background-color:#fff'>&nbsp</td>";
			}
			
			$ctr++;
			
			if($ctr > 7) {
				$ctr=1;
				$cal_str.= "</tr>";
			}
			
		}
		
		$prev = $x - 1;
		$next = $x + 1;
		if($prev==0) $prev=1;
		//if($next==13) $next = 12;
		
		if($prev==1){$prev = 12;$pryr = $yr-1;}else{$pryr = $yr;}
		if($next>12){$nxyr = $yr+1;$next = 1;}else{$nxyr = $yr;}
		$cal_str.= '</table>
		<div style="text-align:right; "><br />
		<a onclick="do_cal(\''.$pryr.'\',\''.$prev.'\');" style="font-weight:bold; padding:3px 5px; background:#e4e4e4; text-decoration:none; -moz-border-radius:4px;">Previous</a>   <a onclick="do_cal(\''.$nxyr.'\',\''.$next.'\');"  style="font-weight:bold; padding:3px 5px; background:#e4e4e4; text-decoration:none; -moz-border-radius:4px;">Next</a></div>';  
		$this->response->setOutput($cal_str, $this->config->get('config_compression'));
	}
}




?>