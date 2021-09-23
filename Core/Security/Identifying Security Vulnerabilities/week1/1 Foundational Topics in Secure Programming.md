# 1. Foundational Topics in Secure Programming

Created: September 23, 2021 10:15 AM
Lecture: Identifying Security Vulnerabilities
Materials: https://www.coursera.org/learn/identifying-security-vulnerabilities/lecture/K8n2i/course-introduction
Type: Lecture

## Introduction

### Learning Objectives

Gain exposure to threat modeling and applied cryptography

Create threat models

Think critically about other people's threat models

Apply the STRIDE Method to your threat models

Distinguish trust boudaries

Gain a basic understanding of encryption and secure hashing

## Fundamental Concepts in Security

**Three security objectives → CIA triangle**

- Confidentiality
- Integrity
- Availability

### Confidentiality

> Preserving authorized restrictions on access and disclosure
Protecting privacy and proprietary information

**Meeting Confidentiality Objectives**

- Encrypt data as it flows from system to system
- Encryption in transit
- Encrypt data where it will be stored
- Encryption at rest
- Use access control lists
- Allow certain users access to certain types of data

### Integrity

> Data must meet with the expectation of quality
Data can be relied on
Data and system resources are consistent and accurate

Meeting Integrity Objective: 

Use method authentication code to verify what we downloaded is what we expected

E.g. HMAC Algorithm: Message and sender and message receiver have the same secret key to perform authentication

### Availability

> Insuring timely and reliable access to and use of information
Users are able to access resources and data in a reliable and timely manner

E.g. DDoS Attack(Distributed Denial of Service Attack)

Content Delivery Network(CDN) Mitigates a DDoS

- CDN serves only your web app:
    - removes the burden from your server
    - uses a cached version of your web app data
- CDN are built to handle a large amount of traffic so your system doesn't have to

## Threat Modeling

**Process with 3 main goals:**

1. Ability to understand the system being proposed: assets, how data flows, and trust boundaries
2. Find potential threats due to system vulnerabilities in the proposed system design
3. Prioritize vulnerabilities and fix most important in a timely manner

## The STRIDE Method

⇒ Requirements gathering

⇒ STRIDE as a brainstorming tool to determine and prioritize system modifications & improvements

