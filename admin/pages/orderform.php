<?php
//////////////////////////////
// TheHostingTool
// Admin Area - Order Form
// By Kevin Mark
// Released under the GNU-GPL
//////////////////////////////

// Check if called by script
if(THT != 1){die();}

define("PAGE", "Order Form");

class page {
	
	public $navtitle;
	public $navlist = array();
	
	public function __construct() {
		$this->navtitle = "Order Form Actions";
		$this->navlist[] = array("Custom Fields", "table_gear.png", "customf");
	}
	
	public function description() {
		return "<strong>Client Order Form Options</strong><br />
		This is where you can modify and customize your frontend order form. Most notably,
		you can add and edit custom fields to meet your exact needs.";
	}
	
	public function content() {
		global $main;
		// An honest attempt to make this system a little less painful (for me)...
		if(array_key_exists("sub", $main->getvar) && !empty($main->getvar["sub"])) {
			$sub = "_" . strtolower($main->getvar["sub"]);
			if(method_exists($this, $sub)) {
				$this->{$sub}();
				return;
			}
			$main->error(array(__FILE__ => "<code>\$this->$sub</code> isn't a method."));
		}
	}
	
	public function _customf() {
		global $db, $style;
		$query = $db->query("SELECT * FROM `<PRE>orderfields` ORDER BY `order` ASC");
		if($db->num_rows($query) == 0) {
            echo $style->replaceVar("tpl/aorderform/top.tpl");
			echo "<center>".$style->notice(false, "You don't have any custom fields defined!")."</center>";
			return;
		}
        $boxes = "";
        $globalSelectOptCounter = 0;
		while($arr = mysql_fetch_assoc($query)) {
			if(isset($pass)) { unset($pass); }
			$pass["ID"] = $arr["id"];
			$pass["TITLE"] = htmlspecialchars($arr["title"]);
			$pass["DESCRIPTION"] = htmlspecialchars($arr["description"]);
			if($arr["required"] == 1) {
				$pass["REQ"] = "*";
				$pass["REQC"] = " checked=\"yes\"";
			}
			else {
				$pass["REQ"] = "";
			}
            $pass["MIN"] = "";
            $pass["MAX"] = "";
            $pass["STEP"] = "";
            $pass["SELECTOPTIONS"] = "";
            if($arr['extra'] != '') {
                $extra = json_decode($arr['extra']);
                $pass["MIN"] = $extra->min != null ? $extra->min : "";
                $pass["MAX"] = $extra->max != null ? $extra->max : "";
                $pass["STEP"] = $extra->step != null ? $extra->step : "";
                if($extra->selectopt != null) {
                    $usedSelected = false;
                    foreach($extra->selectopt as $s) {
                        $pass["SELECTOPTIONS"] .= '
<tr id="cfield-tr-selecttr-'.$globalSelectOptCounter.'">
    <td>'.htmlspecialchars($s).'</td>
    <td><div style="text-align:right;font-weight:bold;width:100%;">
    <a id="cfield-action-upoption-'.$globalSelectOptCounter.'" class="cfield-action-upoption" href="javascript:void(0);">[Up]</a>
    <a id="cfield-action-downoption-'.$globalSelectOptCounter.'" class="cfield-action-downoption" href="javascript:void(0);">[Down]</a>
    <a id="cfield-action-renameoption-'.$globalSelectOptCounter.'" class="cfield-action-renameoption" href="javascript:void(0);">[Rename]</a>
    <a id="cfield-action-deleteoption-'.$globalSelectOptCounter.'" class="cfield-action-deleteoption" href="javascript:void(0);">[Delete]</a>
    </div></td>
</tr>';
                        $insert = "";
                        if(!$usedSelected && $s == $arr["default"]) {
                            $usedSelected = true;
                            $insert = "selected";
                        }
                        $pass["SELECTOPTIONS4REAL"] .= '<option id="cfield-field-defaultoption-option-'.$globalSelectOptCounter.'" value="'.htmlspecialchars($s).'" '.$insert.'>'.htmlspecialchars($s).'</option>';
                        $globalSelectOptCounter++;
                    }
                    $pass["DEFAULTSELECTED"] = $usedSelected ? "" : "selected";
                }
            }

			// A lame solution but I don't feel like solving this problem at 5 AM...
			$selected = array(false, false, false, false, false, false, false);
			switch($arr["type"]) {
				case "text":
					$selected[0] = true;
					break;
				case "password":
					$selected[1] = true;
					break;
				case "checkbox":
					$selected[2] = true;
					break;
				case "select":
					$selected[3] = true;
					break;
				case "tel":
					$selected[4] = true;
					break;
				case "url":
					$selected[5] = true;
					break;
				case "email":
					$selected[6] = true;
					break;
				case "range":
					$selected[7] = true;
					break;
                case "week":
                    $selected[8] = true;
                    break;
                case "number":
                    $selected[9] = true;
                    break;
			}
			$pass["TYPELIST"] = $style->createInput('select', 'cfield-field-typelist-'.$arr["id"], '', array('id' => 'cfield-field-typelist-'.$arr["id"], 'class' => 'cfield-field cfield-field-'.$arr["id"].' cfield-field-typelist'),
				array(
					array('text' => '--- Standard ---', 'value' => 'standard', 'disabled' => true),
					array('text' => 'Text', 'value' => 'text', 'selected' => $selected[0]),
					array('text' => 'Password', 'value' => 'password', 'selected' => $selected[1]),
					array('text' => 'Checkbox', 'value' => 'checkbox', 'selected' => $selected[2]),
					array('text' => 'Select Box', 'value' => 'select', 'selected' => $selected[3]),
					array('text' => '--- HTML5 ---', 'value' => 'html5', 'disabled' => true),
                    array('text' => 'Number', 'value' => 'number', 'selected' => $selected[9]),
					array('text' => 'Telephone #', 'value' => 'tel', 'selected' => $selected[4]),
					array('text' => 'URL', 'value' => 'url', 'selected' => $selected[5]),
					array('text' => 'Email', 'value' => 'email', 'selected' => $selected[6]),
					array('text' => 'Range', 'value' => 'range', 'selected' => $selected[7]),
                    array('text' => 'Week', 'value' => 'week', 'selected' => $selected[8])
				)
			);
			$pass["DEFAULTVALUE"] = htmlspecialchars($arr["default"]);
			$pass["REGEX"] = htmlspecialchars($arr["regex"]);
			$boxes .= $style->replaceVar("tpl/aorderform/orderfieldbox.tpl", $pass);
		}
        echo $style->replaceVar("tpl/aorderform/top.tpl", array("GLOBALSELECTOPTIONCOUNTER" => $globalSelectOptCounter));
        echo $boxes;
		echo $style->replaceVar("tpl/aorderform/bottom.tpl");
	}
	
}

?>
