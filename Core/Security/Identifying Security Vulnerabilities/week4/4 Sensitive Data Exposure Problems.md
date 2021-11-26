# 4. Sensitive Data Exposure Problems

Created: November 26, 2021 4:53 PM
Lecture: Identifying Security Vulnerabilities
Type: Lecture

## Introduction to Sensitive Data Exposure Problems

How data exposure issues happen

- not enough protection for sensitive data(e.g. password)

OWASP Strategy List

- Know your data
- Build security into your software requirements
- Be aware of caches and how to disable them
    - Sensitive data can be cached by proxy or the browser side
- Understand cryptography
- Do not store sensitive data unless you need to
    - do i really need this data? → if so, what is the standard way to store the data?

### Issue 1: Using PII to Compose Session IDs

Using Personally Identifiable Information(PII) to compose session ID is an issue because..

- May be found in application logs
- Maybe session data is not properly encrypted

→ one way or another, an attacker can get at this information, because PII looks like there is a general pattern to this, an attacker, given enough time and resources, will eventually be able to guess this information

⇒ Using user information as a session ID may save time in the short-term for performing lookup. BUT, this is risky to do.

General Prevention Strategies

- generate hard to guess tokens
- use pseudorandom number generator to generate session IDs
- do not use any user identification data

### Issue 2: Not Encrypting Sensitive Information

Both of these are problems:

- not encrypting sensitive information
- we don't know what information is sensitive, so we do not encrypt it

Because..

- regular HTTP traffic can be watched by an attacker on the same network(data in transit)
- an attacker can obtain data from the web applications database where that data is not encrypted, and steal that data very easily(data in rest)

General Prevention Strategies

- Know what kinds of data that your web application will be dealing with
    - categorize based on sensitivity level
    - categorize based on transmission/at-rest
- Don't store/handle data unless you need to
- Use standard cryptography measures
    - e.g. AES block cipher in CBC mode with random IV

### Issue 3: Improperly Storing Passwords

1. NEVER STORE PLAIN PASSWORD
2. This could be one solution, but is not perfect

![Screen Shot 2021-11-26 at 17.17.22.png](4%20Sensitive%20Data%20Exposure%20Problems%20ab3c5a77cbd94b708b0ee28ffe709859/Screen_Shot_2021-11-26_at_17.17.22.png)

- If two users have the same pw, same hash is stored in DB → attacker has higher chances of knowing the actual password
1. General Prevention Strategies
- salting and hashing
- slowing down pw brute force by using..
    - PBKDF2
    - bcrypt
    - etc
- allow using 2-factor authentication(2FA, MFA)
- create a generic user message
    
     → "Invalid username or password entered"
    

**Slowing Down Password Bruteforce Attacks**

Salt:

- a fixed length, randomly generated string, that is concatenated with the plaintext password BEFORE performing the hash
    - salt does not need to be secret
    - salt does need to be stored alongside username and hash result
        - allows application to perform authentication checks, as usual
- Rules for Salt
    - generate using a CSPRNG(cryptographically secure pseudo-random number generator)
    - salt length needs to be at least the same length as the output of the hash function
    - generate a new one-time salt FOR EACH user
    - do NOT reuse the same salt

Storing Password for a New User

- generate the salt using a CSPRNG
- concatenate the salt and the plaintext password e.g. salt + plaintext
- hash the result of step 2 (use a slow hashing function like bcrypt or PBKDF2)
- storing in the database record

Performing Authentication

- get salt associated with username
- concatenate the salt and the given plaintext password
- hash the result of step2 using the SAME hash function you used when storing the user information
- compare the result of step 3 with what is in the database. if the result of step3 matches, then the user is authenticated

⇒ for both storing and performing authentication, **perform the hashing on the server side!**

Slowing Down Brute Force Calculations with PBKDF2

- salt prevents use of lookup tables
    - tables with precomputed hashes from wordlist
- salt doesn't prevent brute force attacks
    - checking match for all combinations of a certain length of plaintext
- idea:
    - slow down the hashing calculation
    - make brute force calculations too slow to be useful

### Issue 4: Using HTTP for Sensitive Client-server

Using HTTP for sensitive client-server exchange

![Screen Shot 2021-11-26 at 17.32.54.png](4%20Sensitive%20Data%20Exposure%20Problems%20ab3c5a77cbd94b708b0ee28ffe709859/Screen_Shot_2021-11-26_at_17.32.54.png)

Mitigation

- use HTTPS(encrypt the HTTP communication) between client and server
- server running web app needs to obtain a browser-trusted certificate
- user's browser will examine HTTPS certificate before using it to start an encrypted channel with server

⇒ Let's Encrypt: allows for automated way to use HTTPS for your web server