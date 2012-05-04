-- Check the PRM engineproc parameters
-- engineproc <flow_id> <running mode: 1-->run only once, 2--> run as a daemon>
Select * From flow;
Select * From flow_def t Where t.flow_id=11;
Select * From flow_module_def t Where t.module_id In (Select t.module_id From flow_def t Where t.flow_id=11) And t.module_id=42;
Select * From flow_module_attr t Where t.module_id In (Select t.module_id From flow_def t Where t.flow_id=11) And t.module_id=43;
-- Read DS module
Select * From physical_ds_def t Where t.datastore_name='PRM_INTER_VOICE_NET';
Select * From logical_ds_def t Where t.datastore_name='PRM_INTER_VOICE_NET';
Select * From process_schema t Where t.proc_schema_id=12;
Select * From processed_event t Where t.proc_schema_id=12;
Select * From process_flow t Where t.process_step_id=57;
-- if rule_type = 2, expr mapping list, 1 value mapping, 3 process flow
Select * From expr_mapping_list t Where t.rule_id=82;
Select * From Mapping_Rule t Where t.rule_id=11;
Select * From Mapping_List t Where t.mapping_id;
-- Charging Module
Select * From charging_module t Where t.module_id=10;
Select * From tariff_plan;
Select * From tariff_plan_item t Where t.tariff_plan_id=1;

-- statistics module
   -- statistics view
Select * From report_view t Where t.report_view_id In (1);--get the report storage id is 11 and sum event id 
Select * From report_element t Where t.report_view_id In (1);
Select * From report_stat_def t Where t.report_view_id=1;
   -- statistics storage
   Select * From report_storage_def t Where t.report_storage_id=1;
   Select * From report_field_def t Where t.report_storage_id=1;
   
-- Flow Module
Select * From event_flow_def t Where t.module_id=12;
Select * From event_store_def t;   

