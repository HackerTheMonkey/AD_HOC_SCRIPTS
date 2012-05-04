Select a.sub_id From inf_products a Where a.product_id='S1162' And to_char(a.create_date,'yyyymm')='200809';
Select * From pdm_prodtab t Where lower(t.prod_name) Like '%gprs%';

-- Monthly report for MMS_GPRS_FREE service package (PPS_MMS&GPRS_FREE)
Select c.city,Count(*) no_of_activations From inf_products a,inf_subscriber_all b,tmp_numbering_plan c
Where 
              a.product_id='S1162' And
              to_char(a.create_date,'yyyymm')='200809' And
              a.sub_id=b.sub_id And
              substr(b.imsi,1,7)=c.imsi_range
Group By c.city
Order By no_of_activations Desc;

-- Monthly report for MMS activations only (PPS_MMS)
Select c.city,Count(*) no_of_activations From inf_products a,inf_subscriber_all b,tmp_numbering_plan c
Where 
              a.product_id='S1161' And
              to_char(a.create_date,'yyyymm')='200809' And
              a.sub_id=b.sub_id And
              substr(b.imsi,1,7)=c.imsi_range
Group By c.city
Order By no_of_activations Desc;

-- Monthly report for GPRS activations (PPS_GPRS)
Select c.city,Count(*) no_of_activations From inf_products a,inf_subscriber_all b,tmp_numbering_plan c
Where 
              a.product_id='S1122' And
              to_char(a.create_date,'yyyymm')='200809' And
              a.sub_id=b.sub_id And
              substr(b.imsi,1,7)=c.imsi_range
Group By c.city
Order By no_of_activations Desc;

Create Table TMP_NUMBERING_PLAN (IMSI_RANGE VARCHAR2(100),CITY VARCHAR2(100));
Select * From CCARE.TMP_NUMBERING_PLAN For Update;