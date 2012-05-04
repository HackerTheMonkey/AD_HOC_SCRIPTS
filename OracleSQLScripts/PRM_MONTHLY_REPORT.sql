-- PRM Reports
-- SPCP Report
   -- Accumulation Tables
   -- Basing on the main table that hold the share rate, no need to genearte the report to have the below calculation
   Select 
              b.service_name,
              a.serv_code,
              substr(a.bill_date,1,6) accumulate_month,
              b.price,
              Sum(a.service_fee)/b.price no_of_sms,
              Sum(a.service_fee) total_fee,
              c.share_rate Revenue_Sharing_Rate,
              Sum(a.service_fee) * (1 - c.share_rate) Asiacel_Share,
              Sum(a.service_fee) * c.share_rate SP_Share
          From prm.accumulate_spcp_record a,rating.dsmp_product_view b,bs_spcp_share_rate c
          Where 
                a.serv_code=b.serv_id And
                a.start_date >= b.effect_time And
                a.End_Date <= b.expire_time And
                a.bill_date Like '200804%' And
                a.service_fee > 0 And
                a.sp_code = c.spcp_id And
                a.serv_code = c.serv_code
          Group By
                b.service_name,
                a.serv_code,
                substr(a.bill_date,1,6),
                b.price,
                c.share_rate;
                
                -- the report have to be generated for the specific partner so that the share rate info will ne inserted into the
                -- spcp_account_info table.
                -- PRM Reports
               Select 
                          b.service_name,
                          a.serv_code,
                          substr(a.bill_date,1,6) accumulate_month,
                          --a.service_fee,
                          b.price,
                          Sum(a.service_fee)/b.price no_of_sms,
                          Sum(a.service_fee) total_fee,
                          c.share_ratio sharing_rate,
                          Sum(a.service_fee) * (1 - c.share_ratio) Asiacell_Share,
                          Sum(a.service_fee) * c.share_ratio SP_Share
                      From prm.accumulate_spcp_record a,rating.dsmp_product_view b,spcp_account_info c
                      Where 
                            a.serv_code=b.serv_id And
                            a.start_date >= b.effect_time And
                            a.End_Date <= b.expire_time And
                            a.bill_date Like '200804%' And
                            a.service_fee > 0 And
                            substr(a.bill_date,1,6)=c.billingcycle_code And
                            a.serv_code=c.serv_code
                      Group By
                            b.service_name,
                            a.serv_code,
                            substr(a.bill_date,1,6),
                            b.price,
                            c.share_ratio;