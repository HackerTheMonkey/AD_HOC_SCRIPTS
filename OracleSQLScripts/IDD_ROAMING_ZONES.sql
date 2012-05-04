-- zone 4a
Select * From mapping_list a Where a.mapping_id=180 And 
  lower(a.note) Like '%china%';


--zone 4b
Select * From mapping_list a Where a.mapping_id=180 And 
(
  lower(a.note) Like '%bahamas%' or
  lower(a.note) like '%bermuda%' or
  lower(a.note) like '%canada%' or
  lower(a.note) like '%costa rica%' or
  lower(a.note) like '%guam%' or
  lower(a.note) like '%hong kong%' or
  lower(a.note) like '%korea%' or
  lower(a.note) like '%liechtenstein%' or
  lower(a.note) like '%malaysia%' or
  lower(a.note) like '%puerto rico%' or
  lower(a.note) like '%american samoa%' or
  lower(a.note) like '%san marino%' or
  lower(a.note) like '%singapore%' or
  lower(a.note) like '%taiwan%' or
  lower(a.note) like '%usa%' or
  lower(a.note) like '%vatican city%' or
  lower(a.note) like '%virgin%' or
  lower(a.note) like '%zimbabwe'
);

-- zone 5
Select * From mapping_list a Where a.mapping_id=180 And 
(
lower (a.note) like '%albania%' or
lower (a.note) like '%antilles%' or
lower (a.note) like '%argentina%' or
lower (a.note) like '%botswana%' or
lower (a.note) like '%brunei%' or
lower (a.note) like '%cayman%' or
lower (a.note) like '%colombia%' or
lower (a.note) like '%denmark%' or
lower (a.note) like '%faroe%' or
lower (a.note) like '%gabon%' or
lower (a.note) like '%georgia%' or
lower (a.note) like '%greece%' or
lower (a.note) like '%indonesia%' or
lower (a.note) like '%lesotho%' or
lower (a.note) like '%malawi%' or
lower (a.note) like '%malta%' or
lower (a.note) like '%mexico%' or
lower (a.note) like '%moldova%' or
lower (a.note) like '%monaco%' or
lower (a.note) like '%norway%' or
lower (a.note) like '%palestine%' or
lower (a.note) like '%russia%' or
lower (a.note) like '%slovakia%' or
lower (a.note) like '%miquelon%' or
lower (a.note) like '%swaziland%' or
lower (a.note) like '%ukraine%'
);

-- zone 6

Select * From mapping_list a Where a.mapping_id=180 And 
(
lower(a.note) like '%algeria%' or
lower(a.note) like '%andorra%' or
lower(a.note) like '%aruba%' or
lower(a.note) like '%austria%' or
lower(a.note) like '%bahrain%' or
lower(a.note) like '%barbados%' or
lower(a.note) like '%bosnia%' or
lower(a.note) like '%brazil%' or
lower(a.note) like '%bulgaria%' or
lower(a.note) like '%burundi%' or
lower(a.note) like '%christmas%' or
lower(a.note) like '%chile%' or
lower(a.note) like '%cocos isl%' or
lower(a.note) like '%croatia%' or
lower(a.note) like '%cyprus%' or
lower(a.note) like '%czech%' or
lower(a.note) like '%estonia%' or
lower(a.note) like '%germany%' or
lower(a.note) like '%ghana%' or
lower(a.note) like '%guinea%' or
lower(a.note) like '%iceland%' or
lower(a.note) like '%ireland%' or
lower(a.note) like '%japan%' or
lower(a.note) like '%kazakhstan%' or
lower(a.note) like '%kyrgyzstan%' or
lower(a.note) like '%libya%' or
lower(a.note) like '%lithuania%' or
lower(a.note) like '%luxembourg%' or
lower(a.note) like '%macedonia%' or
lower(a.note) like '%mayotte isl%' or
lower(a.note) like '%mozambique%' or
lower(a.note) like '%namibia%' or
lower(a.note) like '%papua%' or
lower(a.note) like '%philippines%' or
lower(a.note) like '%romania%' or
lower(a.note) like '%rwandese rep%' or
lower(a.note) like '%serbia%' or
lower(a.note) like '%slovenia%' or
lower(a.note) like '%st kitts%' or
lower(a.note) like '%sweden%' or
lower(a.note) like '%thailand%' or
lower(a.note) like '%turkey%' or
lower(a.note) like '%uae%' or
lower(a.note) like '%uganda%' or
lower(a.note) like '%uzbekistan%' or
lower(a.note) like '%virgin%' or
lower(a.note) like '%zambia%'
);

-- zone 7

Select * From mapping_list a Where a.mapping_id=180 And 
(
       lower(a.note) like '%angola%' or								
lower(a.note) like '%antigua%' or
lower(a.note) like '%armenia%' or
lower(a.note) like '%azerbaijan%' or
lower(a.note) like '%belarus%' or
lower(a.note) like '%belgium%' or
lower(a.note) like '%benin%' or
lower(a.note) like '%bhutan%' or
lower(a.note) like '%bolivia%' or
lower(a.note) like '%african%' or
lower(a.note) like '%congo%' or
lower(a.note) like '%dominican%' or
lower(a.note) like '%salvador%' or
lower(a.note) like '%finland%' or
lower(a.note) like '%france%' or
lower(a.note) like '%gibraltar%' or
lower(a.note) like '%guatemala%' or
lower(a.note) like '%hungary%' or
lower(a.note) like '%israel%' or
lower(a.note) like '%italy%' or
lower(a.note) like '%latvia%' or
lower(a.note) like '%macao%' or
lower(a.note) like '%mauritania%' or
lower(a.note) like '%netherlands%' or
lower(a.note) like '%new zealand%' or
lower(a.note) like '%niger%' or
lower(a.note) like '%peru%' or
lower(a.note) like '%poland%' or
lower(a.note) like '%portugal%' or
lower(a.note) like '%south africa%' or
lower(a.note) like '%spain%' or
lower(a.note) like '%tajikistan%' or
lower(a.note) like '%tunisia%' or
lower(a.note) like '%turkmenistan%' or
lower(a.note) like '%uk%' or
lower(a.note) like '%uruguay%' or
lower(a.note) like '%venezuela%'
);

