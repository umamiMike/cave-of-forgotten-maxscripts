fromAdress = "michaelwchastain@gmail.com"
toAdress = "mikechastain+omu7boymkrtswjaajpui@boards.trello.com"
theSub = "This is a test of email directly from max SUBJECT"
theBody = "This is a test of email directly from max BODY"


MailMessage = dotNetObject "System.Net.Mail.MailMessage"
MailAdressFrom = dotNetObject "System.Net.Mail.MailAddress" FromAdress
MailMessage.From = MailAdressFrom
MailAdressTo = dotNetObject "System.Net.Mail.MailAddress" ToAdress
MailMessage.To.Add MailAdressTo
MailMessage.Subject = theSub
MailMessage.Body = theBod


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