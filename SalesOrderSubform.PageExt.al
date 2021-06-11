pageextension 50100 SalesOrderSubformExt extends "Sales Order Subform"
{
    layout
    {
        modify("Line No.")
        {
            Visible = true;
        }
        moveafter(Type; "Line No.")

        addbefore(Type)
        {
            field("ZY Line Position"; Rec."ZY Line Position")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        addbefore("F&unctions")
        {
            action("Move Up")
            {
                Caption = 'Move Up';
                ApplicationArea = All;
                Image = MoveUp;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Move current line up.';

                trigger OnAction()
                begin
                    MoveSalesLine(-1);
                end;
            }
            action("Move Down")
            {
                Caption = 'Move Down';
                ApplicationArea = All;
                Image = MoveDown;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Move current line down.';

                trigger OnAction()
                begin
                    MoveSalesLine(1);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("ZY Line Position");
        Rec.Ascending(true);
    end;

    Local procedure MoveSalesLine(MoveBy: Integer)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."Document No.");
        SalesLine.SetRange("ZY Line Position", Rec."ZY Line Position" + MoveBy);
        if SalesLine.FindFirst then begin
            SalesLine."ZY Line Position" -= MoveBy;
            SalesLine.Modify();
            Rec."ZY Line Position" += MoveBy;
            Rec.Modify();
        end;
    end;
}