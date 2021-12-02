# 1. Fundamentals of System Hardware

Created: December 1, 2021 8:22 PM
Lecture: Computer Hardware and Operating Systems
Type: CS, Lecture

## What is a Computer?

The computer is an electromechanical device which takes **input**, does **processing** and produces **output**.

- electromecanical device: has some electronics and some mechanics
- input:
    - electronic signals
    - keys punched on a keyboard
    - movement of a mouse
    - button that a user presses in the form of an electronic game
    - etc

### Types of Computers

Desktop, tablet, portable phone, laptop...:

- input: mouse, keyboard, touch screen
- output: screen, speaker

Server:

- serve up whatever the content you want them to serve up and they're allowed to via their output device(some connection to a network)

Mainframe(~2000):

- very old, very large unit which did all the computing for one university, one campus, one institution, or one business

### Inside a Computer

Tertiary Storage:

- CD-Rom, DVD, Blu-Ray, tape, SD card slot
- Today there's not a lot of popularity and a lot of things aren't coming on CDs or DVDs anymore, so you may not even find these in today's computer
- This is the OFFLINE storage system

Power Supply:

- Provides clean conversion from line voltage to 12V and 5V needed inside the machine

Mainboard/Motherboard:

- Provides physical connectivity for all of the devices, included the system bus and all peripheral buses
- If the CPU is the brain, this is the circulatory system!
- Where all the information is going to come → sort of a gateway/pathway for connectivity, as well as passing information
- ↔ Mac's logicboard: includes more components than PC's motherboard, so it costs more. But you have to put everything on top of the motherboard.

Video Card/GPU:

- Stores information to display on the screen, can do complex calculations related to decimal numbers
- Does outputting of the processing of information for output and then puts it out in an electronic form to be connected to a screen

CPU:

- The "brain" of the computer, this is where all calculations are done
- Registers, the CU and ALU, L1 and L2 caches are all here
- Silicon wafer that has all the logic for the entire commands for the computer built into it

RAM(Main Memory):

- Primary Storage
- This is where code and data are stored
- When the computer is shutdown, this is lost → poor for long-term storage

Secondary Storage:

- Hard Drive or Solid State, this is the permanent storage system of the computer
- When the computer shuts off, the hard drive retains all the information

### What's Common Between Them?

All computers have:

- at least one Central Processing Unit(CPU) which is the "brain" of the computer
- main memory where code and data is stored temporarily
- secondary storage where information is stored permanently

Most computers will have