[STRIDE (security) - Wikipedia](https://en.wikipedia.org/wiki/STRIDE_%28security%29)

### System Development Lifecycle

> "The system development life cycle is the overall process of developing, implementing, and retiring information systems through a multistep process from **initiation, analysis, design, implementation, and maintenance to disposal**."

### Goals

Determine critical assets and services to protect

- Define user roles
- Define user privileges
- Determine attack surface of the system

### Create a Threat Model

Start with a Data Flow Diagram

- Determine trust boundaries
- How does data flow from a non-trusted boundary through other parts of the system

### The STRIDE Model

- Spoofing(도용하다): Can a malicious user pretend to be a different user?

    ⇒ AUTHENTICITY

    - Unauthorized users must login and obtain a token
    - Determine user's access level by their token information
- Tampering(참견하다, 간섭하다, 함부로 변경하다): Can a malicious user modify data used by the system?

    ⇒ INTEGRITY

    - Encryption would prevent data tampering between data flows
    - We also need to encrypt the data at rest
- Repudiation(거절, 부인): Can a malicious user deny that they performed an actions to change the system's state?

    ⇒ NON-REPUDIABILITY

    - Logging mechanisms help us account for what has been done on the system
- Information leakage(aka: information disclosure, privacy breach): Can a malicious user extract information that should be kept secret?

    ⇒ CONFIDENTIALITY

    - Encryption prevents eavesdropping between data flows
    - We also want to encrypt the data at rest
- Denial of Service: Can a malicious user exhaust system resources such that the system is not longer functioning as intended?

    ⇒ AVAILABILITY

    - Requires further testing and code review to ensure ample system resources are available
        - a lot depends upon client request numbers taht the stakeholders expect
    - A load balancer could be used to front server
- Elevation(승진, 승격) of privilege: can a malicious user increase their ability to work with the system resources?

    ⇒ AUTHORIZATION

    - Unauthorized users must login and obtain a token
    - Determine user's access level by their token information
    - Create a tamper-resistant token mechanism so clients cannot gain extended privileges

### What are Our Security Requirements?

- Encryption
- Authorization token
- Logging related to system state changes
- Further code review of system resource handling

## Trust Boundaries

*Do I trust the data moving between the two nodes?*

*Which node do we trust more?*

⇒ Trust boundaries are points in the system where data flows from one location to another, and there is a change between the level of trust that we have on the data, as a data flows from one location to another

⇒ Trust boundaries tell us where to focus our attention and where we wnat to concentrate on validating our data before we use it

[Trust boundary - Wikipedia](https://en.wikipedia.org/wiki/Trust_boundary)

## Cryptography

![Screen Shot 2021-09-23 at 11.31.10.png](1%20Foundational%20Topics%20in%20Secure%20Programming%20f7ca2cf3d56c4929bac37d40371b144c/Screen_Shot_2021-09-23_at_11.31.10.png)

[Introduction to Crypto-terminologies - GeeksforGeeks](https://www.geeksforgeeks.org/introduction-to-crypto-terminologies/)

[Cryptography and its Types - GeeksforGeeks](https://www.geeksforgeeks.org/cryptography-and-its-types/)

### Block Ciphers

[Block Cipher modes of Operation - GeeksforGeeks](https://www.geeksforgeeks.org/block-cipher-modes-of-operation/?ref=lbp)

*An algorithm where you use it to take a plaintext message, so something that you want to keep secret and you put it through the block cipher and get out the cipher text output*

*Cipher-text is the plaintext message all jumbled up so no one but you can read it if you have the private key and the decryption algorithm*

Using a block cipher of a specific bit length, we can encrypt a message having at most the same bit length as the block cipher

- works on a fixed length group of bits(group of bits is called a "block")
- the ciphertext output should have no relation to the plaintext message input

Block Cipher Modes

- ECB Mode - don't use this!
- **CBC Mode**: When we need to encrypt a message that isn't one block size of the block cipher long, then we need to use a cipher pad
    - Currently recommended
    - CBC Mode with XOR Cipher

    ![Screen Shot 2021-09-23 at 11.44.20.png](1%20Foundational%20Topics%20in%20Secure%20Programming%20f7ca2cf3d56c4929bac37d40371b144c/Screen_Shot_2021-09-23_at_11.44.20.png)

    - Initialization Vector(IV): the first block needs to be "randomized" too, so it gets XORd with the IV before being passed into block cipher encryption
        - best to use a random IV
    - Recommended by Ferguson, et al.: AES with size 256-key in CBC mode with random IV
- CTR Mode: You can use a block cipher as a stream cipher via the CTR mode
    - This means no need for padding, however, CTR is only good if you can guarantee that the nonce is always unique

### Symmetric and Asymmetric Cryptography

**Symmetric Key Encryption**

> It involves usage of one secret key along with encryption and decryption algorithms which help in securing the contents of the message. The strength of symmetric key cryptography depends upon the number of key bits. It is relatively faster than asymmetric key cryptography. There arises a key distribution problem as the key has to be transferred from the sender to receiver through a secure channel.

- sender and receiver both have the same key
- algorithm: Advanced Encryption Standard (AES)

![Screen Shot 2021-09-23 at 11.51.02.png](1%20Foundational%20Topics%20in%20Secure%20Programming%20f7ca2cf3d56c4929bac37d40371b144c/Screen_Shot_2021-09-23_at_11.51.02.png)

**Asymmetric Cryptography**

> It is also known as public key cryptography because it involves usage of a public key along with secret key. It solves the problem of key distribution as both parties uses different keys for encryption/decryption. It is not feasible to use for decrypting bulk messages as it is very slow compared to symmetric key cryptography.

- Leads to ability to agree on a shared secret key in order to then perform symmetric key encryption
- What you need:
    - a public key of the receiver
    - receiver needs the matching private key to the public key in order to decrypt the sender's message
    - sender uses public key to encrypt a message
- Example of usage: Diffie-Hellman Key Exchange Protocol

**Public and Private Keys**

Generated using a special algorithm

Relationship: One public key to only one private key

- Public key: what the perceiver announces to the world
- Private key: what the receiver keeps as secret → used to decrypt messages intended for them

![Screen Shot 2021-09-23 at 11.56.47.png](1%20Foundational%20Topics%20in%20Secure%20Programming%20f7ca2cf3d56c4929bac37d40371b144c/Screen_Shot_2021-09-23_at_11.56.47.png)

[When to Use Symmetric Encryption vs. Asymmetric Encryption](https://www.keyfactor.com/blog/symmetric-vs-asymmetric-encryption/)

### Hash Functions

> It involves taking the plain-text and converting it to a hash value of fixed size by a hash function. This process ensures integrity of the message as the hash value on both, sender\’s and receiver\’s side should match if the message is unaltered.

Hash functions are used for mapping data to other data, and you can map an arbitrarily long piece of data to data with a **fixed size length**

Hash functions by themselves as they are don't guarantee uniqueness or the output of the hash function ⇒ Cryptographic hash functions

**Cryptographic Hash Functions:**

are hash functions but with the extra properties:

- the same message always results in the same hash
- you can't get the message back from a hash, unless you tried to generate all possible messages
- two different messages should not result in the same hash value → no hash collision
- it is relatively fast
- if you generate a message and a hash, then modify the message just slightly and generate another hash from the new message, you should not see any relationship between the old and the new hash

e.g. SHA-256

### Message Authentication Codes

a "tag"

used to:

- determine whether a message actually came from the sender that is expected
- determine whether the message hasn't been tampered with

e.g. HMAC(using SHA-256 hash function as building block)

**Sender Side**

![Screen Shot 2021-09-23 at 13.32.21.png](1%20Foundational%20Topics%20in%20Secure%20Programming%20f7ca2cf3d56c4929bac37d40371b144c/Screen_Shot_2021-09-23_at_13.32.21.png)

**Receiver Side**

![Screen Shot 2021-09-23 at 13.33.38.png](1%20Foundational%20Topics%20in%20Secure%20Programming%20f7ca2cf3d56c4929bac37d40371b144c/Screen_Shot_2021-09-23_at_13.33.38.png)

## OWASP Top 10 Proactive Controls and Exploits

Controls to apply during software development lifecycle

only a starting point, but it's still a good place to start(build awareness)

for improved process, should also include:

- a verification standard for testing security controls(e.g. OWASP ASVS)
- set of additional activities during software development lifecycle(e.g. from OWASP SAMM, BSIMM)

You can see a mapping the control/defense technique to the security weakness being addressed

1. Define Security Requirements
    - done at the beginning of the lifecycle, and iterate when new changes to application specification appear
    - generate security requirements in order to define new security features to address vulnerabilities in an application

    → addresses: prevention of many types of vulnerabilities

2. Leverage Security Frameworks and Libraries
    - Existing tried and proven security frameworks help developers ramp up their web application security improvements

    → addresses: prevention of many types of vulnerabilities

3. Secure Database Access
    - make sure that database access is secure in the following ways:
        - using queries securely
        - setting up your database with secure configurations
        - setting up secure authentication and secure communication

    → addresses: prevention of injection vulnerabilities

4. Encode and Escape Data
    - defensive technique for preventing injection attacks

    → addresses: injection and cross-site scripting vulnerabilities

5. Validate All Inputs
    - only properly formatted data can be processed further
    - MUST be used with additional defenses
        - e.g. query parameterization; escaping

    → addresses: reduction of attack surface of application - attacker has to work harder

6. Implement Digitally Identity
    - Setting up proper authentication levels
    - password only **vs** multi-factor authentication **vs** crypto based authentication via hardware crypto modules

    → addresses: Broken authentication and session management

7. Enforce Access Contros
    - managing privilege to resources of system
    - NOT the same as authentication
        - authentication / authorization
    - KEEP IN MIND: Principle of Least Privilege

    → addresses: Broken access controls

8. Protect Data Everywhere
    - need to classify your data based on sensitivity level
    - encrypt your data in transit and at rest
    - keep application secrets secret

    → addresses: sensitive data exposure

9. Implement Security Logging and Monitoring
    - follow a common logging format
    - log just enough information
    - make sure timestamps are consistent across your various systems
    - forward logs to a central service
    - protect log integrity

    → addresses : needs during intrusion detection analysis and investigations, needs for regulatory compliance

10. Handle All Error and Exceptions
    - make sure that user-displayed error messages don't leak any sensitive data
    - log exceptions so that internal analysts, support, and QA have enough information to understand the issue

    → addresses: information leakage issues; Potential denial-of-service issues

### OWASP Top 10 Project

List of most important web application security issues that are seen by the information security community

Recommendations for fixing issues

Provides additional guidance for application security improvement

[OWASP Top Ten](https://owasp.org/www-project-top-ten/)