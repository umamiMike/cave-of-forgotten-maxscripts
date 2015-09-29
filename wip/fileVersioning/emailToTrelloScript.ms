if emailToTrelloRoll != undefined do (destroydialog emailToTrelloRoll)

fromAdress = "michaelwchastain@gmail.com"
toAdress = "mikechastain+4ebc0d779dc3112f540008c0+54e4ea36f1c96db7e476e196+7a31170c19c1144498bd554ec1e0f54c52d437ae@boards.trello.com"
theSub = "This is a test of email directly from max SUBJECT"
theBod = "This is a test of email directly from max BODY"

fn sendToTrello fmAd toAd sub bod = (
	



MailMessage = dotNetObject "System.Net.Mail.MailMessage"
MailAdressFrom = dotNetObject "System.Net.Mail.MailAddress" fmAd
MailMessage.From = MailAdressFrom
MailAdressTo = dotNetObject "System.Net.Mail.MailAddress" toAd
MailMessage.To.Add MailAdressTo
MailMessage.Subject = sub
MailMessage.Body = bod


Client = dotNetObject "System.Net.Mail.SmtpClient"
 
Client.Host = "smtp.gmail.com"
 
/*for hotmail use
Client.Host = "smtp.live.com"
*/
 
 Client.EnableSsl = true;
 NetworkCred = dotNetObject "System.Net.NetworkCredential"
 NetworkCred.UserName = "michaelwchastain@gmail.com"
 NetworkCred.Password = "bartok"
 Client.UseDefaultCredentials = true
 Client.Credentials = NetworkCred
 Client.Port = 587
 Client.Send MailMessage
 
 
 )
 
 
 
rollout emailToTrelloRoll "email to Trello" width:232 height:296
(
	edittext fmEdt "" pos:[55,10] width:161 height:15 text:fromAdress
	label lbl1 "from" pos:[20,10] width:25 height:13 
	edittext toEdt "" pos:[56,34] width:160 height:15 text:toAdress
	label lbl2 "to" pos:[22,32] width:25 height:13
	edittext subEdt "" pos:[18,89] width:199 height:15 text:theSub
	label lbl3 "subject" pos:[25,71] width:33 height:13
	edittext bodEdt "" pos:[17,127] width:199 height:120 text:theBod
	label lbl4 "body" pos:[24,112] width:33 height:13
	button sndBtn "send" pos:[24,264] width:192 height:24
	
	--fmEdt.text = "tiuts"
	
	on sndBtn pressed do
		(
			
			sendToTrello fmEdt.text toEdt.text subEdt.text  bodEdt.text
	
	)
)

createDialog emailToTrelloRoll