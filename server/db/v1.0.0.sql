-- add plugin entry in the plugin table
INSERT IGNORE INTO plugins (name, version) 
VALUES ('filters', 'v1.0.0');

-- add filterToggle style
INSERT IGNORE INTO `styleGroup` (`id`, `name`, `description`, `position`) VALUES (NULL, 'Filter', 'Filter styles allow to filter data sets and store the filter state in the session. This allows to filter all styles using the same data source with only one filter', 56);
SET @id_group = LAST_INSERT_ID();
INSERT IGNORE INTO `styles` (`id`, `name`, `id_type`, `id_group`, `description`) VALUES (NULL, 'filterToggle', '0000000002', @id_group, 'Create a toggle button which will enable or disable a filter on a set of data.');
SET @id_style = LAST_INSERT_ID();

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'data-source');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The source of the data to be filtered.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'label');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The name to be rendered on the filter button.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'name');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The name of the table column or form field to filter on.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'value');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The value of the filter. All data sets of the data source (as specified by `data-source`) where the field (as specified by `name`) holds a value equal to the one indicated here will be selected.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'type');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The visual apperance of the button as predefined by bootstrap.');

-- add filterToggleGroup style
SET @id_group = (SELECT `id` FROM `styleGroup` WHERE `name` = 'Filter');
INSERT IGNORE INTO `styles` (`id`, `name`, `id_type`, `id_group`, `description`) VALUES (NULL, 'filterToggleGroup', '0000000002', @id_group, 'Create a group of toggle buttons which will enable or disable a filter on a set of data. Multiple active buttons are combinde with the logic or function.');
SET @id_style = LAST_INSERT_ID();

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'data-source');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The source of the data to be filtered.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'name');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The name of the table column or form field to filter on.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'labels');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The names to be rendered on the filter buttons. Use a JSON array to specify all labels. The labels must correspond to the values as specified in `values`');

INSERT IGNORE INTO `fields` (`id`, `name`, `id_type`, `display`) VALUES (NULL, 'values', 8, 0);
SET @id_field = LAST_INSERT_ID();
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The value of each filter button. All data sets of the data source (as specified by `data-source`) where the field (as specified by `name`) holds a value equal to the one indicated here will be selected. Use a JSON array to specify all values. The values must correspond to the labels as specified in `labels`.');

INSERT IGNORE INTO `fields` (`id`, `name`, `id_type`, `display`) VALUES (NULL, 'is_vertical', 3, 0);
SET @id_field = LAST_INSERT_ID();
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, 0, 'If checked, the button group is rendered as a vertical stack. If unchecked, the button group is rendered as a vertical list.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'is_fluid');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, 0, 'If checked, the button group is streched to fill 100% of the available width. If unchecked, the button group is stretched to fit all text within each button but never more than available space.');

SET @id_field = (SELECT `id` FROM `fields` WHERE `name` = 'type');
INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `default_value`, `help`) VALUES (@id_style, @id_field, NULL, 'The visual apperance of the buttons as predefined by bootstrap.');

INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `help`)
SELECT `id`, @id_field, "Allows to assign CSS classes to the root item of the style." FROM `styles` WHERE `name` = 'filterToggle';

INSERT IGNORE INTO `styles_fields` (`id_styles`, `id_fields`, `help`)
SELECT `id`, @id_field, "Allows to assign CSS classes to the root item of the style." FROM `styles` WHERE `name` = 'filterToggleGroup';