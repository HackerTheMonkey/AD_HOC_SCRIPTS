Insert into scload..LoadBundleExpansion SELECT * from scload..LoadBundleExpansionLoad;

select * from scload..LoadBundleExpansion t inner join scload..LoadBundleExpansionLoad g
on t.BundleBillCode = g.BundleBillCode and t.ComponentBundle = t.ComponentBundle;

select COUNT(*) from scload..LoadBundleExpansion;
select count(*) from scload..LoadBundleExpansionLoad;

Insert into scload..LoadBundleExpansion SELECT * from scload..LoadBundleExpansionLoad;
print 'Error: ' + str(@@error);
print 'RowCount: ' + str(@@RowCount);
-- Find which code is causing the constraint voilation error
select * from scload..LoadBundleExpansionLoad a inner join scload..LoadBundleExpansion b
on a.BundleBillCode = b.BundleBillCode and a.ComponentBundle = b.ComponentBundle;

select * from scload..LoadBundleExpansionLoad t where t.BundleBillCode='30-85968' and t.ComponentBundle='30-2007';

-- Take that code out of the table and resume the run of the procedure from where it left off
select * into scload..tmp_hk_LoadBundleExpansionLoad from scload..LoadBundleExpansionLoad t where t.BundleBillCode='30-85968' and t.ComponentBundle='30-2007';
select * from scload..tmp_hk_LoadBundleExpansionLoad;
delete from scload..LoadBundleExpansionLoad where BundleBillCode='30-85968' and ComponentBundle='30-2007';

-- Resume running the rest of the procedure
Truncate Table SCRules..DimProductBundleExpansion;

INSERT INTO SCRules..DimProductBundleExpansion 
(BundleBillCodeFactKey ,ComponentBundleFactKey ,DateKey ,DisabledFlag ,QuantityMultiplier) 
SELECT fk.BillCodeFactKey, fk2.BillCodeFactKey, 40568, b.disabledflag, b.quantitymultiplier 

from scload..LoadBundleExpansion b 

inner join scrules..DimProductBillCodeFactKey fk 
on b.bundlebillcode = fk.BillCode 

inner join scrules..DimProductBillCodeFactKey fk2 
on b.componentbundle = fk2.BillCode;

print 'Error: ' + str(@@error);
print 'RowCount: ' + str(@@RowCount);

-- Truncate the LoadBundleExpansionLoad that will be loaded by blizoo later on
Truncate Table scload..LoadBundleExpansionLoad;
print 'Error: ' + str(@@error);
print 'RowCount: ' + str(@@RowCount);


-- Deleting the ComponentBundle: 30-2012 from the Bundle: 30-85968
select * from scload..LoadBundleExpansion where BundleBillCode='30-303853' and ComponentBundle='30-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='30-303853'	and ComponentBundle='30-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='30-302820'	and ComponentBundle='30-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='30-302821'	and ComponentBundle='30-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='30-310394'	and ComponentBundle='30-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='30-304276'	and ComponentBundle='30-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='30-304909'	and ComponentBundle='30-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='31-303642'	and ComponentBundle='31-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='32-308495'	and ComponentBundle='32-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='32-307018'	and ComponentBundle='32-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='32-308284'	and ComponentBundle='32-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='32-309129'	and ComponentBundle='32-2031';
select * from scload..LoadBundleExpansion where BundleBillCode='30-127146'	and ComponentBundle='30-2013';
select * from scload..LoadBundleExpansion where BundleBillCode='30-127147'	and ComponentBundle='30-2007';
select * from scload..LoadBundleExpansion where BundleBillCode='30-85969'	and ComponentBundle='30-2007';
select * from scload..LoadBundleExpansion where BundleBillCode='6-660'	and ComponentBundle='6-2007';

delete from scload..LoadBundleExpansion where BundleBillCode='30-303853' and ComponentBundle='30-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='30-303853'	and ComponentBundle='30-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='30-302820'	and ComponentBundle='30-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='30-302821'	and ComponentBundle='30-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='30-310394'	and ComponentBundle='30-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='30-304276'	and ComponentBundle='30-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='30-304909'	and ComponentBundle='30-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='31-303642'	and ComponentBundle='31-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='32-308495'	and ComponentBundle='32-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='32-307018'	and ComponentBundle='32-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='32-308284'	and ComponentBundle='32-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='32-309129'	and ComponentBundle='32-2031';
delete from scload..LoadBundleExpansion where BundleBillCode='30-127146'	and ComponentBundle='30-2013';
delete from scload..LoadBundleExpansion where BundleBillCode='30-127147'	and ComponentBundle='30-2007';
delete from scload..LoadBundleExpansion where BundleBillCode='30-85969'	and ComponentBundle='30-2007';
delete from scload..LoadBundleExpansion where BundleBillCode='6-660'	and ComponentBundle='6-2007';

delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-303853'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-302820'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-302821'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-310394'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-304276'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-304909'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '31-303642'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '31-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-308495'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-307018'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-308284'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-309129'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '32-2031');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-127146'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2013');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-127147'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2007');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-85969'	) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '30-2007');
delete from scrules..DimProductBundleExpansion where BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '6-660'	    ) and ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where BillCode = '6-2007');


delete from SCRules..DimProductBundleExpansion where BundleBillCodeFactKey=
(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='30-85968') and
ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='30-2012');

-- Deleting the ComponentBundle: 32-2006 from the Bundle: 32-263115
select * from scload..LoadBundleExpansion where BundleBillCode='32-156081' and ComponentBundle='32-2006';

delete from SCRules..DimProductBundleExpansion where BundleBillCodeFactKey=
(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='32-263115') and
ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='32-2006');

-- Update Bundles & Components
select * from scload..LoadBundleExpansion where BundleBillCode='32-156081' and ComponentBundle = '32-2031';
update scload..LoadBundleExpansion set ComponentBundle = '32-2011' where BundleBillCode='32-156081' and ComponentBundle = '32-2031';

select * from scload..LoadBundleExpansion where BundleBillCode='32-170835' and ComponentBundle = '32-2031';
update scload..LoadBundleExpansion set ComponentBundle = '32-2011' where BundleBillCode='32-170835' and ComponentBundle = '32-2031';
