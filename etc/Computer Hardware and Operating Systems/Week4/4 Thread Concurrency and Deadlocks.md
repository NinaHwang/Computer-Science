# 4. Thread Concurrency and Deadlocks

Created: December 19, 2021 8:33 PM
Lecture: Computer Hardware and Operating Systems
Type: CS, Lecture

## Feature of Having Multiple Threads

Ease of communication:

- each thread inside the process has access to all the resources of the process
    - it allows threads to communicate without any interaction of the OS
- for processes to communication each other requires I.P.C(interprocess communication)
    - because of the segregation of each process, processes are not allowed to communication directly with each other
    - since threads exist inside of a process and they are sharing resources, one thread can talk to another thread directly
- 만약 쓰레드가 없다면?
    - 마이크로소프트 워드를 사용할 때 글자를 타이핑함과 동시에 문법 오류, 철자 오류, 동의어 등을 확인함
    - 만약 쓰레드가 없다면 문서가 unsynchronized됨 → 각 프로세스마다 상이한 버전의 문서
        - 그래서 예전에는 문법오류, 철자오류 등의 기능들이 제공되지 못했던 것
    - 쓰레드들은 동일한 메인 메모리 내 문서를 자원으로 공유하고 있기 때문에 직접적으로 접근 가능

Effective solution to prevent blocking while reading data

Threads are relatively easy to create

- all we have to do is creating a TCB(Thread Control Block) for each one
- the code is already loaded, the main memory is already there and allocated because it was for the process

**However**,

- Risk of asynchrony

## Asynchrony

Asynchrony occurs when two threads are running seemingly at the same time

E.g.

- A running thread might be interrupted due to hardware considerations, and a different thread chosen to run
- Two threads running on two different CPUs simultaneously - 지금은 다수의 프로세서가 장착되어 있으니까 동시에 다수의 쓰레드가 실행될 수 있음
    - if those two are not carefully coordinating their actions with relation to whatever it is they’re sharing then there’s gonna be very difficult problems that come up and the potential for catastrophic loss of some of the information

Because the **OS** is the one that’s deciding which thread to run, the programmer, the one designing the threads doesn’t get any say in the matter of which thread to run, when to run it, and for how long

## Critical Sections

Sometimes code will be written with the expectation that once we start a particular piece of code, it will run through to completion without being interrupted

If the code is interrupted, asynchrony can occur

In a worst case scenario:

- one thread could do something to manipulate a resource partially but not completely and then stop and then another thread starts up and uses the resource from its inconsistent state assuming that it is in a consistent state and what you end up having is **corrupt data**

The programmer must identify a “critical section” of code which, once entered, must prohibit any other thread from entering a critical section on the same resource

Critical sections should be as small as possible

### Supplier / Demander

```python
bufferCount = 0;
buffer = []

def supplierThread(input):
	done = False;
	while(!done):
		if(bufferCount<500):
			bufferCount += 1
			buffer.append(input)
			done = True
		else:
			time.sleep(5)
			done = False

def demanderThread():
	done = False;
	while(!done):
		if(bufferCount>0):
			bufferCount -= 1
			temp = buffer[bufferCount]
			buffer.pop()
			return temp
		else:
			time.sleep(5)
			done = False
```

Multiple supplier and multiple demander threads are all “active” in the system

- however this is a uniprocessor system so only one can run at a time

The bufferCount should NEVER exceed 500 as there are only 500 spaces to store items in the buffer

As we will see, due to asynchrony, the bufferCount can easily go higher than 500

Error scenario:

- bufferCount가 499인 순간, supplierThread()실행
    - 499이기 때문에 if statement 진입
    - 이 때 interrupt 발생해서 두번째 supplierThread 실행
    - 아직 bufferCount가 500이 되지 않았기 때문에 if statement 진입해서 bufferCount 500으로 바꾸고 buffer에 500 추가
    - 다시 원래 쓰레드로 돌아옴 아까 left off된 곳에서 다시 실행(that’s the concept - the programmer should not know that it’s been interrupted)
    - bufferCount는 500이 되었지만 if statement에 이미 진입되었기 때문에 bufferCount 501로 바꾸고 buffer에 501 추가!!😱

