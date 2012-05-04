Set Serveroutput On;
Set Feedback Off;
Clear Screen;
Begin
            For mId In (Select Distinct trunk_manager From bs_trunk_info v /*Where v.Trunk_Manager='ZAIN_ATHEER'*/)
            Loop                              
                NSS_FRAUD_REPORT(mid.trunk_manager);
            End Loop;
End;
/            