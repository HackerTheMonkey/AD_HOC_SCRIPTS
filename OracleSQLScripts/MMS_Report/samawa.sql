-- samawa

Select t.sender_msisdn "Sender MSISDN",sum(t.no_of_pages_items) "No of MMS's",
round(Sum(t.volume/1024),3) "Size in KB",Sum(t.charge_fee) "Fee (Cent)"
From MMS_CDR_JULY_2007 t Where t.cdr_type='3' 
And t.charge_party_type='3' And t.charge_fee <> '0' And t.charge_result='0'
And t.source_device='4' And t.dest_device='0' And t.pay_type='1' And
(
    t.sender_msisdn between '9647706870000' and	'9647706879999' or
    t.sender_msisdn Between '9647706880000' and	'9647706889999'   

   
)
Group By t.sender_msisdn;