### Double Update / Missing Update

```python
balance = 0

def deposit(amount):
	newbalance = balance + amount #1
	balance = newbalance #3

def withdrawal(amount):
	newbalance = balance - amount #2
	balance = newbalance #4
```

Two transactions are happening on different processors at the exact same moment in time

Error scenario:

- the balance starts out at $100
- the first transaction is a deposit of $50, and the second transaction is a withdrawal of $100
- process
    - #1: newbalance == $150
    - (newbalance가 main memory에 올라가기 전에) INTERRUPT!
    - #2: newbalance == $0
    - INTERRUPT!
    - newbalance를 main memory에 올림($150)
    - #3: balance == $150 → 멀쩡해보임!
    - newbalance를 main memory에 올림($0)
    - #4: balance == $0 → 😱😣😭😩😫😡🤬

### Critical Sections Identified

In the Supplier/Demander example, the checking and changing of the buffer and bufferCount must be **atomic**

In the Double update/missing update problem, the entire function should be **atomic**

The need for these sections of code to be run atomically, indicates that they are critical sections

## Mutual Exclusion Rules

No two threads can be in a critical section at the same time

We have to guarantee mutual exclusion

Mutual exclusion only comes into play when we’re using the same resource

- thread A가 자원 n을 사용하는 크리티컬 섹션에 진입하고, thread B가 자원 m을 사용하는 크리티컬 섹션에 진입하는 경우는 해당되지 않음

When no threads is in a critical section any threads that requests entry must be allowed in without delay

- 크리티컬 섹션에 진입하는 경우가 아니라면, OS가 교통경찰 역할을 하게 시키는 것은 낭비임

A threads may remain inside a critical section only for a small amount of time

### Fundamental Mutual Exclusion

The system bus provides a fundamental system for providing mutual exclusion

Memory cannot be accessed by two processors at the same time, one will win access to the system bus and the other will have to wait until the next cycle

### Software Solutions for Mutual Exclusion

```python
flag = [False, False]
turn = 0

def P0():
	while(True):
		flag[0] = True
		turn = 1
		while (flag[1] and turn==1):
			# do nothing
		# Critical Section
		flag[0 = False

def P1():
	while(True):
		flag[1] = True
		turn = 0
		while(flag[0] and turn==0):
			# do nothing
		#Critical Section
		flag[1] = False
```

Petersons’ Algorithm provided a fundamental way to protect two threads from accessing the same resource at the same time ⇒ boolean flag!

### Hardware Solutions

Disable Interrupts

- prevent the CPU from being interrupted and you prevent asynchrony
- potentially very dangerous

Test and Set

- provide a single ML instruction to check a memory location (boolean flag) and set it if it is not set. a result is returned to indicate success or failure

Exchange

- the location in memory (maybe a flag) is swapped with a register

## Semaphores

Semaphores are a common solution programmers use to protect critical sections

![Untitled](4%20Thread%20Concurrency%20and%20Deadlocks%20028348aa90ab45099b5817320b6b0069/Untitled.png)

The OS provides some of the service, but most work is done in user space

→ we don’t want the OS to act as a traffic cop

A semaphore is a structure which fundamental communications data structure

- Primarily two functions are used, **signal and wait**
- Signals can be queued, or, if a thread is waiting, a signal will cause it to be released
- Wait causes the thread to block if there are no signals to be consumed, the thread is queued to await the next signal

### How to Use Them

The semaphore relies on a signal being queued initially

Before entering a critical section, the thread calls wait. When exiting the thread calls signal.

Thus a semaphore will always have a signal queued when no thread is in a critical section

### Semaphore Internals

Internally semaphores usually keep some counter of the number of signals which have been sent

Wait causes the counter to decrement

If the counter ever becomes negative, the thread which caused it to go negative, and all subsequent threads, will be blocked and placed on a queue. **This is where the OS is invoked**, to perform the block.

- Up until this point, the thread itself is doing all the work

When a signal is sent, the counter is incremented and if the counter is not positive, the next thread on the queue is released

Since the act of checking and modifying the counter is a critical section, the semaphore usually uses a hardware solution to prevent asynchrony in itself

