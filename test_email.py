import smtplib
from email.message import EmailMessage
import ssl

# --- 1. Configure your email information ---

# SMTP server address and port (using Gmail as an example)
# - Gmail: ('smtp.gmail.com', 587)
# - 163 Mail: ('smtp.163.com', 587 or 465)
# - QQ Mail: ('smtp.qq.com', 587 or 465)
SMTP_SERVER = 'smtp.163.com'
SMTP_PORT = 465  # For STARTTLS

SENDER_EMAIL = '17799138830@163.com'       # Your email address
SENDER_PASSWORD = 'SAcjU37U7dH5VsXA'  # Your "application-specific password"
RECEIVER_EMAIL = 'yangjunx21@gmail.com' # Recipient email address

# ----------------------------


# --- 2. Create email message ---
msg = EmailMessage()
msg['Subject'] = '[163 Mail Port 465] Test Email' # Email subject
msg['From'] = SENDER_EMAIL                   # Sender
msg['To'] = RECEIVER_EMAIL                     # Recipient
msg.set_content('Hello,\n\nThis is the email body sent using 163 Mail port 465.\n\nBest regards!') # Email body

print("Creating email...")

# --- 3. Connect and send email (using SMTP_SSL) ---
try:
    # Create a default SSL context
    context = ssl.create_default_context()
    
    print(f"Connecting via SSL to {SMTP_SERVER}:{SMTP_PORT}...")
    
    # Use smtplib.SMTP_SSL(), which establishes SSL connection immediately
    with smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT, context=context) as server:
        
        # Login to SMTP server
        # Note: SENDER_PASSWORD must be the "authorization code" generated in 163 Mail settings
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        print("Login successful!")
        
        # Send email
        server.send_message(msg)
        print(f"Email successfully sent to {RECEIVER_EMAIL}!")
        
        # (Connection will automatically close with 'with' statement)

except smtplib.SMTPException as e:
    print(f"SMTP error: {e}")
except Exception as e:
    print(f"Error sending email: {e}")