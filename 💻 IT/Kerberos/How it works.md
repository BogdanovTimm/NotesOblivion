#                  How it works

##                 Simple version

```
1. User -------[User_Principal, Application_Principal]------> Authentication_Server  ---> Database

2. User <------[Ticket_Granting_Ticket, Session_Key1]-------- Authentication_Server  <--- Database

3. User ---[Ticket_Granting_Ticket, Application_Principal]--> Ticket_Granting_Server ---> Database

4. User <-----------------[Service_Ticket]------------------ Ticket_Granting_Server <--- Database

5. User ---------[Service_Ticket]-------> Application_Server
```

##                 Creating of a **Ticket Granting Ticket**

Steps:
1. User asks for a **Ticket_Granting_Ticket** from the **Authentication_Server** from the **KDC**.
2. **Authentication_Server** checks **Database** for user's credentials.
3. If previous step was succesfull, **Authentication_Server** generates **User_Secret_Key**, using hash from the password given by user.
4. **Authentication_Server** computes **Ticket_Granting_Server_Secret_Key** and creates a **Session_Key1** ecnrypted by **User_Secret_Key**
5. **Authentication_Server** generates **Ticket_Granting_Ticket** containing:
    - **User_ID**
    - **User_Network_Address**
    - **Timestamp**
    - lifetime
    - **Session_Key1**
6. **Ticket_Granting_Server_Secret_Key** encrypts the **Ticket_Granting_Ticket**
7. User decrypts the message, using **User_Secret_Key**. He extracts **Session_Key1** and **Ticket_Granting_Ticket**
8. User creates **Authenticator1** that validates hers **Ticket_Granting_Ticket**
9. User uses **Ticket_Granting_Ticket** to request access to **Application_Server** by sending the extracted **Ticket_Granted_Ticket** and the created **Authenticator1** to **Ticket_Granting_Server**
10. **Ticket_Granting_Server** uses **Ticket_Granting_Server_Secret_Key** to decrypt the **Ticket_Granting_Ticket** from the user and extracts **Session_Key1**
11. **Ticket_Granting_Server** decrypts **Authenticator1** and checks if it matces **User_ID** and **User_Network_Address**. Also it checks whether **Ticket_Granted_Ticket** has expired using **Timestamp**
12. If everything is OK, then **KDC** generates **Session_Key2** that is shared between user and **Application_Server**
13. **KDC** creates **Service_Ticket** that includes:
    - **User_ID**
    - **User_Network_Address**
    - **Timestamp**
    - **Session_Key2**
14. **KDC** encrypts **Service_Ticket** with Server's (??? which one ???) Secret_Key obtained from **Database**
15. User receives message containing **Service_Ticket** and **Session_Key2**, all encrypted with **Session_Key1**
16. User decrypts the message using **Session_Key1** and extracts **Session_Key2**
17. User creates new **Authenticator2**, encrypted with **Session_Key2** containing:
    - **User_ID**
    - **User_Network_Address**
    - **Timestamp**
18. User sends **Authenticator2** and **Service_Ticket** to **Application_Server**
19. **Application_Server** receives decryption and authnctication.
20. **Applicaiton_Server** uses Server's Secret_Key (??? which one ???) to decrypt **Service_Ticket** and extract **Session_Key2**
21. **Applicaiton_Server** uses **Session_Key2** to decrypt the **Authenticator2**
22. **Application_Server** checks whether **User_ID** and **User_Network_Addresss** from the **Authenticator2** and **Service_Ticket** match. Also it checks whether **Service_Ticket** has expired
23. If everything is OK, then **Application_Server** sends a message verifying that the User and **Application_Server** have authenticated each other