tableextension 50100 SalesLineExt extends "Sales Line"
{
    fields
    {
        field(50100; "ZY Line Position"; Integer)
        {
            Caption = 'Line Position';
            DataClassification = CustomerContent;
        }
    }

    trigger OnAfterInsert()
    begin
        "ZY Line Position" := FindLastLinePosition() + 1;
        Rec.Modify();
    end;

    procedure FindLastLinePosition(): Integer
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", "Document Type");
        SalesLine.SetRange("Document No.", "Document No.");
        SalesLine.SetCurrentKey("ZY Line Position");
        SalesLine.Ascending(true);
        if SalesLine.FindLast() then
            exit(SalesLine."ZY Line Position")
        else
            exit(0);
    end;
}