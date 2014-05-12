<?php  
class ControllerCommonContentEmbed extends Controller {
	public function index($route, $args) {
		return $this->getChild($route, $args);
	}
}
?>