-- zone 8

Select * From mapping_list a Where a.mapping_id=180 And 
(
lower(a.note) like '%anguilla%' or
lower(a.note) like '%belize%' or
lower(a.note) like '%burkina fasso%' or
lower(a.note) like '%cameroon%' or
lower(a.note) like '%comoros%' or
lower(a.note) like '%cot d’voire%' or
lower(a.note) like '%dcongo%' or
lower(a.note) like '%dominica%' or
lower(a.note) like '%ecuador%' or
lower(a.note) like '%egypt%' or
lower(a.note) like '%guinea%' or
lower(a.note) like '%polynesia%' or
lower(a.note) like '%gambia%' or
lower(a.note) like '%guadeloupe%' or
lower(a.note) like '%iran%' or
lower(a.note) like '%jamaica%' or
lower(a.note) like '%jordan%' or
lower(a.note) like '%kenya%' or
lower(a.note) like '%kuwait%' or
lower(a.note) like '%lebanon%' or
lower(a.note) like '%liberia%' or
lower(a.note) like '%madagascar%' or
lower(a.note) like '%maldives%' or
lower(a.note) like '%martinique%' or
lower(a.note) like '%mongolia%' or
lower(a.note) like '%montserrat%' or
lower(a.note) like '%morocco%' or
lower(a.note) like '%nicaragua%' or
lower(a.note) like '%oman%' or
lower(a.note) like '%panama%' or
lower(a.note) like '%paraguay%' or
lower(a.note) like '%reunion%' or
lower(a.note) like '%saudi arabia%' or
lower(a.note) like '%senegal%' or
lower(a.note) like '%seychelles%' or
lower(a.note) like '%lucia%' or
lower(a.note) like '%grenadines%' or
lower(a.note) like '%sudan%' or
lower(a.note) like '%switzerland%' or
lower(a.note) like '%tanzania%' or
lower(a.note) like '%togo%' or
lower(a.note) like '%trinidad%' or
lower(a.note) like '%caicos islands%'
);

-- zone 9

Select * From mapping_list a Where a.mapping_id=180 And 
(
        lower(a.note) like '%bangladesh%' Or
        lower(a.note) like '%cape verde%' Or
        lower(a.note) like '%chad%' or
        lower(a.note) like '%djibouti%' or
        lower(a.note) like '%fiji%' or
        lower(a.note) like '%french guiana%' or
        lower(a.note) like '%grenada%' Or
        lower(a.note) like '%haiti%' or
        lower(a.note) like '%honduras%' Or
        lower(a.note) like '%iraq%' or
        lower(a.note) like '%mali%' or
        lower(a.note) like '%marshall isl%' Or
        lower(a.note) like '%mauritius%' or
        lower(a.note) like '%myanmar%' or
        lower(a.note) like '%nepal%' or
        lower(a.note) like '%nigeria%' Or
        lower(a.note) like '%qatar%' or
        lower(a.note) like '%rodriguez%' or
        lower(a.note) like '%sierra leone%' or
        lower(a.note) like '%sri lanka%' or
        lower(a.note) like '%syria%'

);


--zone 10

Select * From mapping_list a Where a.mapping_id=180 And 
(
        lower(a.note) like '%falkland%' or
        lower(a.note) like '%greenland%' or
        lower(a.note) like '%india%' or
        lower(a.note) like '%korea%' or
        lower(a.note) like '%laos%' or
        lower(a.note) like '%caledonia%' or
        lower(a.note) like '%pakistan%' or
        lower(a.note) like '%helena%'

);

--zone 11
Select * From mapping_list a Where a.mapping_id=180 And 
(
        lower(a.note) like '%cambodia%' or 
        lower(a.note) like '%eritrea%' or
        lower(a.note) like '%ethiopia%' or
        lower(a.note) like '%micronesia%' or
        lower(a.note) like '%palau%' or
        lower(a.note) like '%samoa%' or
        lower(a.note) like '%yemen%'

);


-- zone 12

Select * From mapping_list a Where a.mapping_id=180 And 
(
       lower(a.note) like '%afghanistan%' or
lower(a.note) like '%antarctica%' or
lower(a.note) like '%australia%' or
lower(a.note) like '%cook islands%' or
lower(a.note) like '%cuba%' or
lower(a.note) like '%guinea bissau%' or
lower(a.note) like '%guyana%' or
lower(a.note) like '%kiribati%' or
lower(a.note) like '%niue%' or
lower(a.note) like '%mariana%' or
lower(a.note) like '%sao%' or
lower(a.note) like '%somalia%' or
lower(a.note) like '%suriname%' or
lower(a.note) like '%tonga%' or
lower(a.note) like '%vanuatu%' or
lower(a.note) like '%vietnam%'
);

-- zone 13

Select * From mapping_list a Where a.mapping_id=180 And 
(
        lower(a.note) like '%nauru%' or
        lower(a.note) like '%norfolk%' or
        lower(a.note) like '%pitcairne%' or
        lower(a.note) like '%solomon%' or
        lower(a.note) like '%thuraya%' or
        lower(a.note) like '%tuvalu%'
);

