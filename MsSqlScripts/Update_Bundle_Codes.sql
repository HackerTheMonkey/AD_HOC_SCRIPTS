-- Deleting the ComponentBundle: 30-2012 from the Bundle: 30-85968
delete from scload..LoadBundleExpansion where BundleBillCode='30-85968' and ComponentBundle='30-2012';

delete from SCRules..DimProductBundleExpansion where BundleBillCodeFactKey=
(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='30-85968') and
ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='30-2012');

-- Deleting the ComponentBundle: 32-2006 from the Bundle: 32-263115
delete from scload..LoadBundleExpansion where BundleBillCode='32-263115' and ComponentBundle='32-2006';

delete from SCRules..DimProductBundleExpansion where BundleBillCodeFactKey=
(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='32-263115') and
ComponentBundleFactKey=(select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='32-2006');

/*
	Update new Bundle Code in the LoadExpansionTable
*/
update scload..LoadBundleExpansion set ComponentBundle = '30-2005' where BundleBillCode = '30-43395' and ComponentBundle = '20-2005';

/*
	Update the SCRules..DimProductBundleExpansion table
*/

-- Get the old ComponentBundleFactKey
select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='20-2005';

-- Get the new ComponentBundleFactKey
select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='30-2005';

select * from SCRules..DimProductBundleExpansion where 
	BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='30-43395') and
	ComponentBundleFactKey = '642924';

-- Update the ComponentBundleFactKey to the new value of the new ComponentBundle
update SCRules..DimProductBundleExpansion set ComponentBundleFactKey = '648219' where 
	BundleBillCodeFactKey = (select BillCodeFactKey from scrules..DimProductBillCodeFactKey where billcode='30-43395') and
	ComponentBundleFactKey = '642924';
