# 3. Processes and Threads

Created: December 8, 2021 11:21 PM
Lecture: Computer Hardware and Operating Systems
Type: CS, Lecture

## What is a Process?

A running program in a system state

- includes code, data, context
- is stored in sequential memory space

Process is created by OS to keep track of:

- state of the running program
- resources assigned to the running program

⇒ Idea of the process is absolutely critical to the execution of the operating system because that's how we keep track of programs that are actually running and doing work the user wants to do

### State Definition

A condition that the process will spend a significant amount of time in

[Five state process model](https://cse.buffalo.edu/~bina/cse421/spring00/lec3/tsld008.htm)

![Untitled](3%20Processes%20and%20Threads%20d38a721180824630aa8045f19b2e8b0d/Untitled.png)

Suspension:

- The process is completely removed from main memory
- We have to go back to the exact point where we left off
    
    → we cannot throw away all the information from this process
    
    → we are gonna have to save it out (== suspend the process)
    
- Process is stored on secondary storage for future return to the point we left off
- Frees main memory for other processes
- Controlled by medium-term scheduling algorithm
- The process will NOT be aware of the suspension
- Some reasons for suspension
    - Debugging
    - Long term delay
    - Freeing main memory

Seven state process model

![Untitled](3%20Processes%20and%20Threads%20d38a721180824630aa8045f19b2e8b0d/Untitled%201.png)

ready/suspended → ready:

- takes significant amount of time including an i/o operation
    
    → we don't wanna do this on a regular basis
    
    → use this as an emergency measure to bring additional processors or to free up some main memory
    

### Process Image - The PCB

The operating system is gonna need to keep track of all the processes that are running → The Process Control Block

The PCB:

- includes all the information the OS needs to run and control the process

![Untitled](3%20Processes%20and%20Threads%20d38a721180824630aa8045f19b2e8b0d/Untitled%202.png)

- OS Control Structure
    
    Memory Tables: useful for paging and segmentation
    
    I/O Tables: which devices the process has access to
    
    File Tables: which files the process has access to
    
    Call Stack(Processes): the call stack including all active functions
    

[Process control block - Wikipedia](https://en.wikipedia.org/wiki/Process_control_block)

Contents of a PCB

- Process ID
- Parent process ID
- User ID
- Registers
- Stack pointers
- Scheduling
- Linkages
- Inter Process Communication(IPC)
- Resources
- Memory

### Modes

Inside the registers, there is one register known as the program status word(the PSW register)

In most processors, the Program Status Word(PSW) register tells the system which mode it's in

Inside the PSW register there's one single bit that tells the whole system whether it's in:

- kernel mode and can do anything that it likes
    - the code that's gonna run has access to any portion of the system
- user mode and mom and dad are watching really closely
    - we cannot directly access any system hardware
    - we can't run certain CPU instructions which might give us more access than we're supposed to have
    - we can't access any memory outside of that process

Each process runs as if it's living on its own island in the middle of a very large ocean, and they cannot communicate with any other processes that are running  on the entire system

![Untitled](3%20Processes%20and%20Threads%20d38a721180824630aa8045f19b2e8b0d/Untitled%203.png)

Switching between user mode and kernel mode:

- easy to go from Kernel to User
- User to Kernel happens automatically upon certain events

### When to Process Switch

Process switches occur a lot

When does a switch occur

- Interrupt - a hardware signal indicating that the hardware need servicing (immediate attention), for example:
    - the memory buffer for the network card is filling up
    - the secondary storage device that we made a request for a file from has completed that request and now it wants to let you know that it would like another request when you're available
- Trap - a condition which requires OS support
    - the program doesn't realize that the performing something that involves the OS but the OS recognizes that and it takes over and starts executing
- Blocking System Call - a request from the process for OS support

### Steps to Process Switch (Context Switch)

- Save the context into the PCB
- Update accounting
- Move the PCB to the appropriate queue
- Choose another process
- Update memory management
- Restore its context

![Untitled](3%20Processes%20and%20Threads%20d38a721180824630aa8045f19b2e8b0d/Untitled%204.png)

### Multiple Processors

Unless we created a computer system with enough processors for each process-which would be horribly expensive-, we simply can't make these problems that we have with process switching and the five-state process model, we can't make them go away.

The problems will actually become a little bit more complex if we go with multiple processors because now we're going to be talking about what we call symmetric multiprocessing and now we're going to create situations where two processes can actually physically be running at the same time, not just conceptually

We are making the problems happen less often, but they're still happening just the same

⇒ The solution is not to throw more hardware at the problem, but to solve the problem first and foremost that we deal with processes

## Threads

Resource ownership and Execution are two different issues

- Resource ownership now becomes the only concern of the process
- Execution - scheduling and running PARTS, yes there will be many, of the process become threads

⇒ Although there's only one process that process may have contained in it lots of different threads. Each one doing a component of the work to get the whole job done.

### What is Where in the Multithreaded Environment

Multi-threaded environment is one in which we have lots of threads for an individual process

Process - Process Control Block

- memory allocation
- files
- linkages

Thread - Thread Control Block

- context(processor registers)
- stack(incl. local variables)
- access to all of the resources of the thread

### Reasons for Multithreading

- Foreground/Background
- Asynchronous processing
- Infrequent tasks
- Speed reading
- Synchronous processing
- Modular program structure

### Thread States/Operation

Ready, Running and Blocked

Threads don't need New or Exit

- No "new" state: it doesn't have to be created
    
    → simply initialize a TCB, set it up as a part of the process, and then the thread is ready to go
    
- No "exit" state: when the thread exits, it simply destroyed.
    
    → the TCB is thrown on to the garbage heap and then we move on
    

Suspension is a process level concept

### What are the Downsides

CONCURRENCY!!!!

→ issues with sharing the memory

Overuse of threads leading to confusion

### Implementation of Threads

Kernel-Level threads

- different from Kernel Threads(where the OS is threaded)

User Level Threads

- downsides of ULTs

Hybrid approach

- Light Weight Process

[Difference between User Level thread and Kernel Level thread - GeeksforGeeks](https://www.geeksforgeeks.org/difference-between-user-level-thread-and-kernel-level-thread/)

[유저 레벨 스레드(user level thread) / 커널 레벨 스레드(kernel level thread)](https://genesis8.tistory.com/242)

Thread Scheduling details