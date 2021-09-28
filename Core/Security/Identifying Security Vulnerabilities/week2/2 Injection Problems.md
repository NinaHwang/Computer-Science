# 2. Injection Problems

Created: September 28, 2021 9:21 PM
Lecture: Identifying Security Vulnerabilities
Materials: https://www.coursera.org/learn/identifying-security-vulnerabilities/home/week/2
Type: Lecture

## Injection Problems

General idea: there is some untrusted data as input that gets added to or embedded into a command or query string → this string is then sent to an interpreter, and the interpreter interprets that string as a command/query

⇒ how developer sees the string ≠ how interpreter sees the string

## SQL Injection

Inject user supplied data into a web application's SQL query, and is then interpreted by web application's backend database

Can lead to privilege escalation and/or modification, extraction of data

**Example1**

- should only be true when login and password match an existing entry
- Original

```sql
SELECT login_id, pwd
FROM members
WHERE login_id = '$login' AND pwd = '$pwd';
```

- Modified by untrusted party: this one is always true..

```sql
SELECT login_id, pwd
FROM members
WHERE login_id = 'someuser' AND pwd = '1' OR '1=1';
```

**Example2**

```sql
INSERT INTO users (username, password, ID, privs) 
VALUES ('$uname','$pwd','$id','$priv')
```

- Fields controlled by attacker:
    - username, password
- 'privs' in integer: where 0 means 'admin' account privileges
- If this string is injected into username field, then attacker can create an admin user:
    - foo', 'bar', 9999, 0)—
- Notice the user of — which is a way to comment out the rest of the SQL statement

```sql
INSERT INTO users (username, password, ID, privs) 
VALUES ('foo', 'bar', 9999, 0)—,'',,)
```

**Concept Tree**

![Screen Shot 2021-09-28 at 21.39.29.png](2%20Injection%20Problems%20cbc238a2b59f4fce8f99886fff349e2a/Screen_Shot_2021-09-28_at_21.39.29.png)

### SQL Injection Mitigation Strategy

- Principle of Least Privilege
    - User role of web application should not need 'root' privs
        - Reduce this to only what the web application user role requires to function
- Prepared Statements
    - Pre-compiled SQL statement that acts like a template
    - Input parameters are placed into "buckets" in the template
    - Input parameters are always treated as data, not as part of SQL statements
- Stored Procedures
    - SQL statements that are generated and can be stored in your DB
    - Allows to use static SQL and helps to avoid SQL injection
    - To avoid SQL injection vulnerability, you need to avoid dynamically generating SQL in your stored procedure
- Query Whitelisting
    - Input validation
    - For certain types of input, you can have a whitelist of input that is ok

**Prepared Statements (+ parameterization)**

→ precompiled SQL queries: when you use one, you would just compile it just once before using it, and it acts like a SQL query template that you basically have buckets for where your user input will go

Notice: The use of **?** in the SQL statement

E.g.

- If you use string concatenation instead of parameterization, you will still be vulnerable to SQL injection

```sql
Public boolean authenticate(String name, String pass)
{
PreparedStatment pstmt;
String sql = "SELECT name FROM user WHERE name = " + name + "
AND pwd = " + pass;
pstmt = this.conn.prepareStatement(sql);
ResultSet results = pstmt.executeQuery();
return results.first();
}
```

→ still vulnerable to SQL injection, because it hasn't bucketized these user_data input yet

Pros and Cons

- pro
    - can specify data type of user input parameters
    
    ```sql
    pstmt.setString(0, name);
    pstmt.setString(1, pass);
    ```
    
- con
    - if you have several input parameters, the indexing of these variable names can be cumbersome and the resulting code is harder to read

**Using Stored Procedures**

→ SQL query that is created and stored in database, then when needed to run, is called by the web application

→ CAN create static SQL much like prepared statements - make sure you are only creating static SQL query and using parameters!

Pros and Cons

- pro
    - like prepared statements, have ability to specify data type for parameter
- con
    - like prepared statements, lots of parameters mean cumbersome stored procedure statement
    - Some DB systems(e.g., MS SQL server) require execute rights to run - greatly increases privilege of DB user, which may be leveraged by an attacker if compromise occurs

**Using Whitelisting**

→ Validating that user controlled data conforms to a known specification

→ The known specification can be a set of acceptable data

Pros and Cons

