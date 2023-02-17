function SetHP(team, amount) // entity RunScriptCode SetHP(3, 400);
{
    local p = null;
    while(null != (p = Entities.FindByClassname(p, "player")))
    {
        if(p != null && p.IsValid() && p.GetTeam() == team && p.GetHealth() > 0)
        {
            p.SetHealth(400);
        }
    }
}

TEXT_ARR <- [
    [" \x04[CREDITS] \x01Stripper by\x03 Pn", 0],
];

function CreditMessage(text_c, delay)
{
    if(text_c > (TEXT_ARR.len() - 1) || text_c < 0)
    return;
    ScriptPrintMessageChatAllDelay(text_c, delay);
}

function ScriptPrintMessageChatAllDelay(message, delay)
{
    EntFireByHandle(self, "RunScriptCode", "PrintMessageN("+TEXT_ARR[message][1]+");", delay, null, null);
}

function PrintMessageN(text)
{
    ScriptPrintMessageChatAll(""+TEXT_ARR[text][0]);
}
