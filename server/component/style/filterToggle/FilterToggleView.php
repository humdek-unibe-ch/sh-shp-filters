<?php
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */
?>
<?php
require_once __DIR__ . "/../filter/FilterView.php";

/**
 * The view class of the filterToggle style component.
 */
class FilterToggleView extends FilterView
{
    /* Private Properties******************************************************/

    /**
     * DB field 'lable' (empty string).
     * The label to be rendered on the filter button.
     */
    private $label;

    /**
     * DB field 'value' (empty string).
     * The value to be filtered against.
     */
    private $value;


    /**
     * DB field 'type' (primary).
     * The color of the button.
     */
    private $type;

    /* Constructors ***********************************************************/

    /**
     * The constructor.
     *
     * @param object $model
     *  The model instance of the footer component.
     */
    public function __construct($model)
    {
        parent::__construct($model);
        $this->type = $this->model->get_db_field("type", "primary");
        $this->value = $this->model->get_db_field("value");
        $this->label = $this->model->get_db_field("label");
        $this->set_filter_value(array(array(
            "op" => "=",
            "val" => $this->value
        )));
        $this->set_filter_type("toggle");
        $this->css .= " d-inline-block";
    }

    /* Private  Methods *******************************************************/

    /**
     * The function to render the filter. This is the redefinition of the
     * abstract parent method.
     */
    protected function output_filter() {
        $is_active = isset($_SESSION['data_filter'][$this->data_source][$this->name][0]) &&
            in_array($this->value, $_SESSION['data_filter'][$this->data_source][$this->name][0]);
        if($this->label === "") {
            $this->label = $this->name;
        }
        require __DIR__ . "/tpl_filter_toggle.php";
    }

    /* Public Methods *********************************************************/
    /**
     * Get js include files required for this component. This overrides the
     * parent implementation.
     *
     * @retval array
     *  An array of js include files the component requires.
     */
    public function get_css_includes($local = array())
    {
        if (empty($local)) {
            if (DEBUG) {
                $local = array(__DIR__ . "/css/filterToggle.css");
            } else {
                $local = array(__DIR__ . "/../../../../css/ext/filters.min.css?v=" . rtrim(shell_exec("git describe --tags")));
            }
        }
        return parent::get_css_includes($local);
    }

    /**
     * Get js include files required for this component. This overrides the
     * parent implementation.
     *
     * @retval array
     *  An array of js include files the component requires.
     */
    public function get_js_includes($local = array())
    {
        if (empty($local)) {
            if (DEBUG) {
                $local = array(__DIR__ . "/../filter/js/filter.js", __DIR__ . "/js/filterToggle.js");
            } else {
                $local = array(__DIR__ . "/../../../../js/ext/filters.min.js?v=" . rtrim(shell_exec("git describe --tags")));
            }
        }
        return parent::get_js_includes($local);
    }
}
?>