## Deadlocks - a byproduct of mutual exclusion

If a set of threads are all waiting for each other, then there is no way that any one of them will complete

![Untitled](4%20Thread%20Concurrency%20and%20Deadlocks%20028348aa90ab45099b5817320b6b0069/Untitled%201.png)

Usually this results from one thread waiting for another thread to release a resource

This is a permanent block which cannot resolve itself over time

There is no efficient solution today

### Deadlock Resource Types

Reusable

- Once the use of the resource is complete, the resource can be used again by another thread
- Examples include memory, devices, data structures, semaphores, etc
- Case
    - 두 개의 프로세스. 하나도 절반 이상의 메인메모리를 필요로 하고, 다른 하나도 절반 이상의 메인메모리를 필요로 함.
    - 둘 모두에게 충분한 메모리가 제공되지 못함

Consumable

- Once used, the resource is gone
- Examples include interrupts, signals, messages and data in IO buffers
- Case
    - if we take something out of the buffer it’s not there to release the next one, we’ve consumed it and it’s not ever gonna go back and the next thread that comes along waiting for that resource that we’ve already consumed will never be allowed to continue to run

### Items Required for a Deadlock

If we take away any one of them, the deadlock can’t occur

1. Mutual Exclusion
    - Only one thread can use a resource at any given time
2. Hold-and-wait
    - While a thread is “waiting” on the allocation of a new resource, it retains all existing locks
3. No preemption
    - OS cannot come in and force remove resource from a thread
    - A resource cannot be removed from a thread forcefully
4. Circular wait
    - Thread A has to be waiting in some way for thread B, which is waiting again back for thread A
    - A closed chain of threads in which the **last thread is waiting on the first**
        - ultimately waiting back for itself

### Solutions for Deadlocks

Deadlock Prevention

- Eliminate one of the four requirements

Deadlock Avoidance

- Before each allocation check to make sure a deadlock is not possible, do not make an allocation that could cause a deadlock
- Required that the OS know, ahead of time, which resources a thread will request before it is finished
- Every time a thread makes a new request, the OS runs an algorithm to see if that request will cause the system to deadlock
    - if it will, the request is denied or queued
- This usually uses a “Banker’s algorithm”
    - having a premonition, knowing ahead of time what a process/thread is going to request
    - if we recognize, we look at all the possible requests that could happen in the future and see if approving this request right now will cause us to not be able to complete all the other requests
    - 현재로서는 이 방법을 사용하는 것은 불가능에 가까움 → 모든 경우의 수를 예측할 수도 없을 뿐더러 할 수 있다고 하더라도 너무 많은 CPU time을 쓰게됨

Deadlock Detection - actually what happens today the most

- Allow deadlocks to happen and then resolve it when it does
- This is not at all restrictive
- Recognize that deadlocks will occur and that a detection algorithm will need to be periodically run
- Once a deadlock is detected, the OS should take action to resolve the deadlock
- Solutions to existing deadlocks
    - rollback to a previously unlocked state (requires transaction logs)
    - abort all deadlocked threads
    - abort a thread, check for deadlock, repeat

### Dining Philosophers Problem

[https://www.youtube.com/watch?v=XjlFoND00oY](https://www.youtube.com/watch?v=XjlFoND00oY)

if all philosophers are allowed to take a chopstick(fork), all will have one chopstick and none will ever eat

Dijkstra proposed resource ordering the chopsticks

- the last philosopher had to request the zero numbered chopstick before he could request the chopstick number 4
    - you’re not allowed to request the higher resource until you release the lower resource

Another solution is to have a semaphore to prevent the fifth philosopher from entering the room

- a semaphore is constructed with 4 signals queued, and the philosopher must request access to the room before requesting access to any chopstick
    - when the philosophers walk in the room each one calls **wait**
    - and the first four philosophers that call wait in order to enter the room are allowed immediate access
    - but the last one will cause that semaphore to go negative, and he will be put one a wait state outside the room
    - the first philosopher gets two chopsticks, and eat. when he finishes, he puts down the chopsticks and leaves the room.
    - the fifth philosopher enters the room