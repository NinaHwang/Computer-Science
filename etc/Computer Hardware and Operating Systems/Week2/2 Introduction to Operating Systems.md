# 2. Introduction to Operating Systems

Created: December 3, 2021 6:09 PM
Lecture: Computer Hardware and Operating Systems
Type: CS, Lecture

## What Is an OS?

Operating System: A program that controls execution of application programs and acts as an interface between applications and computer hardware

- Software which manages "the system" as a whole
- OS is responsible for
    - taking care of all the hardware
    - managing the applications access to the hardware
- Acts as a manager of all the hardware in the system
- Runs on the same processor as the user's program code
- Does not include applications
    - applications are completely separate entity
    - OS will manage system resources and provide them to the application

## Layers of Interaction

![os.png](2%20Introduction%20to%20Operating%20Systems%2007568084d3824d27ab57a242839cd1ed/os.png)

OS has to know about the hardware that underlies the system

- the OS has to be custom tailored to that (hardware) architecture
    
    → the application don't necessarily have to be tailored for that architecture
    
    → the applications can be written more generically 
    

## The Kernel

The core component of the OS

Responsible for managing system resources

Assists applications with performing work

Nothing runs without the kernel

[Kernel (operating system) - Wikipedia](https://en.wikipedia.org/wiki/Kernel_(operating_system))

### What You Buy in the Store

The OS is only a small portion of what you buy!

Extra stuff includes:

- web browsers
- text editors
- device drivers
- other applications

Fundamentally, the kernel is the operating system → memory management, process scheduling

## The OS as a Resource Manager

Memory

- while today's computers have lots of memory.. it is still **finite**
    - at some point, you're gonna run out of your memory
- OS needs to allocate the memory to the applications that want that memory

CPU time

- Many applications run on a few of CPUs
    - the CPU is the only place where the applications can actually do any of their processing
- OS needs to allocate CPU time
    - all of the applications compete for the CPU time(resource)

⇒ OS is a software → it has to allocate some of those resources for itself

### Monitoring Running Programs

Keeps track of all running programs in the system in order to manage:

- resource allocation
- scheduling
- authorization

In the modern OS:

- Many programs can be loaded, all at the same time
- The same program could be loaded multiple times
    - we need a way to track multiple instances of the same program running on a system:
        
         ⇒ A **PROCESS** (a program in a running state)
        

## OS Levels

| Level | Name | Description |
| --- | --- | --- |
| 13 | Shell | where the user interacts with |
| 12 | User Processes | actual applications that the user wants to use |
| 11 | Directories | uses the resources of level 9  |
| 10 | Devices | e.g. USB camera, video devices |
| 9 | File Systems | orders and structures things on the secondary storage in an even more detailed environment
e.g. filenames, directories |
| 8 | Communiations | passing information outside the OS to other devices or system hardware
e.g. modem, printer.. |
| 7 | Virtual Memory | divides and segregates portions of main memory
dividing and allocating resource in main memory |
| 6 | Secondary Storage | it needs a manager(software) to decide where thing go on that secondary storage |
| 5 | Primitive Processes | e.g. system scheduling |
| 4 | Interrupts | pieces of hardware telling us(operating systems designers) that it needs servicing |
| 3 | Procedures |  |
| 2 | Processor Instruction Set | OS are tailored to specific processor instruction set(== processor architecture) |
| 1 | Electroni Circuits | computer architecture problems |

Level 1 ~ 4: Hardware

Level 5 ~ 7: Actual kernel of the OS

Level 8 ~ 13: Other OS

## The Windows Model

![Screen Shot 2021-12-04 at 12.32.56.png](2%20Introduction%20to%20Operating%20Systems%2007568084d3824d27ab57a242839cd1ed/Screen_Shot_2021-12-04_at_12.32.56.png)

⇒ Today, the OS proxies all the requests to hardware. So if a program starts to do something awry, the OS can step in and make sure that the system doesn't crash.

### The HAL

Different types of systems have slightly different hardware → Intel 말고도 다른 아키텍쳐를 사용하던 시절, 그 아키텍쳐에 맞게 같은 window여도 여러 버전의 OS를 만들어야 했음. → Fundamentals of the OS did not change. What really changed was the HAL

The HAL:

- The Hal is a layer which can provide the kernel with a set of functions to call which program the hardware properly
- Acts as a proxy → the OS would ask the HAL to do a task and the HAL would figure out how to do that for the architecture that it was installed on
- The HAL can be re-written to support the new architecture

### Windows Device Drivers

Devices drivers are kernel-layer software written by companies that design hardware

They provide functions for the kernel to call in order to access the hardware

They were the cause of frequent "blue screening" before Windows Hardware Quality Labs(WHQL) → MS certifies the driver

### UNIX

A multi-user, multi-tasking OS

Designed to allow users to manage their own tasks

Released into public domain as open source software

Comes in many different flavors: Linux, AIX, Solaris, etc...

Has been modified many, many times!