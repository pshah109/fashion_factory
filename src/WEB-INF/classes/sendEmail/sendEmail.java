package sendEmail;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class sendEmail {

public void sendTextEmail( String toAddress,
                           String subject, String message) throws AddressException,
MessagingException {

        // sets fashion factory gmail values Test
        String host = "smtp.gmail.com";
        String port = "587";
        final String userName = "noreply.fashionfactory@gmail.com";
        final String password = "fashionfactory1234";

        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
                public PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(userName, password);
                }
        };

        Session session = Session.getInstance(properties, auth);

        // creates a new e-mail message
        Message msg = new MimeMessage(session);

        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        // set message as html
        msg.setContent(message,"text/html");

        // sends the e-mail
        Transport.send(msg);

}

}