- a video graphic controller where images can be rendered for display on a screen → GPU(Graphics Processing Unit) purely does arithmetic operations which CPU is very poor at
    
    [NVIDIA Deep Learning Frameworks](https://docs.nvidia.com/deeplearning/performance/dl-performance-gpu-background/index.html)
    
    - as we mine more bitcoins the arithmetic calculations get progressively harder and harder to complete and so it takes much longer to do it on a CPU → we had to resort to using GPUs to do the mining tasks
- a network interface for communications
- a peripheral interface will have some sort of connectivity to external devices → E.g. USB, Thunderbolt, FireWire, SCSI, HDMI etc
    
    ![FireWire](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/firewire.jpg)
    
    FireWire
    
    - connecting to additional devices that are outside of the unit

### Communications Between the Devices

Internal communication in a machine is done via a "bus"

A but is a physical pathway for communication between two or more devices

The system bus is the main pathway between the CPU and main memory, but also carries data to and from Input and Output(IO) devices

![systembus.png](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/systembus.png)

- the system bus literally **drives around** all day long just waiting for data to need to be transferred from one component to the next
- you have buses these days that are internal to the system as well as external to the system
    - USB(Universal Serial **Bus**): the communication mechanism between the core of the system and external devices like webcam, keyboard, mouse etc
- the system bus is the main pathway between the brain(the processing power) of the computer and the storage unit(main memory)

![pmbus.jpg](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/pmbus.jpg)

- It is essential that the system bus be as fast as it possibly can be
    - the CPU has an unbelievably limited amount of storage but it can't do much of anything for a very long period of time
        
        → it has to constantly be able to communicate with main memory to bring in new information that has to be processed and send the result back
        

## The CPU

The CPU is the "brain" of the computer

It is a single piece of silicon in the form of a chip

- inside of a CPU, there are millions, billions of transistors which act as a gate
    - transistor: acts as a pathway to either allowing or denying an electrical conduit for passing of electrons

This is the only location in the machine where code is actually executed in the system

- code we write is dumb down to machine language(== compiled into a machine language form) that this specific CPU understands

The CPU only runs "machine language" code

![cpuandmachinelanguage.gif](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/cpuandmachinelanguage.gif)

- machine language code: the basics of all the work that's done inside the computer system

The CPU operates on a "fetch-decode-execute" cycle

![fetchdecodeexecute.png](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/fetchdecodeexecute.png)

Each type of CPU has its own [set of "instructions"](https://en.wikipedia.org/wiki/Instruction_set_architecture) which is understands

![instructionset.jpg](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/instructionset.jpg)

A CPU may have a "cache" memory to perform more quickly

### Machine Language

CPU has a very limited capability

CPU does not know about "for loop" or "if statement"

→ those higher-level languages have to be converted down into machine language which CPU can understand

- computers can only understand very basic commands like:
    - Move
    - Add
    - Subtract
    - Multiply
    - Compare
    - Jump: the basis of "for loop" or "if statement"
    - etc

The designer of the CPU puts the capability to perform these operations in the physical chip

### Instruction Set

The designers of the CPU create a set of instructions that the CPU can perform

This set of instructions, usually as small as 100, can each be represented by a numeric value

When the CPU receives a particular instruction, it performs that task

![instructionset2.png](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/instructionset2.png)

- 처음 인텔 CPU가 알아들을 수 있는 instruction은 86개였음(x86)
- 그러다 286, 386, 486이 되고(new generations), Pentium이 되고...
- Python doesn't execute your code per se, it uses your code as a guide to executing instructions on the system.

### Fetch-Execute Cycle

The processor doesn't have enough storage to keep an entire program

The CPU performs a fetch to move the instruction from main memory into the CPU(specifically into an instruction register)

It then decodes the instruction, also moving in any additional data that might be necessary with that instruction

It then executes that instruction

This process repeats with the next instruction in the sequence

This whole process takes about some nanoseconds → the CPU can process millions of instructions per second.

## Memory

The instruction, and all the data, has to come from somewhere

In order for code to be executed, it has to be in a register built into the CPU

Why not just store everything in registers?

- Registers are very specialized and they are very EXPENSIVE
- Main Memory can be a short-term storage solution which can feed information continuously to the CPU in the form of instructions as well as data to be processed + it can also store things for a much longer period of time than the registers because there's more of it
    
    → Main Memory is slower than the registers but we have more of it
    

As memory gets faster, it tends to get more expensive

→ We have a hierarchy

### The Hierarchy

![memoryheirarchy.png](1%20Fundamentals%20of%20System%20Hardware%2007f9c01bb1924089b1a974cd27d70233/memoryheirarchy.png)

Trade off: Speed ↔ Size

### RAM

RAM(Random Access Memory):

- any place in it can be accessed in the same amount of time(which is not necessarily true for older secondary storage)
- RAM is broken down into **bytes** so each individual byte has an address and is able to be accessed independently
- one byte in one address
- RAM의 크기가 (4GB 이상으로) 커지면서 주소의 capability도 커져야 했음(32bit → 64bit)
- When the computer is turned off, everything in RAM is lost
    - Most of the system is completely off when you close your laptop(sleep mode), but we're still drawing a little bit of energy from the battery to keep the RAM alive

When running a program, all the machine language instructions are brought into RAM and, one-by-one, pulled into the CPU by the fetch and execute cycle

### Secondary Storage

Hard disk drive(HDD) (aka. spinning drive):

- contain multiple magnetic material discs which rotate together at a constant velocity
- contain read heads which move to different radii on the disk
- allow the system to access any position via it's three dimensional polar coordinates
- accessing first the innermost radius then the outermost radius takes significantly longer than two adjacent radii ⇒ **slow**
- size is usually measured in terabytes ⇒ **large** capacity storage

⇒ for servers

Solid-state disk(SSD):

- contain a number of chips like USB flash drives
- data is stored, electrically, in these chips
- all data an be access in the same amount of time
- due to cost, these drives a **smaller** than HDDs but perform much **faster**

⇒ for laptops, desktops, mobile phones, watches..