- pro
    - it can be simple to implement
- con
    - for more complex whitelist data
        - you might need to create regular expression to match valid input
    
    → however, there are a lot of resources online to help you write regular expressions
    

## Cross-Site Scripting

[Cross Site Scripting (XSS)](https://owasp.org/www-community/attacks/xss/)

Example: Modifying DOM and including a user-defined parameter

![Screen Shot 2021-09-28 at 22.20.29.png](2%20Injection%20Problems%20cbc238a2b59f4fce8f99886fff349e2a/Screen_Shot_2021-09-28_at_22.20.29.png)

Ability to inject JavaScript into a web application, and interpreted by victim's browser

Three types:

1. Reflected
2. Stored
3. DOM-based

Can lead to account impersonation/session stealing

**Concept Tree**

![Screen Shot 2021-09-28 at 22.23.19.png](2%20Injection%20Problems%20cbc238a2b59f4fce8f99886fff349e2a/Screen_Shot_2021-09-28_at_22.23.19.png)

### HTTP and Document Isolation

HTTP: 

- a protocol that allows us to be able to view documents on the internet
- a protocol that sent over another protocol called TCP/IP
- a way to fetch resources:
    - web pages
    - pictures
    - scripts
- client-server protocol
    - communication initiated by client (the receiver)
- human readable protocol
- stateless
    - i.e., current request has no relationship to previous request
    - How to make HTTP add state?: **Cookies**
        - server sends key-value pair labeled as a "cookie" to client over HTTP
        - on subsequent requests to server, client sends cookie back to server

Cookies

- allows server to identify client
- allows server to identify session for client
- possible for JavaScript program (embedded in document) to read/write cookies related to document - via DOM
- cookies should be kept private
    - server-side sets cookie to "HttpOnly" → inaccessible via JavaScript; only sent to server
- Setting the Cookie Scope
    - you can specify "Domain" and "Path"
        - specifies URLs that are allowed to get the cookie (from browser)
        - Domain: which hosts can get the cookie → excludes subdomains
        - Path: which path must exist in requested URL in order for cookie to be sent back to server

Origin

- Origin equals: Protocol + Domain + Port
- We can roughly think of it in terms of interprocess communication:
    - what process is it that has served the document that the client has requested?
- Same Origin Policy
    - a way to isolate documents from each other
    - communication restriction between one resource (e.g., a document or script) served from origin A and another resource served from origin B

### DOM, Dynamically Generating Pages, and Cross-Site Scripting

Document Object Model(DOM)

- HTTP is a protocol for fetching resources
- In early days, documents were static - how to make these documents more interesing?
    
    ⇒ DOM: the document viewed in object-oriented terms
    
- DOM: a way to access and manipulate the document in a programmatic way
- DOM is an API for document manipulation on client side
    - instruction embedded within documents fetched by client
    - instruction runs on client's browser (aka the user-agent)
    - instruction can access parts of document via DOM to make the document more interesting to see on client's browser
- Cookies can be accessed via the DOM
    - e.g.: using JavaScript, or document obj
- How do we keep these cookies "isolated" so that only the originating document has access?

Dynamically Generated Pages

- Pages can be dynamically generated using external data
    - e.g.: untrusted user input
    - server-side: accomplished using server-side scripts
    - client-side: accomplished by modifying the DOM
    
    ⇒ this helps us to understand the difference between reflected and stored cross-site scripting vs. DOM based cross-site scripting
    

Cross-Site Scripting

- goal: obtain session cookie
- bypasses Same Origin Policy
    - malicious script is in the same document object as cookie that attacker wants to steal
- tactic: via a malicious script that is run and malicious script is considered to be within same origin as cookie
- how:
    - reflected:
        - malicious data injected, e.g., via URL parameters, and used to generate document on server-side
    - stored
        - malicious data in injected, e.g., via POST data, and stored on a DB
        - server generates document with injected script
        - clients then fetch data from DB
    - DOM-based
        - when DOM environment of document is modified, and malicious data is injected via modification

### 3 Kinds of Cross-Site Scripting Vulnerabilities

**Reflected Cross-site Scripting**

Example: malicious user tricks victim into clicking on link to vulnerable web application, and link includes malicious script in link parameter

![Screen Shot 2021-09-28 at 22.54.53.png](2%20Injection%20Problems%20cbc238a2b59f4fce8f99886fff349e2a/Screen_Shot_2021-09-28_at_22.54.53.png)

**Stored Cross-site Scripting**

- malicious script is entered into application via a <form> or parameter field
- malicious script is stored in backend db of application
- other users fetching resource are affected

![Screen Shot 2021-09-28 at 22.56.13.png](2%20Injection%20Problems%20cbc238a2b59f4fce8f99886fff349e2a/Screen_Shot_2021-09-28_at_22.56.13.png)

**DOM-based Cross-site Scripting**

- document's DOM is intended to be manipulated for normal usage scenario
- malicious data can be injected into DOM
- malicious script is run when DOM is rendered by client's browser

![Screen Shot 2021-09-28 at 22.58.21.png](2%20Injection%20Problems%20cbc238a2b59f4fce8f99886fff349e2a/Screen_Shot_2021-09-28_at_22.58.21.png)

Notice: to run malicious script, no data request+response between client and server

### Compare and Contrast Cross-Site Scripting

Reflected: victim induced to clicking on link, e.g., via e-mail, via another website

Stored: victim fetches injected script from backend db, since injected script is stored on a backend db on vulnerable web app

⇒ there is a request to the vulnerable web app, and app server responds back

DOM: malicious injected script starts ate the DOM, but a request is never made back to the vulnerable web app; client runs DOM modification instruction and runs malicious script

### OWASP Prescribed Cross-site Scripting Prevention Rules

**Part 1**

provides protection even against future vulnerabilities caused by browser changes

- effectively a whitelist of where it's ok to place untrusted data
- each slot has different security rules - makes user that untrusted data can't be interpreted in a different context

Security Encoding Library

- helps you prevent making mistakes when encoding untrusted data
1. Rule #0
    
    Never insert untrusted data except in allowed locations
    
    - follow the whitelist rule outlined in the OWASP prevention model
    
    ![Screen Shot 2021-09-28 at 23.10.37.png](2%20Injection%20Problems%20cbc238a2b59f4fce8f99886fff349e2a/Screen_Shot_2021-09-28_at_23.10.37.png)
    
2. Rule #1
    
    HTML escape before inserting untrusted data into HTML
    
    - use your security encoding library to encode the untrusted data before you use it as data between an HTML element
3. Rule #2
    
    Attribute escape before inserting untrusted data into HTML
    
    - use your security encoding library to encode the untrusted data before you use it as an HTML attribute
4. Rule #3
    
    JavaScript escape before inserting untrusted data into JavaScript data values
    
5. Bonus Rule #1
    
    Use HTTPOnly cookie flag
    

**Part 2**

parser: a program that analyzes a string to determine whether that string follows a specific grammar for that parser, i.e., check that the string has correct syntax

1. DOM Rule #1
    
    HTML escape then JavaScript escape before inserting untrusted data into HTML subcontext within the execution context
    
2. DOM Rule #2
    
    JavaScript escape before inserting untrusted data into HTML attribute subcontext within the execution context
    
3. DOM Rule #3
    
    Be careful when inserting untrusted data into the event handler and JavaScript code subcontexts within an execution context
    
4. DOM Rule #4
    
    JavaScript escape before inserting untrusted data into the CSS attribute subcontext within the execution context
    
5. DOM Rule #5
    
    URL escape then JavaScript escape before inserting untrusted data into URL attribute subcontext within the execution context
    
6. DOM Rule #6
    
    Populate the DOM using safe JavaScript functions or properties
    

## Command Injection Problems

Web application takes user controlled data

Web applications users user-controlled data as input into a command that is passed onto a shell/OS command call

Malicious attacker can manipulate user controlled data to run their own OS command

Since OS command call via web application is done under same privileges as web application process, malicious attacker has gained those privileges

**Strategies for Mitigating**

If you can, avoid placing user-controlled data into commands that will eventually be processed by a shell

If it can't be avoided, then:

- validate your user-controlled data before further processing
    - use whitelisting/constrain string data to be only alphanumeric
- use API calls that don't support command chaining

## OWASPS Proactive Controls Related to Injections

[OWASP Proactive Controls](https://owasp.org/www-project-proactive-controls/)

1. Define Security Requirements
2. Leverage Security Frameworks and Libraries
3. Secure Database Access
4. Encode and Escape Data
5. Validate All Inputs
6. Implement Security Logging and Monitoring