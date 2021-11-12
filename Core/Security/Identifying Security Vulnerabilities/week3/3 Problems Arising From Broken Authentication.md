# 3. Problems Arising From Broken Authentication

Created: October 9, 2021 7:54 PM
Lecture: Identifying Security Vulnerabilities
Materials: https://www.coursera.org/learn/identifying-security-vulnerabilities/lecture/WzeAM/module-3-introduction
Type: Lecture

Early HTTP wasn't built with the ability to keep application session state

Subsequent versions of HTTP introduced ways to keep application state

Crucial to understand authentication and session management work in web apps

## Overview of HTTP Protocol

HTTP protocol is done over the TCP/IP protocol

### HTTP Protocol Form - Request

```
GET / HTTP/1.1
Host: developer.mozilla.org
Accept-Language: fr
```

- HTTP Method(aka 'Verb')
- Path of resource that it wants to act upon using the HTTP Verb
- HTTP Protocol version
    - HTTP/1.1 and earlier: human-readable
    - HTTP/2.0 and above: not human-readable
- HTTP Headers(one or more): gives more info to server in order to handle request
- (Optional) HTTP Body

### HTTP Protocol Form - Response

```
HTTP/1.1 200 OK
Date: Sat, 09 Oct 2010 14:28:02 GMT
Server: Apache
Last-Modified: Tue, 01 Dec 2009 20:18:22 GMT
ETag: "51142bc1-7449-479b075b2891b"
Accept-Ranges: bytes
Content-Length: 29769
Content-Type: text/html
```

- HTTP Protocol version used by server
- Status code of HTTP request processing
- Status message of HTTP request processing
- HTTP Response Headers

### Stateless Property

Basic(core) HTTP Protocol

- relationship btw current and previous requests from client A are:
    - unrelated
    - independent

How to add state? : Extend the HTTP header to use "cookies"

- cookies allow session state

### Side Effect of HTTP without Encryption

No encryption means:

- eavesdropping is possible
- session hijacking is possible

### Communication Between Client and Sersver

"HTTP Strict Transport Security"

- how: a response header from server
- what: tells clients that they should only use HTTPS(HTTP encrypted) in order to perform all communications with the server

## Authentication

### Sessions as a RESTful Resource

REST: Representational State Transfer

- requests are performed on a resource like a piece of data

For convenience, model sessions are a RESTful resource

- create
- read
- update
- destroy

![Screen Shot 2021-10-09 at 20.17.14.png](3%20Problems%20Arising%20From%20Broken%20Authentication%203cee3a458b0f486b953516d5c55ced43/Screen_Shot_2021-10-09_at_20.17.14.png)

REST requests are HTTP requests

### Cookies and Stateful Sessions

**Most common types of login systems**

Temporary cookie given to browser from server

- Browser forgets cookie on browser shutdown
- Encrypted session ID is used as data in cookie

Remember token

- automatic remember on logon OR "remember me" option
1. server creates a "remember token"
    1. remember token is a random string of digits
2. Server stores remember token's hash digest in the backend database
3. Server sends browser the remember token as a cookie
4. Server encrypts userID and that encrypted data is sent over to the browser as a cookie
5. When client gives server the encrypted userID and remember token, server unencrypts  userID, then:
    1. finds user in DB by userID
    2. checks client's remember token is the one that has been hashed in the DB

### General Guidelines for Authentication

Login page and authenticated pages should be accessed using TLS

Force user to re-authenticate when user is accessing a sensitive feature

- in order to guard against session hijacking

Implement lockout after a small number of authentication attemps

- in order to guard against brute force attacks(guessing password)

## Handling Error Messages During Authentication

Create generic error responses

Error messages should not hint status of username, password, account status

### Help Incident Response

Log password failures

- include timestamp and username on account

Log all account lockouts

- include timestamp and username on account

## Introduction to Session Management

HTTP is stateless

Session management (using cookies)

- server generates data, sends data to browser
- upon subsequent requests, browser sends this data to server

Watch out:

- session token generation - is it predictable?
- session token handling - is session token data leaked?
- session termination - is the session data actually removed completely?

### Safe Exchanging Session IDs Using Cookies

Is cookie scope reduced as much as possible?

- make sure cookie's domain scope is as restrictive as possible
- make sure cookie's path scope is as restrictive as possible

Is cookie inaccessible via JavaScript and only sent back to the server?

Is exchange always over an encrypted channel, e.g. TLS?

### Methods of Expiring Sessions

Ensure that web app "logout" functionality works as expected

- session information on server-side should be cleared out
- server should invalidate browser's session token cookie
- any new logins should generate a completely new session token cookie
    - that data generated for that cookie should be as random as possible

Defensive Session Termination

## Enforcing Access Control with Session Management

### Types of Access Control Models

- Discretionary (DAC)
- Role-based (RBAC)
- Identity-based (IBAC)
- etc

### Privilege Attacks

Vertical and Horizontal

### Specify Access Control

Express as a tuple

- principal (the who/what)
- access type (action on resource - think RESTful)
- resource

You can "squash" the list of tuples by categorizing the first column into groups or roles

### Secure Access Control Best Practices

Explicitly design your access control security policy

Signify access rights on server-side

Always validate user controlled data

Make sure to have access control functionality in a centralized component

Every request should be checked using the centralized access control function before allowing access to a resource

Additionally: restrict special pages using IP access whitelist

For any critical action, add user re-authentication before performing action

## Logging and Monitoring

### Why Log?

Provide incident handling information

Add on-repudiation controls

Helpful in detecting attacks and identifying vulnerabilities

### What to Log?

At the very least log:

- authentication successes and failures
- authorization (access control) failures
- session management failures, e.g. cookie session identification value modification
- ensure that all account lockouts are logged and reviewed