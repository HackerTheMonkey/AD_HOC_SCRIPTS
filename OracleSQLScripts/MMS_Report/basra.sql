-- Basra
Select t.sender_msisdn "Sender MSISDN",sum(t.no_of_pages_items) "No of MMS's",
round(Sum(t.volume/1024),3) "Size in KB",Sum(t.charge_fee) "Fee (Cent)"
From MMS_CDR_JULY_2007 t Where t.cdr_type='3' 
And t.charge_party_type='3' And t.charge_fee <> '0' And t.charge_result='0'
And t.source_device='4' And t.dest_device='0' And t.pay_type='1' And
(
    t.sender_msisdn between '9647701102000' and	'9647701102999' or
    t.sender_msisdn between '9647701119410' and	'9647701119419' or
    t.sender_msisdn between '9647703100000' and	'9647703109999' or
    t.sender_msisdn between '9647703110000' and	'9647703119999' or
    t.sender_msisdn between '9647703120000' and	'9647703129999' or
    t.sender_msisdn between '9647703130000' and	'9647703139999' or
    t.sender_msisdn between '9647703140000' and	'9647703149999' or
    t.sender_msisdn between '9647703150000' and	'9647703159999' or
    t.sender_msisdn between '9647703160000' and	'9647703169999' or
    t.sender_msisdn between '9647703170000' and	'9647703179999' or
    t.sender_msisdn between '9647703180000' and	'9647703189999' or
    t.sender_msisdn between '9647703190000' and	'9647703199999' or
    t.sender_msisdn between '9647701119420' and	'9647701119429' or
    t.sender_msisdn between '9647701119440' and	'9647701119449' or
    t.sender_msisdn between '9647703200000' and	'9647703209999' or
    t.sender_msisdn between '9647703210000' and	'9647703219999' or
    t.sender_msisdn between '9647703220000' and	'9647703229999' or
    t.sender_msisdn between '9647703230000' and	'9647703239999' or
    t.sender_msisdn between '9647703240000' and	'9647703249999' or
    t.sender_msisdn between '9647703250000' and	'9647703259999' or
    t.sender_msisdn between '9647703260000' and	'9647703269999' or
    t.sender_msisdn between '9647703270000' and	'9647703279999' or
    t.sender_msisdn between '9647705600000' and	'9647705609999' or
    t.sender_msisdn between '9647705610000' and	'9647705619999' or
    t.sender_msisdn between '9647705620000' and	'9647705629999'
)
Group By t.sender_msisdn;