TEXT_ARR <-
[
    [" \x04[CREDITS] \x01Map by by\x03 HeeChan", 0],
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
